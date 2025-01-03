import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  final void Function(BuildContext context) onCreate;

  const BottomNavbar({super.key, required this.onCreate});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (index == 1) {
          onCreate(context);
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.view_list),
          label: 'Todo',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box_outlined),
          label: 'Create',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_box_outlined),
          label: 'Done',
        ),
      ],
    );
  }
}
