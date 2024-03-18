// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'package:migu/domain/entities/antiparasites.dart';
import 'package:migu/domain/entities/vaccine.dart';
import 'package:migu/presentation/home/into_antiparasitic.dart';
import 'package:migu/presentation/home/into_vaccine.dart';
import 'package:migu/presentation/providers/Vaccineandantiparasites/vaccineandAntiparasites_provider.dart';

class HomeView extends ConsumerWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vacinestream = ref.watch(vaccineFirebaseProvider);
    final pressFalseorTrue = ref.watch(pressVaccineIntoProvider);
    final pressAntiparasites = ref.watch(pressAntiparasitesIntoProvider);
    final antiparasites = ref.watch(antiparasitesFirebaseProvider);

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
                  var type = snapshot.data!.get('type');
                  print("type$photoUrl");
                  // ref.read(namepetProvider.notifier).update((state) => name);
return photoUrl == ""
    ? type == "Perro"
        ? ClipOval( child: Image.asset("assets/perro.png",width: 40,)) // Si no hay foto y es un perro, muestra una imagen de gato
        : type == "otro"
            ? ClipOval(child: Image.asset("assets/conejo.png",width: 40)) // Si no hay foto y es otro, muestra una imagen específica
            : ClipOval(child: Image.asset("assets/gato.png",width: 40)) // Si no hay foto y no es un perro ni otro, muestra una imagen de perro
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
                    icon:
                        const Icon(Icons.arrow_drop_down, color: Colors.white),
                    itemBuilder: (BuildContext context) {
                      return [
                        '$name',
                        'Editar Mascota',
                        'Contactar Soporte',
                        "Patreon",
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
        : type == "Otro"
            ? ClipOval(child: Image.asset("assets/conejo.png",width: 40)) // Si no hay foto y es otro, muestra una imagen específica
            : ClipOval(child: Image.asset("assets/gato.png",width: 40)) // Si no hay foto y no es un perro ni otro, muestra una imagen de perro
    : CircleAvatar(
        backgroundImage: NetworkImage(
            photoUrl), // Si hay una foto, muestra el avatar del usuario
        radius: 18.0, // Radio para hacerlo redondo
    ),
                           
                                SizedBox(
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
                      }
                      // Aquí puedes definir las acciones que quieras realizar
                      // context.push("/Addantiparasitic");
                    },
                  );
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
                    'Carnet Veterinario',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
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
        body: TabBarView(
          children: [
            pressFalseorTrue
                ? const IntoVaccine()
                : VaccineView(
                    vacinestream: vacinestream,
                  ),
            pressAntiparasites
                ? const IntoAntiparasites()
                : AntiparasitesView(
                    antiparasites: antiparasites,
                  )
          ],
        ),
      ),
    );
  }
}

class AntiparasitesView extends ConsumerWidget {
  final AsyncValue<List<Antiparasites>> antiparasites;
  const AntiparasitesView({super.key, required this.antiparasites});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(

      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          CustomWidget1(
            isEmpty: antiparasites.value?.isEmpty ?? true,
            text: "Agregar Antiparasitario   ",
            message: "Aun no hay antiparasitarios registrados",
            type: "antiparasitic",
            route: "/Addantiparasitic",
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Historial ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                TextButton(
                    onPressed: () {
                      context.push("/Addantiparasitic");
                    },
                    child: const Icon(
                      Icons.add_circle_outline,
                      size: 30,
                      color: Color(0xff3D9A51),
                    ))
              ],
            ),
          ),
          antiparasites.when(
            data: (data) {
              if (data.isEmpty) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    // CustomWidget1(),
                    const Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Text(
                        "Aún no hay antiparasitarios registrados",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                    ),

                    Container(
                      padding: const EdgeInsets.all(30.0),
                      color: Colors.grey[200],
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 25),
                                      child: Icon(Icons.error_outline,
                                          color: Colors.black),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        "Importante: siempre consulta a un veterinario sobre cómo medicar a tu mascota",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.black),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 40,
                    )
                  ],
                );
              }

              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    Antiparasites antiparasitee = data[index];
                    late Widget leadingWidget;

                    if (antiparasitee.brand == "Bravecto") {
                      leadingWidget = Image.asset("assets/Frame1000004651.png");
                    } else {
                      leadingWidget =const Icon(Icons.image);
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Divider(
                          color: Colors.grey, // Color de la línea separadora
                          thickness: 0.9, // Grosor de la línea separadora
                          indent: 20, // Margen en el inicio de la línea
                          endIndent: 16, // Margen en el final de la línea
                        ),
                        ListTile(
                          onTap: () {
                            ref
                                .read(antiparasitesProvider.notifier)
                                .update((state) => antiparasitee);
                            ref
                                .read(pressAntiparasitesIntoProvider.notifier)
                                .update((state) => true);
                          },
                          leading: leadingWidget,
                          title: antiparasitee.brand == "Seleccionar"
                              ? const Text("No-Marca")
                              : Text(antiparasitee.brand),
                          subtitle: antiparasitee.type != "Seleccionar"
                              ? Text(
                                  "Desparasitario\n${antiparasitee.type}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : const Text(
                                  "No-Tipo",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${antiparasitee.date.day} ${getShortMonthName(antiparasitee.date.month)} ${antiparasitee.date.year} ',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.grey),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                              ), // Icono de flecha
                            ],
                          ),
                        ),
                      ],
                    );
                  });
            },
            error: (error, stackTrace) {
              return Text("error${error}");
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          SizedBox(height: 140,)
        ],
      ),
    ); // Contenido de la pestaña 2
  }
}

