import 'package:flutter/material.dart';

class AuthText extends StatelessWidget {
  final String text;
  final FontWeight style;
  final double size;
  final Color? color;
  const AuthText({
    super.key,
    required this.text,
    required this.style,
    required this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'rubik',
        fontSize: size,
        fontWeight: style,
        color: color ?? Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }
}
