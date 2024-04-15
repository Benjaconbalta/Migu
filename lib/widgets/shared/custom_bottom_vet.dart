import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomVet extends StatelessWidget {
  final int currentIndex;
  const CustomBottomVet({super.key, required this.currentIndex});

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go("/vet/0");
        break;
      case 1:
        context.go("/vet/1");
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
        BottomNavigationBarItem(
            icon: Icon(
              Icons.pets,
              color: Color(0xff3D9A51),
            ),
            label: "Pacientes"),
        BottomNavigationBarItem(icon: Icon(Icons.person_3,  color: Colors.black), label: "perfil")
      ],
    );
  }
}
