import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final void Function(BuildContext context) onCreate;
  const BottomNavbar({
    super.key,
    required this.onCreate,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        switch (index) {
          case 0:
            Modular.to.navigate('/');
            break;
          case 1:
            onCreate(context);
            break;
          case 2:
            Modular.to.navigate('/search');
            break;
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
