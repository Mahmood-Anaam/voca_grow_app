import 'package:flutter/material.dart';

/// Button shown when connected to end the conversation
class DisconnectButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DisconnectButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.close),
      style: IconButton.styleFrom(
        backgroundColor: Colors.red.shade600,
        foregroundColor: Colors.white,
      ),
    );
  }
}
