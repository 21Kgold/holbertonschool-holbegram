import 'package:flutter/material.dart';

// Stateless widgets are immutable
class TextFieldInput extends StatelessWidget {
  const TextFieldInput({
    super.key,
    required this.controller,
    required this.ispassword,
    required this.hintText,
    this.suffixIcon,
    required this.keyboardType
  });

  final TextEditingController controller;
  final bool ispassword;
  final String hintText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_declarations
    final borderStyle = const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none)
        );

    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      cursorColor: const Color.fromARGB(218, 226, 37, 24),
      decoration: InputDecoration(
        hintText: hintText,
        border: borderStyle,
        focusedBorder: borderStyle,
        enabledBorder: borderStyle,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
        suffixIcon: suffixIcon,       
      ),
      textInputAction: TextInputAction.next,
      obscureText: ispassword,
    ) ;
  }
}
