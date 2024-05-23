import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:migu/presentation/providers/Vaccineandantiparasites/vaccineandAntiparasites_provider.dart';
import 'package:migu/presentation/views/home_view.dart';
import 'package:migu/widgets/shared/custom_text_form_field.dart';

final filtervetProvider = StateProvider<String>((ref) => '');

class VetView extends ConsumerWidget {
  const VetView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allvets = ref.watch(getvetFirebaseProvider);
    final vetfilter = ref.watch(filtervetProvider);
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
            // appBar: AppBar(
            //   actions: [
            //     StreamBuilder<DocumentSnapshot>(
            //       stream: FirebaseFirestore.instance
            //           .collection("users")
            //           .doc(FirebaseAuth.instance.currentUser!.uid)
            //           .snapshots(),
            //       builder: (context, snapshot) {
            //         if (snapshot.hasData && snapshot.data!.exists) {
            //           var photoUrl = snapshot.data!.get('urlImage');
            //           var name = snapshot.data!.get('name');
            //           // ref.read(namepetProvider.notifier).update((state) => name);
            //           var type = snapshot.data!.get('type');
            //           Color.fromARGB(255, 109, 72, 72);
            //           // ref.read(namepetProvider.notifier).update((state) => name);
            //           return photoUrl == ""
            //               ? type == "Perro"
            //                   ? ClipOval(
            //                       child: Image.asset(
            //                       "assets/perro.png",
            //                       width: 40,
            //                     )) // Si no hay foto y es un perro, muestra una imagen de gato
            //                   : type == "otro"
            //                       ? ClipOval(
            //                           child: Image.asset("assets/conejo.png",
            //                               width:
            //                                   40)) // Si no hay foto y es otro, muestra una imagen específica
            //                       : ClipOval(
            //                           child: Image.asset("assets/gato.png",
            //                               width:
            //                                   40)) // Si no hay foto y no es un perro ni otro, muestra una imagen de perro
            //               : CircleAvatar(
            //                   backgroundImage: NetworkImage(
            //                       photoUrl), // Si hay una foto, muestra el avatar del usuario
            //                   radius: 18.0, // Radio para hacerlo redondo
            //                 );
            //         } else {
            //           return SizedBox.shrink();
            //         }
            //       },
            //     ),

            //     StreamBuilder<DocumentSnapshot>(
            //       stream: FirebaseFirestore.instance
            //           .collection("users")
            //           .doc(FirebaseAuth.instance.currentUser!.uid)
            //           .snapshots(),
            //       builder: (context, snapshot) {
            //         if (snapshot.hasData && snapshot.data!.exists) {
            //           var photoUrl = snapshot.data!.get('urlImage');
            //           var name = snapshot.data!.get('name');
            //           var type = snapshot.data!.get('type');
            //           // ref.read(namepetProvider.notifier).update((state) => name);
            //           return PopupMenuButton<String>(
            //               color: Colors.white,
            //               shadowColor: Colors.white,
            //               surfaceTintColor: Colors.white,
            //               icon: const Icon(Icons.arrow_drop_down,
            //                   color: Colors.white),
            //               itemBuilder: (BuildContext context) {
            //                 return [
            //                   '$name',
            //                   'Editar Mascota',
            //                   'Contactar Soporte',
            //                   "Cerrar sesión"
            //                 ].map((String choice) {
            //                   if (choice == '$name') {
            //                     return PopupMenuItem<String>(
            //                       value: choice,
            //                       child: Row(
            //                         children: [
            //                           photoUrl == ""
            //                               ? type == "Perro"
            //                                   ? ClipOval(
            //                                       child: Image.asset(
            //                                       "assets/perro.png",
            //                                       width: 40,
            //                                     )) // Si no hay foto y es un perro, muestra una imagen de gato
            //                                   : type == "otro"
            //                                       ? ClipOval(
            //                                           child: Image.asset(
            //                                               "assets/conejo.png",
            //                                               width:
            //                                                   40)) // Si no hay foto y es otro, muestra una imagen específica
            //                                       : ClipOval(
            //                                           child: Image.asset(
            //                                               "assets/gato.png",
            //                                               width:
            //                                                   40)) // Si no hay foto y no es un perro ni otro, muestra una imagen de perro
            //                               : CircleAvatar(
            //                                   backgroundImage: NetworkImage(
            //                                       photoUrl), // Si hay una foto, muestra el avatar del usuario
            //                                   radius:
            //                                       18.0, // Radio para hacerlo redondo
            //                                 ),
            //                           const SizedBox(
            //                               width:
            //                                   8), // Espacio entre la imagen y el texto
            //                           Text(choice),
            //                         ],
            //                       ),
            //                     );
            //                   } else {
            //                     return PopupMenuItem<String>(
            //                       value: choice,
            //                       child: Text(choice),
            //                     );
            //                   }
            //                 }).toList();
            //               },
            //               onSelected: (String choice) async {
            //                 if (choice == "Cerrar sesión") {
            //                   await FirebaseAuth.instance.signOut();
            //                 } else if (choice == "Contactar Soporte") {
            //                   _mostrarModal(context);
            //                 } else if (choice == "Editar Mascota") {
            //                   ref
            //                       .read(isEditPerProvider.notifier)
            //                       .update((state) => true);
            //                   context.push("/addpet");
            //                 }
            //               });
            //         } else {
            //           return SizedBox.shrink();
            //         }
            //       },
            //     ),

