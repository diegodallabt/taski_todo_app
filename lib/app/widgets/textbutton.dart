import 'package:flutter/material.dart';

class TextButtonComponent extends StatelessWidget {
  final void Function() onTap;
  final Color color;
  final String label;
  final double fontSize;
  final FontWeight fontWeight;
  final Color splashColor;
  final Color highlightColor;

  const TextButtonComponent(
      {super.key,
      required this.onTap,
      this.color = Colors.blue,
      this.label = 'Button',
      this.fontSize = 16,
      this.fontWeight = FontWeight.w500,
      this.splashColor = Colors.transparent,
      this.highlightColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: highlightColor,
      splashColor: splashColor,
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
