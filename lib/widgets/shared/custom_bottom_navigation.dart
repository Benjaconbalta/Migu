import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavigation({super.key, required this.currentIndex});

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go("/home/0");
        break;
      case 1:
        context.go("/home/1");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value) {
        onItemTapped(context, value);
      },
      elevation: 0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.book,color: Color(0xff3D9A51),), label: "Carnet"),
        BottomNavigationBarItem(icon: Icon(Icons.person_3_outlined), label: "vets")
      ],
    );
  }
}
