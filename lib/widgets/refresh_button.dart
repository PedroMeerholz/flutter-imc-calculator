import 'package:flutter/material.dart';

class RefreshButton extends StatelessWidget {
  final Function onpressedFunction;

  RefreshButton({super.key, required this.onpressedFunction});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onpressedFunction();
      },
      icon: const Icon(Icons.refresh),
    );
  }
}