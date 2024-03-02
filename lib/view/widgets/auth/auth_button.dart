import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_bloc/bloc/auth/auth_bloc.dart';
// import 'package:note_app_bloc/bloc/bloc/auth_bloc.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final void Function()? onPress;
  const AuthButton({
    super.key,
    required this.text,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(50, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child:
              state.isLoading ? const CircularProgressIndicator() : Text(text),
        );
      },
    );
  }
}
