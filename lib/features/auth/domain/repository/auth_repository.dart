import 'package:dartz/dartz.dart';
import 'package:reto_asap/core/error/failures.dart';
import 'package:reto_asap/core/entities/user.dart';

abstract interface class AuthRepository {
  // Método para registrar un nuevo usuario con un correo electrónico y contraseña
  // [email]: El correo electrónico del usuario
  // [password]: La contraseña del usuario
  // Retorna un [Future] que contiene un [Either] que puede ser un [Failure] si ocurre un error o un [String] con un mensaje de éxito
  Future<Either<Failure, PortalNewsUser>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  // Método para iniciar sesión con un correo electrónico y contraseña
  // [email]: El correo electrónico del usuario
  // [password]: La contraseña del usuario
  // Retorna un [Future] que contiene un [Either] que puede ser un [Failure] si ocurre un error o un [String] con un mensaje de éxito
  Future<Either<Failure, PortalNewsUser>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, PortalNewsUser>> currentUser();
}
