import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_bloc/bloc/auth/auth_bloc.dart';
import 'package:note_app_bloc/view/screens/auth_screen.dart';
import 'package:note_app_bloc/view/screens/home_bloc_screen.dart';
import 'package:note_app_bloc/view/widgets/custom_dialog.dart';

class AuthBlocScreen extends StatelessWidget {
  // final bool isLogin;
  const AuthBlocScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        final error = state.authError;
        if (error != null) {
          customDialog(context, DialogType.error, error.dialogTitle,
              error.dialogText, "OK", () {});
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedOut) {
          return AuthScreen(isLogin: true);
        } else if (state is AuthStateIsInRegistrationView) {
          return AuthScreen(isLogin: false);
        } else if (state is AuthStateLoggedIn) {
          return HomeBlocScreen();
        }
        return Container();
      },
    );
  }
}
