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
    selectedItemColor: Colors.black, // Establece el color del ícono seleccionado
    unselectedItemColor: Colors.grey, // Establece el color del ícono no seleccionado
    items: const [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.pets,
        ),
        label: "Pacientes",
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person_3,
        ),
        label: "perfil",
      ),
    ],
  );
}

}
