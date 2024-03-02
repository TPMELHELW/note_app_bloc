import 'package:flutter/material.dart';
// import 'package:note_app_bloc/bloc/bloc/auth_bloc.dart';

class AuthTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Key index;
  final TextEditingController controller;
  final String? Function(String?)? valid;
  const AuthTextField({
    super.key,
    required this.hint,
    required this.icon,
    required this.index,
    required this.controller,
    this.valid,
  });

  @override
  Widget build(BuildContext context) {
    // bool? isTap = AuthBloc.get(context).tap[index];
    bool isTap = false;
    return TextFormField(
      validator: valid,
      controller: controller,
      decoration: InputDecoration(
        focusColor: Colors.white,
        hintText: hint,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.grey,
        ),
        contentPadding: const EdgeInsets.all(8),
        filled: true,
        fillColor: isTap == true ? Colors.black : const Color(0xFF5c5c5c),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none),
      ),
      onTap: () {
        // AuthBloc.get(context).add(FieldTap(index: index));
      },
    );
  }
}
