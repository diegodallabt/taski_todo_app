import 'package:flutter/material.dart';
import 'package:taski/app/utils/use_style.dart';

class TextFieldComponent extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final TextEditingController controller;

  const TextFieldComponent(
      {super.key,
      required this.hintText,
      required this.onChanged,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        selectionControls: MaterialTextSelectionControls(),
        cursorColor: const Color.fromARGB(255, 110, 133, 150),
        style: useStyle(TextStyle(
            color: const Color.fromARGB(255, 110, 133, 150), fontSize: 16)),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: const Color.fromARGB(120, 110, 133, 150),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
        ),
        onChanged: onChanged);
  }
}
