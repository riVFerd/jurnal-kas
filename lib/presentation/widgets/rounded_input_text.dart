import 'package:flutter/material.dart';

import '../constants/color_constant.dart';

class RoundedInputText extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  const RoundedInputText(
      {super.key, required this.hintText, this.controller, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF1F4FF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        hintText: hintText,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: blue,
            width: 2,
          ),
        ),
      ),
    );
  }
}
