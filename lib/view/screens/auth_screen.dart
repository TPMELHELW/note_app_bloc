import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_bloc/bloc/auth/auth_bloc.dart';
import 'package:note_app_bloc/view/widgets/auth/auth_view.dart';
import 'package:note_app_bloc/view/widgets/custom_dialog.dart';

class AuthScreen extends StatelessWidget {
  final bool isLogin;
  const AuthScreen({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/1.jpg",
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Align(
            alignment: Alignment.bottomCenter,
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(183, 42, 46, 50),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          final error = state.authError;
                          if (error != null) {
                            customDialog(
                                context,
                                DialogType.error,
                                error.dialogTitle,
                                error.dialogText,
                                "OK",
                                () {});
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthStateLoggedIn) {
                          } else if (state is AuthStateLoggedOut) {
                            return const AuthView(
                              isLogin: true,
                            );
                          } else if (state is AuthStateIsInRegistrationView) {
                            return const AuthView(
                              isLogin: false,
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
