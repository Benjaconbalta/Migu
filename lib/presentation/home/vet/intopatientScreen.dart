import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:migu/domain/entities/antiparasites.dart';
import 'package:migu/domain/entities/vaccine.dart';
import 'package:migu/infrastrocture/mappers/vaccine_mapper.dart';
import 'package:migu/presentation/providers/Vaccineandantiparasites/vaccineandAntiparasites_provider.dart';
import 'package:migu/presentation/providers/vets/vets_provider.dart';
import 'package:migu/presentation/views/home_view.dart';


final intoVaccinefromVetProvider = StateProvider<bool>((ref) {
  return false;
});
final intoAntiparasitedfromVetProvider = StateProvider<bool>((ref) {
  return false;
});

final gmailProvider = StateProvider<String>((ref) {
  return "";
});

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

class IntopatientScreen extends ConsumerStatefulWidget {
  const IntopatientScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IntoPatientScreenState();
}

class _IntoPatientScreenState extends ConsumerState<IntopatientScreen> {
  late String gmailGlobal = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchGmail();
    });
  }

  Future<void> _fetchGmail() async {
    final uid = ref.read(uidUserProvider);
    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get();
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      setState(() {
        gmailGlobal = data['gmail'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final uid = ref.watch(uidUserProvider);
    final intoVaccinefromVet = ref.watch(intoVaccinefromVetProvider);
    final intoantiparasitesfromvet =
        ref.watch(intoAntiparasitedfromVetProvider);
    final profileVet = ref.watch(getProfileProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
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
                      var data = snapshot.data!.data() as Map<String, dynamic>;

                      var photoUrl = snapshot.data!.get('urlImage');
                      var name = snapshot.data!.get('name');
                      var type = snapshot.data!.get('type');
                      var namepet = data['namePet'] ?? '';
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Alinea los elementos a los extremos
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 70),
                                    child: Text(
                                      ' ${namepet.isNotEmpty ? "${namepet}" : "${name}"}',
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),

                                  // Padding(
                                  //   padding: EdgeInsets.only(left: 10),
                                  //   child: Text(
                                  //     "tutor: benjamin perez",
                                  //     style: TextStyle(
                                  //       color: Colors.grey[400],
                                  //       fontSize: 16,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                )
              ]),

              profileVet.when(
                data: (data) {
                  if (data.isEmpty) {
                    return const Text("");
                  }
                  return Column(
                    children: data.map((e) {
                      if (e["patients"].contains(uid)) {
                        // Accede de manera segura al campo 'gmail'
                      
                        return Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () =>
                                      context.push("/ClinicalRecordScreen"),
                                  child:const Text(
                                    "Ficha clinica ",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              const  Icon(Icons.arrow_right_rounded),
                             const   SizedBox(width: 90),
                                IconButton(
                                  onPressed: () {
                                    // Acción al presionar el icono de flecha
                                  },
                                  icon: const Icon(Icons.check),
                                ),
                              ],
                            ),
                          const  SizedBox(height: 5),
                            Column(
                              children: [
                                Row(
                                  children: [
                                 const   Icon(Icons.email),
                                    Text( 
                                       gmailGlobal,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                             
                              ],
                            ),
                          ],
                        );
                      } else {
                        return Container(); // Devuelve un contenedor vacío si el uid no está en los pacientes
                      }
                    }).toList(),
                  );
                },
                error: (error, stackTrace) {
                  return Text("Error: $error");
                },
                loading: () {
                  return const CircularProgressIndicator();
                },
              ),

              //                 SizedBox(height: 10,),

              // SizedBox(
              //   height: 20,
              // ),
              SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.8, // 80% del ancho de la pantalla
                child: (profileVet.maybeWhen(
                  data: (data) => !data.any((e) => e["patients"].contains(
                      uid)), // Verifica si el UID no está en la lista de pacientes
                  orElse: () =>
                      true, // Si no hay datos o hay un error, muestra el botón por defecto
                ))
                    ? FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor:
                              Colors.white, // Color de fondo del botón
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Ajusta el radio de los bordes aquí
                          ), // Ajustar el relleno horizontal según sea necesario
                          // Puedes ajustar otras propiedades de estilo aquí según tus necesidades
                        ),
                        onPressed: () {
                          if (profileVet.value!.isEmpty) {
                            final snackbar =   SnackBar(
                                content:
                                   const Text("Primero debes Completar Tu Perfil"));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          } else {
                            FirebaseFirestore.instance
                                .collection("vets")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update({
                              "patients": FieldValue.arrayUnion([uid])
                            });
                          }
                        },
                        child: const Text(
                          "Agregar Paciente",
                          style: TextStyle(color: Color(0xff3D9A51)),
                        ),
                      )
                    : const SizedBox
                        .shrink(), // Si el UID está en la lista, oculta el botón
              ),
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
        body: intoVaccinefromVet
            ? VaccineintoViewFromVet(
                key: widget.key,
              )
            : TabBarView(children: [
                StreamBuilder<List<Vaccine>>(
                  stream: getVaccineStream(
                      uid), // Reemplaza 'userId' con el ID de usuario correcto
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      final vaccineStream =
                          AsyncValue.data(snapshot.data ?? []);
                      return VaccineView(vacinestream: vaccineStream, true);
                    }
                  },
                ),

                intoantiparasitesfromvet
                    ? AntiparasiteViewFromVet(
                        key: widget.key,
                      )
                    : StreamBuilder<List<Antiparasites>>(
                        stream: getAntiparasites(
                            uid), // Reemplaza 'userId' con el ID de usuario correcto
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(child:  CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else {
                            final antiparasiteStream =
                                AsyncValue.data(snapshot.data ?? []);
                            return AntiparasitesView(
                                antiparasites: antiparasiteStream, true);
                          }
                        },
                      ),
              ]),
      ),
    );
  }

}

