import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text(
        'Error Screen',
        style: TextStyle(
          color: Colors.redAccent,
          fontSize: 20,
        ),
      ),
    );
  }
}