class VaccineView extends ConsumerWidget {
  final AsyncValue<List<Vaccine>> vacinestream;
  const VaccineView({
    Key? key,
    required this.vacinestream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          CustomWidget1(
              message: "Aún no hay vacunas registradas",
              isEmpty: vacinestream.value?.isEmpty ?? true,
              type: "vaccine",
              route: "/addvaccine",
              text: "  Agregar vacuna    "),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Historial ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                TextButton(
                    onPressed: () {
                      context.push("/addvaccine");
                    },
                    child: const Icon(
                      Icons.add_circle_outline,
                      size: 30,
                      color: Color(0xff3D9A51),
                    ))
              ],
            ),
          ),
          vacinestream.when(
            data: (data) {
              if (data.isEmpty) {
                return Column(
                  children: [
                    // CustomWidget1(),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 40),
                      child: Text(
                        "Aún no hay vacunas Registradas",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                    // const Spacer(
                    //   flex: 1,
                    // ),
                    Container(
                      padding: const EdgeInsets.all(30.0),
                      color: Colors.grey[200],
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 25),
                                      child: Icon(Icons.error_outline,
                                          color: Colors.black),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        "Importante: siempre consulta a un veterinario sobre cómo medicar a tu mascota",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.black),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 40,
                    )
                  ],
                );
              }

              return ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    Vaccine vaccine = data[index];
                    late Widget leadingWidget;

                    if (vaccine.brand == "Rabguard") {
                      leadingWidget = Image.asset('assets/Frame1000004649.png');
                    } else if (vaccine.brand == "Canigen") {
                      leadingWidget = Image.asset('assets/Frame13336.png');
                    } else if (vaccine.brand == "Nobivac") {
                      leadingWidget = Image.asset('assets/Frame1000004650.png');
                    } else {
                      leadingWidget = const Icon(Icons.image);
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Divider(
                          color: Colors.grey, // Color de la línea separadora
                          thickness: 0.9, // Grosor de la línea separadora
                          indent: 20, // Margen en el inicio de la línea
                          endIndent: 16, // Margen en el final de la línea
                        ),
                        ListTile(
                          onTap: () {
                            ref
                                .read(sightinProvider.notifier)
                                .update((state) => vaccine);
                            ref
                                .read(pressVaccineIntoProvider.notifier)
                                .update((state) => true);
                          },
                          leading: leadingWidget,
                          title: Text(vaccine.brand),
                          subtitle: Text(
                            vaccine.type,
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${vaccine.date.day} ${getShortMonthName(vaccine.date.month)} ${vaccine.date.year} ',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.grey),
                              ), // Texto que deseas mostrar
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                              ), // Icono de flecha
                            ],
                          ),
                        ),
                      ],
                    );
                  });
            },
            error: (error, stackTrace) {
              return Text("erros${error}");
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
          ),
                SizedBox(height: 140,)
        ],
      ),
    );
  }
}

