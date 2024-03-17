import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:reto_asap/core/cubits/app_user/app_user_cubit.dart';
import 'package:reto_asap/core/error/failures.dart';
import 'package:reto_asap/core/usecase/use_case.dart';
import 'package:reto_asap/features/auth/domain/usecases/current_user.dart';
import 'package:reto_asap/features/auth/domain/usecases/user_login.dart';
import 'package:reto_asap/features/auth/domain/usecases/user_sign_up.dart';
import 'package:reto_asap/core/entities/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

// Bloc para la gestión de la autenticación de usuarios
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp; // Caso de uso para registrarse
  final UserLogin _userLogin; // Caso de uso para iniciar sesión
  final CurrentUser _currentUser; // Caso de uso para obtener el usuario actual
  final AppUserCubit _appUserCubit; // Cubit para el usuario de la aplicación

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    // Define el comportamiento del bloc para diferentes eventos
    on<AuthSigunUpEvent>(_onAuthSignUp);
    on<AuthLoginEvent>(_onAuthSignIn);
    on<AuthIsUserLoggedInEvent>(_isUserLoggedIn);
  }

  // Método privado para verificar si el usuario está actualmente autenticado
  void _isUserLoggedIn(
      AuthIsUserLoggedInEvent event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());

    res.fold(
      // Si hay un fallo, emite un estado de fallo
      (failure) => left(Failure(failure.message)),
      // Si hay éxito, actualiza el usuario y emite un estado de éxito de autenticación
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  // Método privado para manejar el evento de registro de usuario
  void _onAuthSignUp(AuthSigunUpEvent event, Emitter<AuthState> emit) async {
    // Método asincrónico que emite un estado de carga y luego procesa el registro del usuario
    (event, emit) async {
      emit(AuthLoading());
      final res = await _userSignUp(UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ));

      res.fold(
        // Si hay un fallo, emite un estado de fallo
        (failure) => emit(AuthFailure(failure.message)),
        // Si hay éxito, actualiza el usuario y emite un estado de éxito de autenticación
        (user) => _emitAuthSuccess(user, emit),
      );
    };
  }

  // Método privado para manejar el evento de inicio de sesión
  void _onAuthSignIn(AuthLoginEvent event, Emitter<AuthState> emit) async {
    // Emite un estado de carga y luego procesa el inicio de sesión del usuario
    emit(AuthLoading());
    final res = await _userLogin(UserLoginParams(
      email: event.email,
      password: event.password,
    ));

    res.fold(
      // Si hay un fallo, emite un estado de fallo
      (failure) => emit(AuthFailure(failure.message)),
      // Si hay éxito, actualiza el usuario y emite un estado de éxito de autenticación
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  // Método privado para emitir un estado de éxito de autenticación
  void _emitAuthSuccess(PortalNewsUser user, Emitter<AuthState> emit) {
    // Actualiza el usuario en el cubit de usuario de la aplicación
    _appUserCubit.updateUser(user);
    // Emite un estado de éxito de autenticación con el usuario
    emit(AuthSuccess(user));
  }
}
