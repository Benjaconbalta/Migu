
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:migu/presentation/home/vet/intopatientScreen.dart';
import 'package:migu/presentation/providers/vets/vets_provider.dart';

class ClinicalRecordScreen extends ConsumerWidget {
  const ClinicalRecordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(uidUserProvider);
    final clinicalRecordStream = ref.watch(getclinicalRecord(uid));
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton.tonal(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      // Ajusta el valor de la esquina para hacerlo menos redondeado
                      side:const BorderSide(
                          color: Colors.grey,
                          strokeAlign: 2), // Agrega un borde al botón
                    ),
                  ),
                  onPressed: () {
                    context.push("/EditClinicalRecordScreen");
                  },
                  child: const Text(
                    "Editar ",
                    style: TextStyle(color: Color(0xff3D9A51)),
                  )),
            )
          ],
          title:const Text("Ficha clinica"),
        ),
        body: clinicalRecordStream.when(
          data: (data) {
            // print(data.isEmpty);
            if (data.isEmpty) {
          return const SingleChildScrollView(
  child: Padding(
    padding:  EdgeInsets.all(40.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Center(
        //   child: Text(
        //     "Actualizado el 10 Ene 2024",
        //     style: TextStyle(fontSize: 15, color: Colors.grey),
        //   ),
        // ),
        SizedBox(height: 20),
        Text(
          "Nombre Mascota",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      
        Text(
          "Nombre de la mascota",
          style: TextStyle(fontSize: 17),
        ),
        SizedBox(height: 10),
        Text(
          "Nacimiento",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Text("01/01/2020", style: TextStyle(fontSize: 17),),
        SizedBox(height: 10),
        Text(
          "Nutrición",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Text("Detalles de la nutrición", style: TextStyle(fontSize: 17),),
        SizedBox(height: 10),
        Text(
          "Peso",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Text("Peso en kg", style: TextStyle(fontSize: 17),),
        SizedBox(height: 10),
        Text(
          "Conducta",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Text("Detalles de la conducta", style: TextStyle(fontSize: 17),),
        SizedBox(height: 10),
        Text(
          "Tratamiento",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Text("Detalles del tratamiento", style: TextStyle(fontSize: 17),),
        SizedBox(height: 10),
        Text(
          "Observaciones",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Text("Observaciones Adicionales", style: TextStyle(fontSize: 17),),
      ],
    ),
  ),
);

            } else {
     
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: data.map((record) {
                    // Aquí puedes construir y mostrar widgets para cada registro clínico
                    return Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Center(
                          //     child: Text(
                          //   "Actualizado el 10 Ene 2024",
                          //   style: TextStyle(fontSize: 15, color: Colors.grey),
                          // )),
                         const SizedBox(
                            height: 20,
                          ),
                        const  Text(
                            "Nombre Mascota",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "${record.name}",
                            style:const TextStyle(fontSize: 17),
                          ),
                         const SizedBox(
                            height: 10,
                          ),
                         const Text("Nacimiento",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                          Text("${record.birthdate}"),
                       const  SizedBox(
                            height: 10,
                          ),
                        const  Text("Nutricion",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                          Text("${record.nutrition}"),
                       const   SizedBox(
                            height: 10,
                          ),
                       const Text("Peso",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                          Text("${record.weight}"),
                        const  SizedBox(
                            height: 10,
                          ),
                        const  Text("Conducta",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                          Text("${record.behavior}"),
                        const  SizedBox(
                            height: 10,
                          ),
                       const   Text("Tratamiento",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                          Text("${record.treatmen} "),
                        const  SizedBox(
                            height: 10,
                          ),
                        const  Text("Observaciones",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                          Text("${record.observations}"),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            }
          },
          error: (error, stackTrace) {
            return const Text("error");
          },
          loading: () {
            return const Text(
             ""
            );
          },
        ));
  }
}




class ClinicalRecordTutorScreen extends ConsumerWidget {
  const ClinicalRecordTutorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clinicalRecordStream = ref.watch(getclinicalRecord(FirebaseAuth.instance.currentUser!.uid));
    return Scaffold(
        appBar: AppBar(
         
          title: const Text("Ficha clinica"),
        ),
        body: clinicalRecordStream.when(
          data: (data) {
            // print(data.isEmpty);
            if (data.isEmpty) {
          return const SingleChildScrollView(
      child: Padding(
          padding:  EdgeInsets.all(40.0),
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        SizedBox(height: 20),
        Text(
          "Nombre Mascota",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      
        Text(
          "Nombre de la mascota",
          style: TextStyle(fontSize: 17),
        ),
        SizedBox(height: 10),
        Text(
          "Nacimiento",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Text("01/01/2020", style: TextStyle(fontSize: 17),),
        SizedBox(height: 10),
        Text(
          "Nutrición",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Text("Detalles de la nutrición", style: TextStyle(fontSize: 17),),
        SizedBox(height: 10),
        Text(
          "Peso",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Text("Peso en kg", style: TextStyle(fontSize: 17),),
        SizedBox(height: 10),
        Text(
          "Conducta",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Text("Detalles de la conducta", style: TextStyle(fontSize: 17),),
        SizedBox(height: 10),
        Text(
          "Tratamiento",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Text("Detalles del tratamiento", style: TextStyle(fontSize: 17),),
        SizedBox(height: 10),
        Text(
          "Observaciones",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Text("Observaciones Adicionales", style: TextStyle(fontSize: 17),),
      ],
    ),
  ),
);

            } else {
     
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: data.map((record) {
                    // Aquí puedes construir y mostrar widgets para cada registro clínico
                    return Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                   const  SizedBox(
                            height: 20,
                          ),
                       const   Text(
                            "Nombre Mascota",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "${record.name}",
                            style: TextStyle(fontSize: 17),
                          ),
                        const  SizedBox(
                            height: 10,
                          ),
                         const Text("Nacimiento",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                          Text("${record.birthdate}"),
                         const SizedBox(
                            height: 10,
                          ),
                        const  Text("Nutricion",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                          Text("${record.nutrition}"),
                       const   SizedBox(
                            height: 10,
                          ),
                        const  Text("Peso",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                          Text("${record.weight}"),
                        const  SizedBox(
                            height: 10,
                          ),
                        const  Text("Conducta",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                          Text("${record.behavior}"),
                        const  SizedBox(
                            height: 10,
                          ),
                        const  Text("Tratamiento",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                          Text("${record.treatmen} "),
                       const   SizedBox(
                            height: 10,
                          ),
                        const  Text("Observaciones",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                          Text("${record.observations}"),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            }
          },
          error: (error, stackTrace) {
            return Text("error${error}");
          },
          loading: () {
            return const Text(
             ""
            );
          },
        ));
  }
}
