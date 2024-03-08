import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:migu/domain/entities/vaccine.dart';
import 'package:migu/presentation/views/home_view.dart';

final editvaccineProvider = StateProvider<bool>((ref) {
  return false;
});

final infoeditvaccineProvider = StateProvider<Vaccine>((ref) {
  return Vaccine(
      type: "",
      brand: "",
      vaccination: "",
      date: DateTime.now(),
      nextdose: DateTime.now(),
      photovaccinelabel: "",
      photocertificate: "",
      id: "");
});

class IntoVaccine extends ConsumerWidget {
  const IntoVaccine({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nn = ref.watch(sightinProvider);
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(  
                onPressed: () {
                              ref.read(editvaccineProvider.notifier).update((state) => false);
                  ref
                      .read(pressVaccineIntoProvider.notifier)
                      .update((state) => false);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                label: Text(
                  "Atras",
                  style: TextStyle(color: Colors.black),
                )),
            TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.share),
                label: Text("Compartir")),
          ],
        ),

        Container(
          height: 100,
          width: 270,
          padding: EdgeInsets.all(10.0),
          color: Colors.grey[200], // Fondo gris claro
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (nn.brand != "Rabguard" &&
                      nn.brand != "Canigen" &&
                      nn.brand != "Nobivac")
                    Icon(
                      Icons.image,
                      size: 70,
                    ),

                  if (nn.brand == "Rabguard")
                    Image.asset(
                        height: 70, width: 70, 'assets/Frame1000004649.png'),

                  if (nn.brand == "Canigen")
                    Image.asset(
                      'assets/Frame13336.png',
                      width: 100,
                    ),

                  if (nn.brand == "Nobivac")
                    Image.asset('assets/Frame1000004650.png',width: 70,height: 70,),

                  // Image.network()
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${nn.type}",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4), // Espacio entre los textos
                  Text(
                    "${nn.brand}",
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),

        Padding(
            padding: EdgeInsets.only(right: 120),
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Ultima dosis: ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              TextSpan(
                  text:
                      "${nn.date.day} ${getShortMonthName(nn.date.month)} ${nn.date.year}",
                  style: TextStyle(color: Colors.black))
            ]))),
        SizedBox(
          height: 20,
        ),
        Padding(
            padding: EdgeInsets.only(right: 120),
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Proxima dosis: ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              TextSpan(
                  text:
                      "${nn.nextdose.day} ${getShortMonthName(nn.nextdose.month)} ${nn.nextdose.year}",
                  style: TextStyle(color: Colors.black))
            ]))),
        SizedBox(
          height: 20,
        ),
        Container(
          // Bordes redondeados

          height: 80,
          width: 300,
          padding: EdgeInsets.all(10.0),
          color: Colors.grey[200], // Fondo gris claro
          child: Row(
            children: [
              Text("Etiqueta Vacuna"),
              Icon(Icons.help),
              SizedBox(
                width: 50,
              ),
              Container(
                  width: 90,
                  height: 90,
                  child: nn.photovaccinelabel == ""
                      ? Text("no-image")
                      : Image.network("${nn.photovaccinelabel}"))
            ],
          ),
        ),

        SizedBox(
          height: 20,
        ), // Comprobamos la marca de la vacuna y asignamos la imagen correspondiente

        Container(
          // Bordes redondeados

          height: 80,
          width: 300,
          padding: EdgeInsets.all(10.0),
          color: Colors.grey[200], // Fondo gris claro
          child: Row(
            children: [
              Text("Certificado"),
              Icon(Icons.help),
              SizedBox(
                width: 50,
              ),
              Container(
                  width: 90,
                  height: 90,
                  child: nn.photocertificate == ""
                      ? Text("no-Image")
                      : Image.network("${nn.photocertificate}"))
            ],
          ),
        ),
        Spacer(
          flex: 1,
        ),
        ElevatedButton(
          onPressed: () {
            context.push("/addvaccine");
            ref.read(editvaccineProvider.notifier).update((state) => true);
            ref.read(infoeditvaccineProvider.notifier).update((state) => nn);
            // context.push("addvacine")
            // Aquí puedes añadir la función que se ejecutará cuando se presione el botón
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
                horizontal: 160, vertical: 20), // Padding del botón
            backgroundColor: Colors.white, // Color de fondo blanco
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Bordes redondeados
              side: BorderSide(color: Colors.green), // Bordes de color verde
            ),
          ),
          child: Text(
            'Editar',
            style: TextStyle(color: Colors.black), // Color del texto
          ),
        ),

        TextButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("vaccine")
                  .doc(nn.id)
                  .delete()
                  .then((value) => {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Vacuna borrada!'),
                        ))
                      })
                  .then((value) => {
                        ref
                            .read(pressVaccineIntoProvider.notifier)
                            .update((state) => false)
                      });
            },
            child: Text(
              "Eliminar",
              style: TextStyle(color: Colors.red),
            ))
      ],
    );
  }
}

Widget nn() {
  return Column(
    children: [
      Text("asdasd"),
    ],
  );
}