final uidUserProvider = StateProvider<String>((ref) {
  return "";
});

class AntiparasiteViewFromVet extends ConsumerWidget {
  const AntiparasiteViewFromVet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final antipasites = ref.watch(antiparasitesProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
        const  SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () {
                  ref
                      .read(intoAntiparasitedfromVetProvider.notifier)
                      .update((state) => false);
                  // ref.read(editantiparasitesProvider.notifier).update((state) => false);
                  // ref.read(pressAntiparasitesIntoProvider.notifier).update((state) => false);
                },
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                label:
                    const Text("Atras", style: TextStyle(color: Colors.black)),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share),
                label: const Text("Compartir"),
              ),
            ],
          ),
          Container(
            height: 100,
            width: screenWidth * 0.9,
            padding: const EdgeInsets.all(10.0),
            color: Colors.grey[200],
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (antipasites.brand == "Bravecto")
                      Image.asset('assets/Frame1000004651.png',
                          width: screenWidth * 0.15),
                    if (antipasites.brand != "Bravecto")
                      Icon(Icons.image, size: screenWidth * 0.19),
                  ],
                ),
                SizedBox(width: screenWidth * 0.05),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    antipasites.type.isEmpty
                        ? const Text("No-Tipo")
                        : Text(
                            " Antiparasitario ${antipasites.type}",
                            style: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                    const SizedBox(height: 4),
                    antipasites.brand == "Seleccionar"
                        ? const Text("No-Marca")
                        : Text(
                            "${antipasites.brand}",
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.red),
                          ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.3),
            child: RichText(
              text: TextSpan(
                children: [
                const  TextSpan(
                      text: "Ultima dosis: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                  TextSpan(
                      text:
                          "${antipasites.date.day} ${getShortMonthName(antipasites.date.month)} ${antipasites.date.year}",
                      style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.3),
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                      text: "Proxima dosis: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                  TextSpan(
                      text:
                          "${antipasites.nextdose.day} ${getShortMonthName(antipasites.nextdose.month)} ${antipasites.nextdose.year}",
                      style: const TextStyle(color: Colors.black)),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.2),
     
        const  SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}

