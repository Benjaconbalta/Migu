import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:migu/presentation/providers/vets/vets_provider.dart';
import 'package:migu/presentation/views/vet_view.dart';

final initialOpotions = ["Perros", "Gatos"];

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  late String name = "";
  late String lasname = "";
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((doc) {
        if (doc.exists) {
          setState(() {
            name = doc['name'];
            lasname = doc["lastname"];
          });
        }
      });
    }
  }

  Widget build(BuildContext context) {
    final profileVet = ref.watch(getProfileProvider);
    final Map<String, String> data = {
      'gato': 'Descripción del elemento 1',
      'Perro': 'Descripción del elemento 2',
    };

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(

          children: [
          profileVet.when(
            data: (data) {
              if (data.isEmpty) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/Frame1.png",
                            width: 80,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                                   Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                "${name.length > 12 ? name.substring(0, 12) + '...' : name} ${lasname.length > 12 ? lasname.substring(0, 12) + '...' : lasname}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                           ),
                        
                          Text("Veterinaria"),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.share,
                        color: Color(0xff3D9A51),
                      ),
                        ],
                      ),
                    ),
                    const SizedBox(
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
                          side: BorderSide(
                              color: Colors.grey[300]!), // Borde gris suave
                          borderRadius:
                              BorderRadius.circular(10), // Bordes redondeados
                        ),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                        child: Text(
                          'Editar Perfil',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xff3D9A51)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                "Atención ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              ListTileWithDot(
                                icon: Icons.camera_alt_sharp,
                                atentionss: "online",
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
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                "Especies: ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              ListTileWithDot(
                                icon: FontAwesomeIcons.dog,
                                atentionss: "Perros",
                              ),
                              // SizedBox(height: 5,),
                              // ListTileWithDot(
                              //   icon: FontAwesomeIcons.cat,
                              //   atentionss: "Gatos  ",
                              // ),
                                SizedBox(height: 5,),
                              ListTileWithDot(
                                icon: FontAwesomeIcons.cat,
                                atentionss: "Gatos",
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
                      padding: EdgeInsets.symmetric(horizontal: 1),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 40),
                                child: Text(
                                  "Ofrece: ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                                Container(
                      margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                      child: ElevatedButton(
                        onPressed: () {
                          // Acción cuando se presiona el botón
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 0
                          ),
                          child: Text(
                            "veterinaria general", // Mostrar el texto de offerparagraph
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff453A66),
                            ),
                          ),
                        ),
                      ),
                    )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 400,
                      height: 170,
                      color: Colors.grey[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                          onTap: () {
                            _mostrarModal(context);
                          },
                          child: Text(
                            "Soporte",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                          SizedBox(
                            height: 20,
                          ),
                               GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('¿Cerrar Sesión?'),
                                  content: const SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                      
                                        // Puedes agregar mpás widgets según sea necesario
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    FilledButton(
                                      child: const Text('ok'),
                                      onPressed: () {
                                        FirebaseAuth.instance.signOut();
                                      },
                                    ),
                                    // Puedes agregar más botones de acción si lo necesitas
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            "Cerrar Sesión",
                            style: TextStyle(color: Colors.red, fontSize: 18),
                          ),
                        ),
                  
                        ],
                      ),
                    ),
                  ],
                );
              }
              return Column(
             
                children: [
                Padding(
                  padding: EdgeInsets.only(left: 20,top: 10),
                  child: Row(
                    children: [
                      data[0]["image"] == ""
                          ? Image.asset(
                              "assets/Frame1.png",
                              height: 60,
                            )
                          : ClipOval(
                              child: Image.network(
                                "${data[0]["image"]}",
                                height: 60,
                                fit: BoxFit
                                    .cover, // Esto ajustará la imagen para que cubra todo el área del círculo
                              ),
                            ),
                            SizedBox(width: 20,),
// https://firebasestorage.googleapis.com/v0/b/migu-8983a.appspot.com/o/imagesvet%2F1715280161863?alt=media&token=a94b9fe0-4901-4eab-8ac1-847a0f9b5038

                     
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                "${name.length > 12 ? name.substring(0, 12) + '...' : name} ${lasname.length > 12 ? lasname.substring(0, 12) + '...' : lasname}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                           ),
                        
                          Text("Veterinaria"),
                        ],
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Icon(
                        Icons.share,
                        color: Color(0xff3D9A51),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.medal,
                            color: Color(0xFFb9b7ea),
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("${data[0]["yearsofexperience"]}"),
                        ],
                      )),
                ),
                SizedBox(
                  height: 15,
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
                      side: BorderSide(
                          color: Colors.grey[300]!), // Borde gris suave
                      borderRadius:
                          BorderRadius.circular(10), // Bordes redondeados
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                    child: Text(
                      'Editar Perfil',
                      style: TextStyle(fontSize: 16, color: Color(0xff3D9A51)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Colors.grey[200], // Color gris
                  thickness: 5.0, // Grosor del divider
                  height:
                      2.0, // Altura del divider (0.0 indica que la altura será la predeterminada)
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: Text(
                              "Atención ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                            child: Column(
                              children: data.map<Widget>((value) {
                                final atention =
                                    value["atentions"] as Map<String, dynamic>;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    atention["online"]
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                            child: ListTileWithDot(
                                              icon: Icons.camera_alt_sharp,
                                              atentionss: "online",
                                            ),
                                          )
                                        : SizedBox(
                                            height: 0,
                                          ),
                                    atention["home"]
                                        ? ListTileWithDot(
                                            icon:
                                                FontAwesomeIcons.locationArrow,
                                            atentionss: "A Domicilio",
                                          )
                                        : SizedBox(
                                            height: 0,
                                          )
                                  ],
                                );
                              }).toList(),
                            ),
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
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: const Text(
                              "Especies ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 10),
                              child: Column(
                                children: data.map<Widget>((value) {
                                  final chose = value["choosespecies"]
                                      as Map<String, dynamic>;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      chose["gato"]
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0),
                                              child: ListTileWithDot(
                                                icon: FontAwesomeIcons.cat,
                                                atentionss: "Gatos",
                                              ),
                                            )
                                          : SizedBox(
                                              height: 5,
                                            ),
                                      chose["exoticos"]
                                          ? ListTileWithDot(
                                              icon: FontAwesomeIcons.fish,
                                              atentionss: "Exoticos",
                                            )
                                          : SizedBox(
                                              height: 5,
                                            ),
                                      chose["perro"]
                                          ? ListTileWithDot(
                                              icon: FontAwesomeIcons.dog,
                                              atentionss: "Perros",
                                            )
                                          : SizedBox(
                                              height: 0,
                                            )
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1),
                    child: Row(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              "Ofrece:",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                          OfferContainer(data: data,)
//                        Container(
//   height: 200, // Altura fija para evitar el error de altura no limitada
//   child: SingleChildScrollView(
//     scrollDirection: Axis.horizontal,
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: List.generate(
//         (data.length / 2).ceil(), // Cálculo del número de filas necesarias basado en la longitud de data
//         (rowIndex) {
//           return Wrap(
//             spacing: 8, // Espacio horizontal entre los botones
//             children: List.generate(
//               2, // Número máximo de botones por fila
//               (columnIndex) {
//                 final buttonIndex = rowIndex * 2 + columnIndex;
//                 if (buttonIndex >= data.length) {
//                   return SizedBox.shrink(); // Devolver un contenedor invisible si no hay más botones
//                 }
//                 return Container(
//                   margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Acción cuando se presiona el botón
//                     },
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.grey[300],
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(2),
//                       child: Text(
//                         data[0]["offerparagraph"], // Mostrar el texto de offerparagraph
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     ),
//   ),
// )
,
    

                        ],
                      ),
                      
                    ])),
                      Container(
                    width: 400,
                    height: 170,
                    color: Colors.grey[200],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _mostrarModal(context);
                          },
                          child: Text(
                            "Soporte",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('¿Cerrar Sesión?'),
                                  content: const SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                      
                                        // Puedes agregar mpás widgets según sea necesario
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    FilledButton(
                                      child: const Text('ok'),
                                      onPressed: () {
                                        FirebaseAuth.instance.signOut();
                                      },
                                    ),
                                    // Puedes agregar más botones de acción si lo necesitas
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            "Cerrar Sesión",
                            style: TextStyle(color: Colors.red, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
            


              ]);
            },
            error: (error, stackTrace) {
              return Text("asdaa");
            },
            loading: () {
              return Text("asda");
            },
          )
        ]),
      ),
    );
  }
}

