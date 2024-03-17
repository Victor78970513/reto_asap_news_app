import 'package:dartz/dartz.dart';
import 'package:reto_asap/core/error/failures.dart';
import 'package:reto_asap/core/usecase/use_case.dart';
import 'package:reto_asap/features/auth/domain/repository/auth_repository.dart';
import 'package:reto_asap/core/entities/user.dart';

// Caso de uso para el registro de un nuevo usuario
class UserSignUp implements UseCase<PortalNewsUser, UserSignUpParams> {
  final AuthRepository authRepository;

  UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, PortalNewsUser>> call(UserSignUpParams params) async {
    // Llama al método del repositorio para registrar un nuevo usuario con correo electrónico y contraseña
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

// Parámetros necesarios para el registro de un nuevo usuario
class UserSignUpParams {
  final String name; // Nombre del usuario
  final String email; // Correo electrónico del usuario
  final String password; // Contraseña del usuario

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
