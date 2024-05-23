import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:migu/presentation/providers/auth/register_form_provider.dart';

class TutorVetSelectionScreen extends ConsumerWidget {
  const TutorVetSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerForm = ref.watch(registerformProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40,),
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
                  onTap: () async {
                    await registerUser(true, false, registerForm);
                    // ref.read(registerformProvider.notifier).onFormSubmit(context);
                  },
                  child: const ChoseSelection(
                      iconname: Icons.pets, text: "Tutor de Mascota")),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () async {
                    await registerUser(false, true, registerForm);
                    //       ref.read(registerformProvider.notifier).onFormSubmit(context);
                    //  await     FirebaseFirestore.instance
                    //           .collection("users")
                    //           .doc("ok7l2yAWkoyyLdSEgHXK")
                    //           .set({"role": true});
                    // await FirebaseFirestore.instance
                    //     .collection("vet")
                    //     .doc("ids")
                    //     .set({
                    //       "role":true
                    //     });
                    // autenticar con los datos
                    //y actualizar los datos con role a veterinario

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
                  "Elige una opción de cómo quieres usar la app",
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
      ),
    );
  }
}

Future<void> registerUser(
    bool isVet, bool isCompletePet, RegisterFormState registerForm) async {

  try {
    // Crear cuenta de usuario en Firebase Auth
    final UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email:
          '${registerForm.email.value}', // Correo electrónico ficticio, reemplaza con tu lógica de registro de correo electrónico
      password:
          '${registerForm.password.value}', // Contraseña ficticia, reemplaza con tu lógica de registro de contraseña
    );
    //abajo es nomrla , arriva veterinario
    // Obtener el ID del usuario recién creado
    //si el rol es true quiere decir que le devo preguntar sobre su masctota
    //sin embargo tener otro campo de si ya le pregunte
    final String userId = userCredential.user!.uid;
//este no eres veterinario
    // Crear un documento en Firestore con el ID del usuario
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      "isPetComplete": isCompletePet ? "completado" : "",
      "role": isVet,
      "gmail":registerForm.email.value,
      "name": registerForm.name.value,
      "urlImage": "",
      "lastname": registerForm.lasname.value,
      "type": "perro" // El rol será false si es veterinario y true si no lo es
    });

    //   await FirebaseFirestore.instance.collection('users').doc(userId).set({
    //   "isPetComplete": isCompletePet ? "completado" : "",
    //   "role": isVet,
    //   "name": registerForm.name.value,
    //   "urlImage": "",
    //   "gmail":registerForm.email.value,
    //   "lastname": registerForm.lasname.value,
    //   "type": "perro" // El rol será false si es veterinario y true si no lo es
    // });

    // Mostrar un mensaje de éxito
  } catch (e) {
    // Mostrar un mensaje de error si hay algún problema durante el registro
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
