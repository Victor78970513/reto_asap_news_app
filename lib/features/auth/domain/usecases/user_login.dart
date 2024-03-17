import 'package:dartz/dartz.dart';
import 'package:reto_asap/core/error/failures.dart';
import 'package:reto_asap/core/usecase/use_case.dart';
import 'package:reto_asap/features/auth/domain/repository/auth_repository.dart';
import 'package:reto_asap/core/entities/user.dart';

// Caso de uso para el inicio de sesión del usuario
class UserLogin implements UseCase<PortalNewsUser, UserLoginParams> {
  final AuthRepository authRepository;

  UserLogin(this.authRepository);

  @override
  Future<Either<Failure, PortalNewsUser>> call(UserLoginParams params) {
    // Llama al método del repositorio para iniciar sesión con correo electrónico y contraseña
    return authRepository.loginWithEmailPassword(
        email: params.email, password: params.password);
  }
}

// Parámetros necesarios para el inicio de sesión del usuario
class UserLoginParams {
  final String email; // Correo electrónico del usuario
  final String password; // Contraseña del usuario

  UserLoginParams({required this.email, required this.password});
}
