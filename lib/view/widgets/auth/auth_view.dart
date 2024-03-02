import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:note_app_bloc/bloc/auth/auth_bloc.dart';
import 'package:note_app_bloc/view/widgets/auth/auth_button.dart';
import 'package:note_app_bloc/view/widgets/auth/auth_form.dart';
import 'package:note_app_bloc/view/widgets/auth/auth_text.dart';
import 'package:note_app_bloc/view/widgets/auth/auth_text_button.dart';

class AuthView extends HookWidget {
  final bool isLogin;
  const AuthView({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formState = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    // final mahm = useState(initialData)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthText(
          text: isLogin ? "Welcome!" : "Registration",
          style: FontWeight.bold,
          size: 20,
        ),
        const SizedBox(
          height: 10,
        ),
        AuthText(
          text: isLogin ? "Join us and type your notes" : "Make your account",
          style: FontWeight.w300,
          size: 15,
        ),
        const SizedBox(
          height: 10,
        ),
        AuthForm(
          isLogin: isLogin,
          emailController: emailController,
          passwordController: passwordController,
          formState: formState,
        ),
        const AuthTextButton(text: "Forget Passowrd?"),
        AuthButton(
          text: isLogin ? "Login" : "Continued",
          onPress: () => isLogin
              ? context.read<AuthBloc>().add(
                    AuthEventLogIn(
                      formState,
                      email: emailController.text,
                      passowrd: passwordController.text,
                    ),
                  )
              : context.read<AuthBloc>().add(
                    AuthEventSignUp(
                      formState,
                      context,
                      email: emailController.text,
                      password: passwordController.text,
                    ),
                  ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Row(
          children: [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'or',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLogin ? 'Don’t have an account?' : "Joined us before?",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
            AuthTextButton(
                text: isLogin ? 'Registration' : 'Login',
                onPress: () {
                  isLogin
                      ? context.read<AuthBloc>().add(AuthEventGoToSignUp())
                      : context.read<AuthBloc>().add(AuthEventGoToLogIn());
                })
          ],
        )
      ],
    );
  }
}
