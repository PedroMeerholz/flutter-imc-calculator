import 'package:flutter/material.dart';

class ImcTextField extends StatelessWidget {
  final String labelText;
  final String? Function(String? value) validatorFunction;
  final TextEditingController controller;
  const ImcTextField({super.key, required this.controller, required this.labelText, required this.validatorFunction});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.lightGreen,
        ),
      ),
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.lightGreen,
        fontSize: 20,
      ),
      controller: controller,
      validator: validatorFunction,
    );
  }

}