import 'package:flutter/material.dart';

class GreenConfirmationButton extends StatelessWidget {

  final void Function() onPressedFunction;
  GreenConfirmationButton({super.key, required this.onPressedFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: ElevatedButton(
        onPressed: onPressedFunction,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightGreen,
        ),
        child: const Text(
          'Calcular',
        ),
      ),
    );
  }

}