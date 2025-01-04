import 'package:flutter/material.dart';
import 'package:taski/app/utils/use_style.dart';

class ErrorComponent extends StatelessWidget {
  final String message;
  const ErrorComponent({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(spacing: 10, children: [
        Icon(
          Icons.error_outline,
          color: Colors.grey,
          size: 40,
        ),
        Text(
          message,
          style: useStyle(
            TextStyle(color: Colors.grey),
          ),
        ),
      ]),
    );
  }
}
