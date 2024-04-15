import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:migu/presentation/providers/auth/register_form_provider.dart';

class TutorVetSelectionScreen extends ConsumerWidget {
  const TutorVetSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/Migu1.png",
              width: 90,
              height: 60,
            ),
            const SizedBox(height: 90),
            const Text(
              "¿Cómo Quieres Usar la app?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 40),
            GestureDetector(
                onTap: () {
                   ref
                       .read(registerformProvider.notifier)
                       .onFormSubmit(context);
                },
                child: const ChoseSelection(
                    iconname: Icons.pets, text: "Tutor de Mascota")),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  context.go("/TutorVetSelectionScreen");
                  //TODO: Aca deberia de actualizar el campo de isvet
                },
                child: const ChoseSelection(
                  iconname: Icons.local_hospital_rounded,
                  text: "Veterinario",
                )),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Puedes cambiar de un modo a otro simepre que quieras",
                softWrap: true,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}

class ChoseSelection extends StatelessWidget {
  final String text;
  final IconData iconname;
  const ChoseSelection({super.key, required this.text, required this.iconname});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.grey[200], // Fondo gris claro

        height: 140, // Adjust height as needed
        width: 340,

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                iconname, // Replace with your desired icon
                size: 50,
                color: Colors.black, // Replace with your desired icon color
              ),
              const SizedBox(height: 15),
              // Spacer between icon and text
              Text(
                text, // Your text
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
