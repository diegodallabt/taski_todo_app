import 'package:flutter/material.dart';

class CheckBoxComponent extends StatelessWidget {
  final bool isDone;
  final ValueChanged<bool?>? onChanged;

  const CheckBoxComponent(
      {super.key, required this.onChanged, this.isDone = false});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Color.fromARGB(120, 196, 208, 218),
      visualDensity: VisualDensity.compact,
      side: BorderSide(
        width: 1.4,
        color: const Color.fromARGB(120, 110, 133, 150),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      value: isDone,
      onChanged: onChanged,
    );
  }
}
