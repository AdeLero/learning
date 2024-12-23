part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthCheckRequested extends AuthEvent {}

class AuthSignedIn extends AuthEvent {
  final String email;
  final String password;

  AuthSignedIn({
    required this.email,
    required this.password,
  });
}

class AuthSignedUp extends AuthEvent {
  final String email;
  final String password;

  AuthSignedUp({
    required this.email,
    required this.password,
  });
}

class AuthSignedOut extends AuthEvent {}

class UpdateUserCredentials extends AuthEvent {
  final String userName;
  final String? image;

  UpdateUserCredentials({required this.userName, required this.image});
}


