part of 'auth_bloc.dart';

// Clase abstracta que define los estados relacionados con la autenticación
@immutable
sealed class AuthState {
  const AuthState();
}

// Estado inicial de autenticación
final class AuthInitial extends AuthState {}

// Estado de carga durante el proceso de autenticación
final class AuthLoading extends AuthState {}

// Estado de éxito de autenticación con el usuario autenticado
final class AuthSuccess extends AuthState {
  final PortalNewsUser uid; // Identificación del usuario

  const AuthSuccess(this.uid);
}

// Estado de fallo durante el proceso de autenticación
final class AuthFailure extends AuthState {
  final String message; // Mensaje de error

  const AuthFailure(this.message);
}
