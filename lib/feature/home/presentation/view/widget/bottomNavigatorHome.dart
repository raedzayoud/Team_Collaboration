import 'package:flutter/material.dart';

class Bottomnavigatorhome extends StatelessWidget {
  final void Function(int)? onTap;
  final int page;
  const Bottomnavigatorhome({super.key, this.onTap, required this.page});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      //backgroundColor: const Color.fromRGBO(26, 26, 26, 1),
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      onTap: onTap,
      currentIndex: page,
      type: BottomNavigationBarType.shifting,
      unselectedFontSize: 14,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: 'HomePage',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.insert_invitation,
          ),
          label: 'Inviatation',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.chat,
          ),
          label: 'ChatRoom',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.groups,
          ),
          label: 'Teams',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings_outlined,
          ),
          label: 'Settings',
        ),
      ],
    );
  }
}