class VaccineintoViewFromVet extends ConsumerWidget {
  const VaccineintoViewFromVet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final info = ref.watch(sightinProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () {
                  ref
                      .read(intoVaccinefromVetProvider.notifier)
                      .update((state) => false);
                },
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                label: const Text(
                  "Atras",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share),
                label: const Text("Compartir"),
              ),
            ],
          ),
          Container(
            height: screenHeight * 0.1,
            width: screenWidth * 0.7,
            padding: EdgeInsets.all(screenWidth * 0.03),
            color: Colors.grey[200],
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (info.brand != "Rabguard" &&
                        info.brand != "Canigen" &&
                        info.brand != "Nobivac")
                      Icon(Icons.image, size: screenHeight * 0.07),
                    if (info.brand == "Rabguard")
                      Image.asset(
                        'assets/Frame1000004649.png',
                        height: screenHeight * 0.07,
                        width: screenHeight * 0.07,
                      ),
                    if (info.brand == "Canigen")
                      Image.asset(
                        'assets/Frame13336.png',
                        height: screenHeight * 0.07,
                        width: screenHeight * 0.07,
                      ),
                    if (info.brand == "Nobivac")
                      Image.asset(
                        'assets/Frame1000004650.png',
                        width: screenHeight * 0.07,
                        height: screenHeight * 0.07,
                      ),
                  ],
                ),
                SizedBox(width: screenWidth * 0.05),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${info.brand}",
                      style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      "${info.type}",
                      style: TextStyle(
                          fontSize: screenWidth * 0.035, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.2),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Ultima dosis: ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                    text:
                        "${info.date.day} ${getShortMonthName(info.date.month)} ${info.date.year}",
                    style: TextStyle(
                        color: Colors.black, fontSize: screenWidth * 0.035),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.2),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Proxima dosis: ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                    text:
                        "${info.nextdose.day} ${getShortMonthName(info.nextdose.month)} ${info.nextdose.year}",
                    style: TextStyle(
                        color: Colors.black, fontSize: screenWidth * 0.035),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Container(
            height: screenHeight * 0.1,
            width: screenWidth * 0.7,
            padding: EdgeInsets.all(screenWidth * 0.03),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Etiqueta Vacuna"),
                const Icon(Icons.help),
                "" == ""
                    ? const Text("no-Image")
                    : GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Etiqueta Vacuna"),
                                content: Image.network(
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      // Si la imagen ya se ha cargado, simplemente muestra la imagen
                                      return child;
                                    } else {
                                      // Si la imagen aún se está cargando, muestra un indicador de progreso
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                        ),
                                      );
                                    }
                                  },
                                  "",
                                  width: 20,
                                ),
                              );
                            },
                          );
                        },
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Etiqueta Vacuna"),
                                  content: Image.network(
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        // Si la imagen ya se ha cargado, simplemente muestra la imagen
                                        return child;
                                      } else {
                                        // Si la imagen aún se está cargando, muestra un indicador de progreso
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                          ),
                                        );
                                      }
                                    },
                                    "",
                                    width: 20,
                                  ),
                                );
                              },
                            );
                          },
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const  Text("Certificado"),
                                    content: Image.network(
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          // Si la imagen ya se ha cargado, simplemente muestra la imagen
                                          return child;
                                        } else {
                                          // Si la imagen aún se está cargando, muestra un indicador de progreso
                                          return const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.black,
                                            ),
                                          );
                                        }
                                      },
                                      "",
                                      width: 20,
                                    ),
                                  );
                                },
                              );
                            },
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Etiqueta Vacuna:"),
                                      content: Image.network(
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            // Si la imagen ya se ha cargado, simplemente muestra la imagen
                                            return child;
                                          } else {
                                            // Si la imagen aún se está cargando, muestra un indicador de progreso
                                            return const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.black,
                                              ),
                                            );
                                          }
                                        },
                                        "",
                                        width: 20,
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: screenWidth * 0.2,
                                height: screenWidth * 0.2,
                                child: Image.network(
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      // Si la imagen ya se ha cargado, simplemente muestra la imagen
                                      return child;
                                    } else {
                                      // Si la imagen aún se está cargando, muestra un indicador de progreso
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                        ),
                                      );
                                    }
                                  },
                                  "",
                                  width: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Certificado:"),
                    content: Image.network(
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          // Si la imagen ya se ha cargado, simplemente muestra la imagen
                          return child;
                        } else {
                          // Si la imagen aún se está cargando, muestra un indicador de progreso
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          );
                        }
                      },
                      "",
                      width: 20,
                    ),
                  );
                },
              );
            },
            child: Container(
              height: screenHeight * 0.1,
              width: screenWidth * 0.7,
              padding: EdgeInsets.all(screenWidth * 0.03),
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Certificado"),
                  const Icon(Icons.help),
                  "" == ""
                      ? const Text("no-Image")
                      :  Container(
                          width: screenWidth * 0.2,
                          height: screenWidth * 0.2,
                          child: Image.network(
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                // Si la imagen ya se ha cargado, simplemente muestra la imagen
                                return child;
                              } else {
                                // Si la imagen aún se está cargando, muestra un indicador de progreso
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                );
                              }
                            },
                            "",
                            width: 20,
                          ),
                        ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
       const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
