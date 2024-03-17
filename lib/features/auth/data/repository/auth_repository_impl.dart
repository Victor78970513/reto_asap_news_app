import 'package:dartz/dartz.dart';
import 'package:reto_asap/core/error/exceptions.dart';
import 'package:reto_asap/core/error/failures.dart';
import 'package:reto_asap/core/network/connection_checker.dart';
import 'package:reto_asap/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:reto_asap/features/auth/data/models/user_model.dart';
import 'package:reto_asap/features/auth/domain/repository/auth_repository.dart';
import 'package:reto_asap/core/entities/user.dart';

// Implementación concreta del repositorio de autenticación
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource
      remoteDataSource; // Origen de datos remoto de autenticación
  final ConnectionChecker
      connectionChecker; // Verificador de conexión a Internet

  const AuthRepositoryImpl(this.remoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, PortalNewsUser>> currentUser() async {
    try {
      // Verifica si hay conexión a Internet
      if (!await (connectionChecker.isConnected)) {
        // Si no hay conexión, comprueba si hay una sesión de usuario actual
        final session = remoteDataSource.currentUserSession;
        if (session == null) {
          // Si no hay sesión de usuario, devuelve un error de fallo
          return left(Failure("User not logged in!"));
        }
        // Si hay una sesión de usuario, devuelve el usuario actual
        return right(UserModel(
            id: session.uid,
            email: session.email!,
            name: session.displayName!));
      }
      // Si hay conexión, obtiene los datos del usuario actual
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        // Si no hay datos de usuario, devuelve un error de fallo
        return left(Failure("User not logged in!"));
      }

      // Si hay datos de usuario, devuelve el usuario
      return right(user);
    } on ServerException catch (e) {
      // Si ocurre una excepción en el servidor, devuelve un error de fallo con el mensaje de la excepción
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, PortalNewsUser>> loginWithEmailPassword(
      {required String email, required String password}) async {
    // Método para iniciar sesión con correo electrónico y contraseña
    return _getUser(() async => await remoteDataSource.loginWithEmailPassword(
        email: email, password: password));
  }

  @override
  Future<Either<Failure, PortalNewsUser>> signUpWithEmailPassword(
      {required String email,
      required String password,
      required String name}) async {
    // Método para registrarse con correo electrónico, contraseña y nombre
    return _getUser(() async => await remoteDataSource.signUpWithEmailPassword(
        name: name, email: email, password: password));
  }

  // Método privado para obtener un usuario
  Future<Either<Failure, PortalNewsUser>> _getUser(
      Future<PortalNewsUser> Function() fn) async {
    try {
      // Verifica si hay conexión a Internet
      if (!await (connectionChecker.isConnected)) {
        // Si no hay conexión, devuelve un error de fallo
        return left(Failure('No Internet Connection'));
      }
      // Si hay conexión, obtiene el usuario
      final user = await fn();
      // Devuelve el usuario
      return right(user);
    } on ServerException catch (e) {
      // Si ocurre una excepción en el servidor, devuelve un error de fallo con el mensaje de la excepción
      return left(Failure(e.message));
    }
  }
}
