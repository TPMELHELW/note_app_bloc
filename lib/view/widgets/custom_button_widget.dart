import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onPress;
  const CustomButtonWidget({
    super.key,
    required this.child,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            minimumSize: const Size(50, 60),
            maximumSize: const Size(100, 100),
          ),
          child: child),
    );
  }
}
