import 'package:firebase_auth/firebase_auth.dart';
import 'package:reto_asap/core/error/exceptions.dart';
import 'package:reto_asap/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  User? get currentUserSession;
  // Método para registrar un nuevo usuario con un correo electrónico y contraseña.
  // [email]: El correo electrónico del usuario.
  // [password]: La contraseña del usuario.
  // Retorna un [Future] que contiene el ID único del usuario registrado.
  Future<UserModel> signUpWithEmailPassword({
    required name,
    required email,
    required password,
  });

  // Método para iniciar sesión con un correo electrónico y contraseña.
  // [email]: El correo electrónico del usuario.
  // [password]: La contraseña del usuario.
  // Retorna un [Future] que contiene el ID único del usuario autenticado.
  Future<UserModel> loginWithEmailPassword({
    required email,
    required password,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // final FirebaseAuth firebaseAuth;

  // AuthRemoteDataSourceImpl(this.firebaseAuth);

  @override
  User? get currentUserSession => FirebaseAuth.instance.currentUser;

  @override
  Future<UserModel> loginWithEmailPassword(
      {required email, required password}) async {
    try {
      // Registra un nuevo usuario en Firebase Auth con el correo electrónico y la contraseña proporcionados.
      final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Lanza una excepción si el usuario es nulo.
      if (response.user == null) throw const ServerException('User is null');
      // Retorna el UID (identificador único) del usuario registrado.
      // return UserModel.fromJson(jsonDecode(response.user.toString()));
      return UserModel.fromJson(response.user!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      // Captura cualquier excepción lanzada durante el proceso y la convierte en una ServerException.
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword(
      {required email, required password, required name}) async {
    try {
      // Registra un nuevo usuario en Firebase Auth con el correo electrónico y la contraseña proporcionados.
      final response =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Lanza una excepción si el usuario es nulo.
      if (response.user == null) throw const ServerException('User is null');
      // Retorna el UID (identificador único) del usuario registrado.
      // return UserModel.fromJson(jsonDecode(response.user.toString()));
      await response.user!.updateDisplayName(name);
      return UserModel.fromJson(response.user!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      // Captura cualquier excepción lanzada durante el proceso y la convierte en una ServerException.
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final User? firebaseUser = currentUserSession;
        return UserModel.fromJson(firebaseUser!);
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
