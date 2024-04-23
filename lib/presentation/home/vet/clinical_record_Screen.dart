import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClinicalRecordScreen extends StatelessWidget {
  const ClinicalRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    side: BorderSide(
                        color: Colors.grey,
                        strokeAlign: 2), // Agrega un borde al botón
                  ),
                ),
                onPressed: () {
                  context.push("/EditClinicalRecordScreen");
                },
                child: Text(
                  "Editar ",
                  style: TextStyle(color: Color(0xff3D9A51)),
                )),
          )
        ],
        title: Text("Ficha clinica"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(
              "Actualizado el 10 Ene 2024",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            )),
            SizedBox(
              height: 20,
            ),
            Text(
              "Nombre Mascota",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(
              "Camino",
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Nacimiento",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            Text("10 de julio 2020"),
            SizedBox(
              height: 10,
            ),
            Text("Nutricion",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            Text("pure life adulto"),
            SizedBox(
              height: 10,
            ),
            Text("Peso",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            Text("10kl"),
            SizedBox(
              height: 10,
            ),
            Text("Conducta",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            Text("amigable,timida"),
            SizedBox(
              height: 10,
            ),
            Text("Tratamiento",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            Text("Está tomando Apoquel 5,4mg desde hace 1 año y medio "),
            SizedBox(
              height: 10,
            ),
            Text("Observaciones",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            Text("Sufre de dermatitis atópica"),
          ],
        ),
      ),
    );
  }
}
