part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

@immutable
class AuthEventFieldChange extends AuthEvent {}

@immutable
class AuthEventLogIn extends AuthEvent {
  final String email, passowrd;
  final GlobalKey<FormState> formState;
  final BuildContext context;

  AuthEventLogIn(
    this.formState,
    this.context, {
    required this.email,
    required this.passowrd,
  });
}

@immutable
class AuthEventSignUp extends AuthEvent {
  final String email, password, firstName, lastName;
  final GlobalKey<FormState> formState;
  final BuildContext context;

  AuthEventSignUp(
    this.formState,
    this.context,
    this.firstName,
    this.lastName, {
    required this.email,
    required this.password,
  });
}

@immutable
class AuthEventGoToLogIn extends AuthEvent {}

@immutable
class AuthEventGoToSignUp extends AuthEvent {}

@immutable
class AuthEventLogOut implements AuthEvent {
  const AuthEventLogOut();
}

@immutable
class AuthEventInitialize implements AuthEvent {
  const AuthEventInitialize();
}