            //     // Resto del contenido de tu pantalla
            //   ],
            //   toolbarHeight: 80,
            //   backgroundColor: const Color(0xFF272B4E), // Color azul marino
            //   title: const Row(
            //     children: [
            //       Expanded(
            //         child: Align(
            //           alignment: Alignment.topLeft,
            //           child: Text(
            //             'Vets',
            //             style: TextStyle(
            //               fontSize: 24.0,
            //               color: Colors.white,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
       body: SingleChildScrollView(
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        SizedBox(height: 40),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: CustomTextInput(
            
            onChanged: (value) {
              ref.read(filtervetProvider.notifier).update((state) => value);
            },
            label: "",
            hint: "Buscar",
            icon: true,
          ),
        ),
        allvets.when(
          data: (data) {
            final filteredVets = data.where((tutor) {
              final fullName = '${tutor.name} ${tutor.lastname}'.toLowerCase();
              return fullName.contains(vetfilter.toLowerCase());
            }).toList();

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredVets.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    ref.watch(vetinfoProvider.notifier).update((state) => filteredVets.elementAt(i));
                    context.push("/VetProfileScreen");
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                        child: Row(
                          children: [
                            Icon(Icons.person, size: 40),
                            SizedBox(width: 10),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                     ref.watch(vetinfoProvider.notifier).update((state) => filteredVets.elementAt(i));
                    context.push("/VetProfileScreen");
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${filteredVets.elementAt(i).name} ${filteredVets.elementAt(i).lastname}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text("${filteredVets.elementAt(i).speciality}"),
                                  ],
                                ),
                              ),
                            ),
                            Icon(
                              Icons.share,
                              color: Color(0xff3D9A51),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Icon(Icons.medication_outlined, color: Color(0xFFb9b7ea)),
                            SizedBox(width: 8),
                            Text(
                              "${filteredVets.elementAt(i).yearsofexperience}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                         SizedBox(height: 10),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(right: 220),
                        child: Text(
                          "Atención",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      if (filteredVets.elementAt(i).atentions["online"])
                        ListTileWithDot(
                          icon: Icons.camera_alt_sharp,
                          atentionss: "online",
                        ),
                      if (filteredVets.elementAt(i).atentions["home"])
                        ListTileWithDot(
                          icon: Icons.gps_fixed,
                          atentionss: "A Domicilio",
                        ),
                      SizedBox(height: 10),
                      if (filteredVets.elementAt(i).addres.isNotEmpty)
                        ListTileWithDot(
                          icon: Icons.home,
                          atentionss: filteredVets.elementAt(i).addres,
                        ),
                      if (i != filteredVets.length - 1)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: Colors.grey,
                            thickness: 0.3,
                          ),
                        ), // Agregar un divisor después de cada elemento, excepto el último
                    ],
                  ),
                );
              },
            );
          },
          error: (error, stackTrace) {
            return Text("Error${error}");
          },
          loading: () {
            return Center(child: CircularProgressIndicator());
          },
        ),
        SizedBox(height: 150), // Espacio en blanco al final de la lista
      ],
    ),
  ),
)));

          
             }
}

class ListTileWithDot extends StatelessWidget {
  final IconData icon;
  final String atentionss;

  const ListTileWithDot({
    Key? key,
    required this.icon,
    required this.atentionss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: [
          Icon(
            icon,
            color: Color(0xFFb9b7ea),
          ),
          SizedBox(width: 8), // Espacio entre el icono y el texto
          Text(
            "$atentionss",
            style: TextStyle(color: Colors.black, fontSize: 17),
          ),
        ],
      ),
    );
  }
}

class ListTileWithDotwithoutpadding extends StatelessWidget {
  final IconData icon;
  final String atentionss;

  const ListTileWithDotwithoutpadding({
    Key? key,
    required this.icon,
    required this.atentionss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 8), // Espacio entre el icono y el texto
          Text(
            "$atentionss",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