Stream<List<Vaccine>> getVaccineFilter() {
  final currentDate = DateTime.now();
  final thirtyDaysFromNow = currentDate.add(Duration(days: 30));

  return FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("vaccine")
      .where('nextdose',
          isGreaterThan:
              currentDate) // Filtra las próximas dosis que están en el futuro
      .where('nextdose',
          isLessThan:
              thirtyDaysFromNow) // Filtra las próximas dosis que están dentro de los próximos 30 días
      .snapshots()
      .map((querySnapshot) {
    return querySnapshot.docs
        .map((doc) {
          final data = doc.data();
          final dateTimestamp = data['date'] as Timestamp;
          final nextDoseTimestamp = data['nextdose'] as Timestamp;
          final nextDoseDate = nextDoseTimestamp.toDate();

          // Calcula la diferencia en días entre la fecha actual y la próxima dosis
          final differenceInDays = nextDoseDate.difference(currentDate).inDays;

          // Si la diferencia es de 30 días o menos, devuelve la vacuna
          if (differenceInDays <= 30) {
            return Vaccine(
              photovaccinelabel: data["photovaccinelabel"],
              photocertificate: data["photocertificate"],
              vaccination: data["vaccination"],
              type: data['type'] ?? '',
              brand: data['brand'] ?? '',
              date: dateTimestamp.toDate(),
              nextdose: nextDoseDate,
              id: doc.id,
            );
          } else {
            return null; // Si la diferencia es mayor a 30 días, devuelve null
          }
        })
        .where((vaccine) => vaccine != null)
        .toList(); // Filtra las vacunas que no son nulas
  }).map((list) => list.cast<Vaccine>());
}

Stream<List<Antiparasites>> getAntiparasitesfilter() {
  final currentDate = DateTime.now();
  final thirtyDaysFromNow = currentDate.add(Duration(days: 30));

  return FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("Antiparasites")
      .where('nextdose',
          isGreaterThan:
              currentDate) // Filtra las próximas dosis que están en el futuro
      .where('nextdose',
          isLessThan:
              thirtyDaysFromNow) // Filtra las próximas dosis que están dentro de los próximos 30 días
      .snapshots()
      .map((querySnapshot) {
    return querySnapshot.docs
        .map((doc) {
          final data = doc.data();
          final dateTimestamp = data['date'] as Timestamp;
          final nextDoseTimestamp = data['nextdose'] as Timestamp;
          final nextDoseDate = nextDoseTimestamp.toDate();

          // Calcula la diferencia en días entre la fecha actual y la próxima dosis
          final differenceInDays = nextDoseDate.difference(currentDate).inDays;

          // Si la diferencia es de 30 días o menos, devuelve el antiparasitario
          if (differenceInDays <= 30) {
            return Antiparasites(
              type: data['type'] ?? '',
              brand: data['brand'] ?? '',
              date: dateTimestamp.toDate(),
              nextdose: nextDoseDate,
              id: doc.id,
            );
          } else {
            return null; // Si la diferencia es mayor a 30 días, devuelve null
          }
        })
        .where((antiparasite) => antiparasite != null)
        .toList(); // Filtra los antiparasitarios que no son nulos
  }).map((list) => list.cast<Antiparasites>());
}

String getShortMonthName(int monthNumber) {
  // Lista de nombres abreviados de los meses en español
  List<String> shortMonthNames = [
    'Ene',
    'Feb',
    'Mar',
    'Abr',
    'May',
    'Jun',
    'Jul',
    'Ago',
    'Sep',
    'Oct',
    'Nov',
    'Dic'
  ];

  // Retorna el nombre abreviado del mes correspondiente al número de mes proporcionado
  return shortMonthNames[monthNumber - 1];
}

class GetAntiparasitesfilter extends StatelessWidget {
  const GetAntiparasitesfilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Antiparasites>>(
      stream: getAntiparasitesfilter(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Muestra un indicador de carga mientras se carga el stream
          return const Padding(
            padding: EdgeInsets.all(40),
            child: Text("No hay Recordatorios"),
          );
        } else if (snapshot.hasError) {
          // Muestra un mensaje de error si ocurre un error
          return Text('Error: ${snapshot.error}');
        } else {
          // Muestra los datos si el stream ha sido cargado correctamente
          final antiparasitesList = snapshot.data ?? [];
          return antiparasitesList.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(40),
                  child: Text("No hay Recordatorios"))
              : Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    color: Colors.grey[200], // Fondo gris claro
                    padding: const EdgeInsets.all(20.0),
                    width: 340,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Mostrar los contenedores existentes con separadores
                        for (var i = 0; i < antiparasitesList.length; i++)
                          Column(
                            children: [
                              _buildAntiparasiteContainer(antiparasitesList[i]),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        width: 30, "assets/googlecalendar.png"),
                                    const SizedBox(
                                        width:
                                            8), // Espacio entre el icono y el texto
                                    const Text(
                                      'Añadir a Calendar',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ]),
                              if (i < antiparasitesList.length - 1)
                                const Divider(), // Agrega un Divider excepto después del último
                              // E
                            ],
                          ),
                      ],
                    ),
                  ),
                );
        }
      },
    );
  }

  Widget _buildAntiparasiteContainer(Antiparasites antiparasite) {
    DateTime currentDate = DateTime.now();
    int differenceInDays = currentDate.difference(antiparasite.date).inDays;
    bool isDelayed = differenceInDays > 0;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.notifications),
                  Text(
                    " Próxima dosis",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4), // Espacio entre los textos
              Text(
                "Desparasitario\n${antiparasite.type}",
                style: const TextStyle(
                  fontSize: 15,
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${antiparasite.nextdose.day} ${getShortMonthName(antiparasite.nextdose.month)} ${antiparasite.nextdose.year}", // Ajusta según tu modelo de datos
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4), // Espacio entre los textos
              // isDelayed
              //     ? Text(
              //         'La fecha está atrasada por $differenceInDays días.',
              //         style: const TextStyle(
              //           fontSize: 16.0,
              //           color: Colors.red,
              //         ),
              //       )
              //     : const Text("")
            ],
          ),
        ],
      ),
    );
  }
}

