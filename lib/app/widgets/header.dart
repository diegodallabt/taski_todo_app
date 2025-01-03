import 'package:flutter/material.dart';

import '../utils/use_style.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.check_box, color: Colors.blue, size: 36),
            SizedBox(width: 8),
            Text(
              'Taski',
              style: useStyle(
                TextStyle(
                  color: const Color.fromARGB(255, 43, 43, 43),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        Row(
          spacing: 14,
          children: [
            Text(
              'John',
              style: useStyle(
                TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17.5,
                    color: const Color.fromARGB(255, 43, 43, 43)),
              ),
            ),
            CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 228, 228, 228),
              foregroundColor: const Color.fromARGB(255, 228, 228, 228),
              backgroundImage:
                  NetworkImage('https://avatar.iran.liara.run/public'),
            ),
          ],
        ),
      ],
    );
  }
}
