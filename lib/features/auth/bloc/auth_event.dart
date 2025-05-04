part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthSignInRequested extends AuthEvent {
  final String email;
  final String password;
  final UserType userType;

  const AuthSignInRequested({
    required this.email,
    required this.password,
    required this.userType,
  });

  @override
  List<Object?> get props => [email, password, userType];
}

class AuthSignUpRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final UserType userType;

  const AuthSignUpRequested({
    required this.name,
    required this.email,
    required this.password,
    required this.userType,
  });

  @override
  List<Object?> get props => [name, email, password, userType];
}

class AuthResetPasswordRequested extends AuthEvent {
  final String email;
  final UserType userType;
  const AuthResetPasswordRequested({
    required this.email,
    required this.userType,
  });

  @override
  List<Object?> get props => [email, userType];
}

class AuthSignOutRequested extends AuthEvent {
  const AuthSignOutRequested();

  @override
  List<Object?> get props => [];
}

class _AuthUserChanged extends AuthEvent {
  final UserModel user;

  const _AuthUserChanged(this.user);

  @override
  List<Object?> get props => [user];
}
