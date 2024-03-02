part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  final bool isLoading;
  final AuthError? authError;

  const AuthState({
    required this.isLoading,
    this.authError,
  });
}

@immutable
class AuthStateLoggedIn extends AuthState {
  final User user;

  const AuthStateLoggedIn({
    required super.isLoading,
    required this.user,
    super.authError,
  });
}

@immutable
class AuthStateLoggedOut extends AuthState {
  const AuthStateLoggedOut({
    required super.isLoading,
    super.authError,
  });
}

@immutable
class AuthStateIsInRegistrationView extends AuthState {
  const AuthStateIsInRegistrationView({
    required super.isLoading,
    super.authError,
  });
}
