import 'package:flutter/material.dart';

class CheckBoxComponent extends StatelessWidget {
  final ValueChanged<bool?>? onChanged;

  const CheckBoxComponent({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      visualDensity: VisualDensity.compact,
      side: BorderSide(
        width: 1.4,
        color: const Color.fromARGB(120, 110, 133, 150),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      value: false,
      onChanged: onChanged,
    );
  }
}
