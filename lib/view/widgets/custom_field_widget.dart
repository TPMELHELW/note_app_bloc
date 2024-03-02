import 'package:flutter/material.dart';

class CustomFieldWidget extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  const CustomFieldWidget({
    super.key,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: null,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