class OfferContainer extends StatelessWidget {
  final List<dynamic> data;

  const OfferContainer({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> offers =
        List<String>.from(data[0]["offerparagraph"] ?? []);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: offers.isEmpty?
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: const   Text("No Ofrece nada ",
         style: TextStyle(fontSize: 18,color: Colors.black),),
    )
       :  Container(
        height: 200, // Altura fija para evitar el error de altura no limitada
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8, // Espacio horizontal entre los botones
                children: List.generate(
                  2, // Número máximo de botones en la primera fila
                  (index) {
                    if (index >= offers.length) {
                      return SizedBox.shrink();
                    }
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                      child: ElevatedButton(
                        onPressed: () {
                          // Acción cuando se presiona el botón
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: Text(
                            offers[index], // Mostrar el texto de offerparagraph
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff453A66),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Wrap(
                spacing: 8, // Espacio horizontal entre los botones
                children: List.generate(
                  3, // Número máximo de botones en la segunda fila
                  (index) {
                    final buttonIndex = 2 + index; // Desplazamos el índice para continuar después de los primeros 2
                    if (buttonIndex >= offers.length) {
                      return SizedBox.shrink();
                    }
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                      child: ElevatedButton(
                        onPressed: () {
                          // Acción cuando se presiona el botón
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: Text(
                            offers[buttonIndex], // Mostrar el texto de offerparagraph
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                           color: Color(0xff453A66),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
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


// class ProfileView extends ConsumerWidget {
//   const ProfileView({super.key});

//   @override
// }

