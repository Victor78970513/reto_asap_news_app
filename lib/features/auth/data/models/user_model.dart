import 'package:firebase_auth/firebase_auth.dart';
import 'package:reto_asap/core/entities/user.dart';

class UserModel extends PortalNewsUser {
  UserModel({
    required super.id,
    required super.email,
    required super.name,
  });
  factory UserModel.fromJson(User user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? user.uid,
    );
  }
}
