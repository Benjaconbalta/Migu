import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:migu/presentation/views/home_view.dart';

class VetView extends ConsumerWidget {
  const VetView({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
      void _mostrarModal(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Contactar Soporte'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('hola@migupets.com'),
                  // Puedes agregar mpás widgets según sea necesario
                ],
              ),
            ),
            actions: <Widget>[
              FilledButton(
                child: Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              // Puedes agregar más botones de acción si lo necesitas
            ],
          );
        },
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.exists) {
                  var photoUrl = snapshot.data!.get('urlImage');
                  var name = snapshot.data!.get('name');
                  // ref.read(namepetProvider.notifier).update((state) => name);
                  var type = snapshot.data!.get('type');
                  Color.fromARGB(255, 109, 72, 72);
                  // ref.read(namepetProvider.notifier).update((state) => name);
                  return photoUrl == ""
                      ? type == "Perro"
                          ? ClipOval(
                              child: Image.asset(
                              "assets/perro.png",
                              width: 40,
                            )) // Si no hay foto y es un perro, muestra una imagen de gato
                          : type == "otro"
                              ? ClipOval(
                                  child: Image.asset("assets/conejo.png",
                                      width:
                                          40)) // Si no hay foto y es otro, muestra una imagen específica
                              : ClipOval(
                                  child: Image.asset("assets/gato.png",
                                      width:
                                          40)) // Si no hay foto y no es un perro ni otro, muestra una imagen de perro
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                              photoUrl), // Si hay una foto, muestra el avatar del usuario
                          radius: 18.0, // Radio para hacerlo redondo
                        );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),

            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.exists) {
                  var photoUrl = snapshot.data!.get('urlImage');
                  var name = snapshot.data!.get('name');
                  var type = snapshot.data!.get('type');
                  // ref.read(namepetProvider.notifier).update((state) => name);
                  return PopupMenuButton<String>(
                       color: Colors.white,
                    shadowColor: Colors.white,
                    surfaceTintColor: Colors.white,
                    icon:
                        const Icon(Icons.arrow_drop_down, color: Colors.white),
                    itemBuilder: (BuildContext context) {
                      return [
                        '$name',
                        'Editar Mascota',
                        'Contactar Soporte',
                        "Cerrar sesión"
                      ].map((String choice) {
                        if (choice == '$name') {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Row(
                              children: [
                       photoUrl == ""
    ? type == "Perro"
        ? ClipOval( child: Image.asset("assets/perro.png",width: 40,)) // Si no hay foto y es un perro, muestra una imagen de gato
        : type == "otro"
            ? ClipOval(child: Image.asset("assets/conejo.png",width: 40)) // Si no hay foto y es otro, muestra una imagen específica
            : ClipOval(child: Image.asset("assets/gato.png",width: 40)) // Si no hay foto y no es un perro ni otro, muestra una imagen de perro
    : CircleAvatar(
        backgroundImage: NetworkImage(
            photoUrl), // Si hay una foto, muestra el avatar del usuario
        radius: 18.0, // Radio para hacerlo redondo
    ),
                              const  SizedBox(
                                    width:
                                        8), // Espacio entre la imagen y el texto
                                Text(choice),
                              ],
                            ),
                          );
                        } else {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }
                      }).toList();
                    },
                   onSelected: (String choice) async {
                      if (choice == "Cerrar sesión") {
                        await FirebaseAuth.instance.signOut();
                      } else if (choice == "Contactar Soporte") {
                        _mostrarModal(context);
                      } else if (choice == "Editar Mascota") {
                        ref
                            .read(isEditPerProvider.notifier)
                            .update((state) => true);
                        context.push("/addpet");
                      }
                   });
              
                } else {
                  return SizedBox.shrink();
                }
              },
            ),

            // Resto del contenido de tu pantalla
          ],
          toolbarHeight: 80,
          backgroundColor: const Color(0xFF272B4E), // Color azul marino
          title: const Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Vets',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("Muy Pronto"),
            )
          ],
        ),
      ),
    );
  }
}
