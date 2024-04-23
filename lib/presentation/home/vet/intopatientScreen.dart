import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:migu/domain/entities/antiparasites.dart';
import 'package:migu/domain/entities/vaccine.dart';
import 'package:migu/infrastrocture/mappers/vaccine_mapper.dart';
import 'package:migu/presentation/views/home_view.dart';

Stream<List<Vaccine>> getVaccineStream(String userId) {
  // Obtener la referencia a la colección "users" y su subcolección "vaccines"
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference vaccineCollection =
      userCollection.doc(userId).collection("vaccines");

  // Devolver un stream de los documentos en la subcolección "vaccines"
  return FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection("vaccine")
      .snapshots()
      .map((querySnapshot) {
    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      final dateTimestamp = data['date'] as Timestamp;
      final nextdoseTimestamp = data['nextdose'] as Timestamp;
      return VaccineMapper.vaccineFirebaseToEntity(
          doc.data(), doc.id, dateTimestamp, nextdoseTimestamp);
    }).toList();
  }).map((list) => list.cast<Vaccine>());
}

Stream<List<Antiparasites>> getAntiparasites(String userId) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection("Antiparasites")
      .snapshots()
      .map((querySnapshot) {
    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      final dateTimestamp = data['date'] as Timestamp;
      final nextdoseTimestamp = data['nextdose'] as Timestamp;
      return Antiparasites(
        type: data['type'] ?? '',
        brand: data['brand'] ?? '',
        date: dateTimestamp.toDate(), // Convierte el Timestamp a DateTime
        nextdose:
            nextdoseTimestamp.toDate(), // Convierte el Timestamp a DateTime
        id: doc.id,
      );
    }).toList();
  }).map((list) => list.cast<Antiparasites>());
}

class IntopatientScreen extends ConsumerWidget {
  const IntopatientScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(uidUserProvider);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            // Resto del contenido de tu pantalla
          ],
          toolbarHeight: 180,
          backgroundColor: const Color(0xFF272B4E), // Color azul marino
          title: Column(
            children: [
              //debemos de subir la informacion del veterinario , quitar veteinarios en el filter del vet
              Row(children: [
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.exists) {
                      var photoUrl = snapshot.data!.get('urlImage');
                      var name = snapshot.data!.get('name');
                      var type = snapshot.data!.get('type');
                      var isselected = snapshot.data!.get('isselectedbyvet');
                      // print("type$photoUrl");
                      // ref.read(namepetProvider.notifier).update((state) => name);
                      return Row(
                        children: [
                          photoUrl == ""
                              ? type == "Perro"
                                  ? ClipOval(
                                      child: Image.asset(
                                      "assets/perro.png",
                                      width: 40,
                                    )) // Si no hay foto y es un perro, muestra una imagen de gato
                                  : type == "otro"
                                      ? ClipOval(
                                          child: Image.asset(
                                              "assets/conejo.png",
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
                                ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //falta guardar el nombre del tutor
                              Padding(
                                padding: EdgeInsets.only(right: 80),
                                child: Text(
                                  '${name}',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "tutor: benjamin perez",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  )),

                              isselected
                                  ? TextButton(
                                    style:TextButton.styleFrom(backgroundColor: Colors.white),
                                      onPressed: () {
                                        context.push("/ClinicalRecordScreen");
                                      },
                                      child: Text("Ficha clinica"))
                                  : Text("asd")
                            ],
                          ),
                        ],
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                )
              ]),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.8, // 80% del ancho de la pantalla
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white, // Color de fondo del botón
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Ajusta el radio de los bordes aquí
                    ), // Ajustar el relleno horizontal según sea necesario
                    // Puedes ajustar otras propiedades de estilo aquí según tus necesidades
                  ),
                  onPressed: () {
                    // modificar propiedad de user a seleccinar como paciente s true
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(uid)
                        .set({"isselectedbyvet": true});
                    // Acción al presionar el botón
                  },
                  child: const Text(
                    "Agregar Paciente",
                    style: TextStyle(color: Color(0xff3D9A51)),
                  ),
                ),
              )
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0), // Altura del TabBar
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                tabs: const [
                  Tab(
                    child: Text(
                      "Vacunas",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Antiparasitarios",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ],
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                ),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 0.0,
                isScrollable: false,
              ),
            ),
          ),
        ),
        body: TabBarView(children: [
          StreamBuilder<List<Vaccine>>(
            stream: getVaccineStream(
                uid), // Reemplaza 'userId' con el ID de usuario correcto
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                final vaccineStream = AsyncValue.data(snapshot.data ?? []);
                return VaccineView(vacinestream: vaccineStream);
              }
            },
          ),

          StreamBuilder<List<Antiparasites>>(
            stream: getAntiparasites(
                uid), // Reemplaza 'userId' con el ID de usuario correcto
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                final antiparasiteStream = AsyncValue.data(snapshot.data ?? []);
                return AntiparasitesView(antiparasites: antiparasiteStream);
              }
            },
          ),
          //crear un datasource para traerme los vaccine y antiparasites
          // y pasarselos a el vacine view y intoantiparasites

          // pressFalseorTrue
          //     ? const IntoVaccine()
          //     : VaccineView(
          //         vacinestream: vacinestream,
          //       ),
          // pressAntiparasites
          //     ? const IntoAntiparasites()
          //     : AntiparasitesView(
          //         antiparasites: antiparasites,
          //       )
        ]),
      ),
    );
  }
}

final uidUserProvider = StateProvider<String>((ref) {
  return "";
});
