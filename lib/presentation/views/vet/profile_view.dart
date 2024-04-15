import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              children: [
                Icon(
                  Icons.local_hospital_rounded,
                  size: 50,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Beatriz Gonzales",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text("Veterinaria"),
                  ],
                ),
                SizedBox(
                  width: 40,
                ),
                Icon(
                  Icons.share,
                  color: Color(0xff3D9A51),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              context.push("/EditProfileScreen");
              // Acción al presionar el botón
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // Fondo blanco
              // Texto negro
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey[300]!), // Borde gris suave
                borderRadius: BorderRadius.circular(10), // Bordes redondeados
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 80),
              child: Text(
                'Editar Perfil',
                style: TextStyle(fontSize: 16, color: Color(0xff3D9A51)),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      "Atención ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.camera_alt_sharp,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Online "),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      "Especies ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Text("Perros "),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Gatos "),
                          ],
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      "Ofrece ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            FilledButton(
                                style: FilledButton.styleFrom(
                                    backgroundColor: Colors.grey),
                                onPressed: () {},
                                child: Text("Veterinaria general"))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 400,
            height: 200,
            color: Colors.grey[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Soporte",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Cerrar Sesión",
                  style: TextStyle(color: Colors.purple, fontSize: 15),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