class GetVaccinefilter extends StatelessWidget {
  const GetVaccinefilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Vaccine>>(
      stream: getVaccineFilter(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Muestra un indicador de carga mientras se carga el stream
          return const Padding(
            padding: EdgeInsets.all(40),
            child: Text("No hay Recordatorios"),
          );
        } else if (snapshot.hasError) {
          // Muestra un mensaje de error si ocurre un error
          return Text('Error: ${snapshot.error}');
        } else {
          // Muestra los datos si el stream ha sido cargado correctamente
          final vaccineList = snapshot.data ?? [];
          return vaccineList.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(40),
                  child: Text("No hay Recordatorios"),
                )
              : Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    color: Colors.grey[200], // Fondo gris claro
                    padding: const EdgeInsets.all(20.0),
                    width: 330,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Mostrar los contenedores existentes con separadores
                        for (var i = 0; i < vaccineList.length; i++)
                          Column(
                            children: [
                              _buildVaccineContainer(vaccineList[i]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        width: 30, "assets/googlecalendar.png"),
                                    const SizedBox(
                                        width:
                                            8), // Espacio entre el icono y el texto
                                    const Text(
                                      'Añadir a Calendar',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ]),
                              if (i < vaccineList.length - 1)
                                const Divider(), // Agrega un Divider excepto después del último
                              // E
                            ],
                          ),
                      ],
                    ),
                  ),
                );
        }
      },
    );
  }

  Widget _buildVaccineContainer(Vaccine vaccine) {
    DateTime currentDate = DateTime.now();
    int differenceInDays = currentDate.difference(vaccine.date).inDays;
    bool isDelayed = differenceInDays > 0;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.notifications),
                  Text(
                    " Próxima dosis",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4), // Espacio entre los textos
              Text(
                vaccine.brand,
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${vaccine.nextdose.day} ${getShortMonthName(vaccine.nextdose.month)} ${vaccine.nextdose.year}", // Ajusta según tu modelo de datos
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4), // Espacio entre los textos
              // isDelayed
              //     ? Text(
              //         '$differenceInDays días de atraso.',
              //         style: const TextStyle(
              //           fontSize: 16.0,
              //           color: Colors.red,
              //         ),
              //       )
              //     : const Text("")
            ],
          ),
        ],
      ),
    );
  }
}

class CustomWidget1 extends ConsumerWidget {
  final String message;
  final String route;
  final String type;
  final bool isEmpty;
  final String text;

  const CustomWidget1({
    Key? key,
    this.isEmpty = false,
    this.message = "",
    this.type = "",
    this.text = "",
    this.route = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double containerWidth = MediaQuery.of(context).size.width * 0.8;

    if (isEmpty) {
      return Container(
        padding: const EdgeInsets.all(15.0),
        color: Colors.grey[200], // Fondo gris claro
        width: containerWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Próxima dosis',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4), // Espacio entre los textos
            Text(
              "${message}",
              style: TextStyle(fontSize: 15.0, color: Colors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: containerWidth,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.push("${route}");
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "${text}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Bordes redondeados
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10), // Espaciado interno del botón
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xff00B368)), // Color de fondo del botón
                ),
              ),
            ),
          ],
        ),
      );
    }
    return type == "antiparasitic"
        ? const GetAntiparasitesfilter()
        : const GetVaccinefilter();
  }
}

final sightinProvider = StateProvider<Vaccine>((ref) {
  return Vaccine(
      brand: "",
      date: DateTime.now(),
      nextdose: DateTime.now(),
      photocertificate: "",
      photovaccinelabel: "",
      type: "",
      vaccination: "",
      id: "");
});

final pressVaccineIntoProvider = StateProvider<bool>((ref) {
  return false;
});

final pressAntiparasitesIntoProvider = StateProvider<bool>((ref) {
  return false;
});
