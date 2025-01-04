import 'package:flutter/cupertino.dart';

import '../utils/use_style.dart';

class NotFoundComponent extends StatelessWidget {
  final String message;
  const NotFoundComponent({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 25,
      children: [
        Image.asset(
          'assets/empty.png',
          width: 100,
        ),
        Text(
          message,
          style: useStyle(
            TextStyle(
              color: const Color.fromARGB(255, 110, 133, 150),
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
