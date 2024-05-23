import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:migu/domain/entities/Vet.dart';
import 'package:migu/presentation/providers/Vaccineandantiparasites/vaccineandAntiparasites_provider.dart';
import 'package:migu/presentation/views/vet_view.dart';

final filtervetProvider = StateProvider<String>((ref) => '');

class VetProfileScreen extends ConsumerWidget {
  const VetProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vetinfoDetails = ref.watch(vetinfoProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: Image.network(
                        "https://media.istockphoto.com/id/1423830925/es/foto/joven-veterinaria-usando-tablet-pc-en-su-trabajo.jpg?s=612x612&w=0&k=20&c=Yv6Cq7kXXhGOsSOlTqYxyHl0DtceaQkhw8QHvQ0n4CA=",
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${vetinfoDetails.name} ${vetinfoDetails.lastname} ",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      const Text(
                        "Veterinaria",
                        style: TextStyle(fontSize: 17),
                      ),
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
            vetinfoDetails.service.isEmpty
                ? SizedBox(
                    height: 0,
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(children: [
                          Icon(Icons.medical_information_rounded,
                              color: Color(0xFFb9b7ea)),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "${vetinfoDetails.service}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ])),
                  ),
            vetinfoDetails.speciality.isEmpty
                ? SizedBox(
                    height: 0,
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(children: [
                          Icon(Icons.track_changes_outlined,
                              color: Color(0xFFb9b7ea)),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "${vetinfoDetails.speciality}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ])),
                  ),
            vetinfoDetails.yearsofexperience.isEmpty
                ? SizedBox(
                    height: 0,
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(children: [
                          Icon(Icons.emoji_events, color: Color(0xFFb9b7ea)),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "${vetinfoDetails.yearsofexperience}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ])),
                  ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Bordes cuadrados
                  ),
                  backgroundColor: Color(0xFF3D9A51),
                  padding: EdgeInsets.symmetric(horizontal: 120)),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        title: Text('Contacto'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.email),
                                SizedBox(width: 8),
                                Text('Correo: ${vetinfoDetails.correo}'),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.phone),
                                SizedBox(width: 8),
                                Text('Teléfono: +569${vetinfoDetails.phone}'),
                              ],
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cerrar'),
                          )
                        ]);
                  },
                );
                // context.go("/home/0");
              },
              child: Text(
                "Conectar",
                style: TextStyle(color: Colors.white),
              ),
            ),

            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Atencion",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  )),
            ),
            SizedBox(
              height: 4,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: vetinfoDetails.atentions.length - 1,
              itemBuilder: (context, index) {
             
                return Column(
                  //si online y pre son verdaderos mostrara lo
                  children: [
                    vetinfoDetails.atentions["online"]
                        ? ListTileWithDot(
                            icon: Icons.camera_alt_sharp,
                            atentionss: vetinfoDetails.atentions["online"]
                                ? "online"
                                : "")
                        : SizedBox(
                            height: 0,
                          ),
                    vetinfoDetails.atentions["home"]
                        ? ListTileWithDot(
                            icon: Icons.gps_fixed,
                            atentionss: vetinfoDetails.atentions["home"]
                                ? "A Domicilio"
                                : "")
                        : SizedBox(
                            height: 0,
                          ),
                    vetinfoDetails.addres != ""
                        ? ListTileWithDot(
                            icon: Icons.home,
                            atentionss: vetinfoDetails.addres.isEmpty
                                ? "${vetinfoDetails.addres}"
                                : "")
                        : SizedBox(
                            height: 0,
                          )
                  ],
                );
              },
            ),

            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Especies",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  )),
            ),
            SizedBox(
              height: 4,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: vetinfoDetails.choosespecies.length - 2,
              itemBuilder: (context, index) {
                return Column(
                  //si online y pre son verdaderos mostrara lo
                  children: [
                    vetinfoDetails.choosespecies["exoticos"]
                        ? ListTileWithDot(
                            icon: Icons.camera_alt_sharp,
                            atentionss: vetinfoDetails.choosespecies["exoticos"]
                                ? "exoticos"
                                : "")
                        : SizedBox(
                            height: 0,
                          ),
                    vetinfoDetails.choosespecies["gato"]
                        ? ListTileWithDot(
                            icon: Icons.gps_fixed,
                            atentionss: vetinfoDetails.choosespecies["gato"]
                                ? "A gato"
                                : "")
                        : SizedBox(
                            height: 0,
                          ),
                    vetinfoDetails.choosespecies["perro"]
                        ? ListTileWithDot(
                            icon: Icons.gps_fixed,
                            atentionss: vetinfoDetails.choosespecies["perro"]
                                ? "perro"
                                : "")
                        : SizedBox(
                            height: 0,
                          ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Ofrece",
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),
                          )),
                    ),
                    //  Container(
                                  

                    //   height:
                    //       200, // Altura fija para evitar el error de altura no limitada
                    //   child: SingleChildScrollView(
                    //     scrollDirection: Axis.horizontal,
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: List.generate(
                    //         (10 / 2)
                    //             .ceil(), // Cálculo del número de filas necesarias
                    //         (rowIndex) {
                    //           return Wrap(
                    //             spacing:
                              
                    //                 8, // Espacio horizontal entre los botones
                    //             children: List.generate(
                    //               2, // Número máximo de botones por fila
                    //               (columnIndex) {
                    //                 final buttonIndex =
                    //                     rowIndex * 2 + columnIndex;
                    //                 if (buttonIndex >= 3) {
                    //                   return SizedBox
                    //                       .shrink(); // Devolver un contenedor invisible si no hay más botones
                    //                 }
                    //                 return Container(
                    //                   margin: EdgeInsets.symmetric(
                    //                       horizontal: 3, vertical: 3),
                    //                   child: ElevatedButton(
                    //                     onPressed: () {
                    //                       // Acción cuando se presiona el botón
                    //                     },
                    //                     style: ElevatedButton.styleFrom(
                    //                       primary: Colors.grey[300],
                    //                       shape: RoundedRectangleBorder(
                    //                         borderRadius:
                    //                             BorderRadius.circular(8),
                    //                       ),
                    //                     ),
                    //                     child: Padding(
                    //                       padding: EdgeInsets.all(2),
                    //                       child: Text(
                    //                         "Botón $buttonIndex",
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
                    // ),
                OfferContainer(data:vetinfoDetails ,),
                     SizedBox(
                      height: 120,
                    ),
                  ],
                );
              },
            ),

            // SizedBox(
            //   height: 30,
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 40),
            //   child: Row(
            //     children: [
            //       Column(
            //         children: [
            //           const Text(
            //             "Especies ",
            //             style: TextStyle(
            //                 fontSize: 20, fontWeight: FontWeight.w600),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Container(
            //               height: 90,
            //               width: 80,
            //               child: ListView.builder(
            //                 itemCount: vetinfoDetails.choosespecies
            //                     .length, // número de elementos en tu mapa
            //                 itemBuilder: (context, index) {

            //                   return Padding(
            //                     padding: const EdgeInsets.symmetric(
            //                         vertical: 4.0),
            //                     child: Row(
            //                       crossAxisAlignment:
            //                           CrossAxisAlignment.start,
            //                       children: [
            //                         Expanded(
            //                           child: Column(
            //                             crossAxisAlignment:
            //                                 CrossAxisAlignment.start,
            //                             children: [
            //                               Text(
            //                                 "•${vetinfoDetails.choosespecies["choosespecies"]["exoticos"]}", // Clave del mapa como título
            //                                 style: TextStyle(
            //                                   fontSize: 14,
            //                                   fontWeight: FontWeight.bold,
            //                                 ),
            //                               ),
            //                               Text(
            //                                 '•${vetinfoDetails.choosespecies["choosespecies"]["gato"]}', // Punto como marcador
            //                                 style: TextStyle(
            //                                   fontSize: 14,
            //                                   fontWeight: FontWeight.bold,
            //                                 ),
            //                               ),
            //                               Text(
            //                                 '•${vetinfoDetails.choosespecies["choosespecies"]["perro"]}', // Punto como marcador
            //                                 style: TextStyle(
            //                                   fontSize: 14,
            //                                   fontWeight: FontWeight.bold,
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   );
            //                 },
            //               ),
            //             ),
            //           ),
            //         ],
            //       )
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 1),
            //   child: Row(
            //     children: [
            //       Column(
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.only(right: 40),
            //             child: Text(
            //               "Ofrece: ",
            //               style: TextStyle(
            //                   fontSize: 20, fontWeight: FontWeight.w600),
            //             ),
            //           ),
            //           Row(
            //             children: [
            //               Column(
            //                 children: [
            //                   Padding(
            //                     padding: const EdgeInsets.only(left: 30),
            //                     child: ElevatedButton(
            //                       style: ElevatedButton.styleFrom(
            //                         padding: EdgeInsets.symmetric(
            //                             horizontal: 20,
            //                             vertical:
            //                                 1), // Ajusta el tamaño del botón
            //                         shape: RoundedRectangleBorder(
            //                           borderRadius: BorderRadius.circular(
            //                               10), // Ajusta la forma del botón
            //                         ),
            //                         backgroundColor: Colors.grey[100],
            //                       ),
            //                       onPressed: () {

            //                       },
            //                       child: Text(
            //                         "Veterinaria general",
            //                         style: TextStyle(
            //                             fontSize: 14,
            //                             color: Colors
            //                                 .black), // Ajusta el tamaño del texto
            //                       ),
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     height: 40,
            //                   )
            //                 ],
            //               )
            //             ],
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),

            //             ],
          ]),
        ),
      ),
    );
  }
}


class OfferContainer extends StatelessWidget {
  final Vet data;

  const OfferContainer({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> offers =
        List<String>.from(data.offerparagraph);

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
