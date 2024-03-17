part of 'auth_bloc.dart';

// Clase abstracta que define los eventos relacionados con la autenticación
@immutable
sealed class AuthEvent {}

// Evento para el registro de un nuevo usuario
final class AuthSigunUpEvent extends AuthEvent {
  final String name; // Nombre del usuario
  final String email; // Correo electrónico del usuario
  final String password; // Contraseña del usuario

  AuthSigunUpEvent({
    required this.email,
    required this.password,
    required this.name,
  });
}

// Evento para el inicio de sesión de un usuario existente
final class AuthLoginEvent extends AuthEvent {
  final String email; // Correo electrónico del usuario
  final String password; // Contraseña del usuario

  AuthLoginEvent({
    required this.email,
    required this.password,
  });
}

// Evento para verificar si un usuario está actualmente autenticado
final class AuthIsUserLoggedInEvent extends AuthEvent {}
