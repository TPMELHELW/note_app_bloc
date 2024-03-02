import 'package:flutter/material.dart';
// import 'package:note_app_bloc/bloc/bloc/auth_bloc.dart';
import 'package:note_app_bloc/view/widgets/auth/auth_text_filed_widget.dart';

class AuthForm extends StatelessWidget {
  final bool isLogin;
  final TextEditingController emailController, passwordController;
  final GlobalKey<FormState> formState;
  const AuthForm(
      {super.key,
      required this.isLogin,
      required this.emailController,
      required this.passwordController,
      required this.formState});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formState,
        child: Column(
          children: [
            AuthTextField(
              valid: (val) {
                if (val!.length < 5) {
                  return 'Not Valid Email';
                }
                return null;
              },
              hint: 'Email address',
              icon: Icons.email_rounded,
              index: isLogin ? const Key('1') : const Key('4'),
              controller: emailController,
            ),
            const SizedBox(
              height: 20,
            ),
            AuthTextField(
              valid: (val) {
                if (val!.length < 5) {
                  return 'Not Valid Passord';
                }
                return null;
              },
              controller: passwordController,
              hint: 'Password',
              icon: Icons.key,
              index: isLogin ? const Key('2') : const Key('5'),
            ),
            SizedBox(
              height: isLogin ? 0 : 20,
            ),
            isLogin == true
                ? const Text('')
                : AuthTextField(
                    valid: (val) {},
                    controller: passwordController,
                    hint: 'Confirm Password',
                    icon: Icons.key,
                    index: const Key('3'),
                  )
          ],
        ),
      ),
    );
  }
}
