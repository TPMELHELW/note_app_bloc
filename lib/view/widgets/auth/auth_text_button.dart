import 'package:flutter/material.dart';

class AuthTextButton extends StatelessWidget {
  final String text;
  final void Function()? onPress;
  const AuthTextButton({
    super.key,
    required this.text,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          elevation: 0,
          minimumSize: const Size(0, 10),
          backgroundColor: Colors.transparent,
          alignment: Alignment.topLeft),
      onPressed: onPress,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.left,
      ),
    );
  }
}
