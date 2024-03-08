import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:migu/domain/entities/antiparasites.dart';
import 'package:migu/domain/entities/vaccine.dart';
import 'package:migu/presentation/auth/Addpet_Screen.dart';
import 'package:migu/presentation/home/into_antiparasitic.dart';
import 'package:migu/presentation/home/into_vaccine.dart';
import 'package:migu/presentation/providers/Vaccineandantiparasites/vaccineandAntiparasites_provider.dart';
import 'package:migu/presentation/providers/auth/auth_provider.dart';

class HomeView extends ConsumerWidget {
  const  HomeView({super.key,});

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
                  // ref.read(namepetProvider.notifier).update((state) => name);
                  return CircleAvatar(

                    backgroundImage:
                        NetworkImage(photoUrl), // Imagen del perfil del usuario
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
                                Text("🐶"),
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
          backgroundColor: Color(0xFF272B4E), // Color azul marino
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
                  Tab(text: 'Vacunas'), // Pestaña 1
                  Tab(text: 'Antiparasitarios'), // Pestaña 2
                ],
                indicator: BoxDecoration(
                  color: Colors
                      .white, // Color del fondo de la pestaña seleccionada
                  borderRadius: BorderRadius.circular(3), // Borde redondeado
                ),

                labelColor:
                    Colors.black, // Color del texto de la pestaña seleccionada
                unselectedLabelColor: Colors
                    .grey, // Color del texto de la pestaña no seleccionada
                indicatorColor: Colors.white, // Color de la línea indicadora
                indicatorSize:
                    TabBarIndicatorSize.tab, // Tamaño de la línea indicadora
                indicatorWeight: 0.0, // Grosor de la línea indicadora
                isScrollable: false, // Desactiva el desplazamiento del TabBar
                // backgroundColor: Colors.blue[900], // Color del TabBar (opcional, puedes comentarlo para que coincida con el color del AppBar)
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Center(
                child: pressFalseorTrue
                    ? const IntoVaccine()
                    : Column(
                        children: [
                        const  SizedBox(
                            height: 20,
                          ),
                          CustomWidget1(
                              message: "Aún no hay vacunas registradas",
                              isEmpty: vacinestream.value?.isEmpty ?? true,
                              type: "vaccine",
                              route: "/addvaccine",
                              text: "  Agregar vacuna    "),
                        const  SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:const EdgeInsets.only(left: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              const  Text(
                                  "Historial ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                TextButton(
                                    onPressed: () {
                                      context.push("/addvaccine");
                                    },
                                    child:const Icon(
                                      Icons.add_circle_outline,
                                      size: 30,
                                    ))
                              ],
                            ),
                          ),
                         const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                              child: vacinestream.when(
                            data: (data) {
                              if (data.isEmpty) {
                                return Column(
                                  children: [
                                    // CustomWidget1(),
                                 const   Padding(
                                      padding:  EdgeInsets.only(right: 40),
                                      child: Text(
                                        "Aún no hay vacunass registradas",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                    ),
                                const   Spacer(
                                      flex: 1,
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
                  child: Icon(Icons.error_outline, color: Colors.black),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    "Importante: siempre consulta a un veterinario sobre cómo medicar a tu mascota",
                    style: TextStyle(fontSize: 14, color: Colors.black),
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


                                  const  SizedBox(
                                      height: 40,
                                    )
                                  ],
                                );
                              }

                              return ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    Vaccine vaccine = data[index];

                                    // DocumentSnapshot document =

                                    //     snapshot.data!.docs[index];

                                    late Widget leadingWidget;

                                    // Comprobamos la marca de la vacuna y asignamos la imagen correspondiente
                                    if (vaccine.brand == "Rabguard") {
                                      leadingWidget = Image.asset(
                                          'assets/Frame1000004649.png');
                                    } else if (vaccine.brand == "Canigen") {
                                      leadingWidget =
                                          Image.asset('assets/Frame13336.png');
                                    } else if (vaccine.brand == "Nobivac") {
                                      leadingWidget = Image.asset(
                                          'assets/Frame1000004650.png');
                                    } else {
                                      leadingWidget =const Icon(Icons.image);
                                    }

                                    // Agrega más
                                    // Aquí puedes acceder a los datos de cada documento
                                    // Por ejemplo, para acceder al campo "nombre":
                                    // String nombre = document['nombre'];
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                       const Divider(
                                          color: Colors
                                              .grey, // Color de la línea separadora
                                          thickness:
                                              0.9, // Grosor de la línea separadora
                                          indent:
                                              20, // Margen en el inicio de la línea
                                          endIndent:
                                              16, // Margen en el final de la línea
                                        ),
                                        ListTile(
                                          onTap: () {
                                            ref
                                                .read(sightinProvider.notifier)
                                                .update((state) => vaccine);
                                            ref
                                                .read(pressVaccineIntoProvider
                                                    .notifier)
                                                .update((state) => true);
                                          },
                                          leading: leadingWidget,
                                          title: Text(vaccine.brand),
                                          subtitle: Text(
                                            vaccine.type,
                                            style:const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                '${vaccine.date.day} ${getShortMonthName(vaccine.date.month)} ${vaccine.date.year} ',
                                                style:const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey),
                                              ), // Texto que deseas mostrar
                                            const  Icon(
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
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          )

                              //  ListView.builder(
                              //   itemCount: 4,
                              //   itemBuilder: (context, index) {
                              //  return ListTile(
                              //    leading: Image.network(
                              //        "https://w7.pngwing.com/pngs/23/16/png-transparent-pharmacy-logo-pharmaceutical-drug-pasteur-blue-drug-pharmacist.png"),
                              //    title: Text("Rabguard"),
                              //    subtitle: Text("Antirrabica"),
                              //    trailing: Text("8 dic 2021"),
                              //  );
                              //   },
                              // ),
                              )
                        ],
                      )), // Contenido de la pestaña 1
            pressAntiparasites
                ?const IntoAntiparasites()
                : Column(
                    children: [
                    const  SizedBox(
                        height: 20,
                      ),
                      CustomWidget1(
                        isEmpty: antiparasites.value?.isEmpty ?? true,
                        text: "   agregar antiparasitario   ",
                        message: "Aun no hay antiparasitarios registrados",
                        type: "antiparasitic",
                        route: "/Addantiparasitic",
                      ),
                    const  SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           const Text(
                              "Historial ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            TextButton(
                                onPressed: () {
                                  context.push("/Addantiparasitic");
                                },
                                child:const Icon(
                                  Icons.add_circle_outline,
                                  size: 30,
                                ))
                          ],
                        ),
                      ),
                      Expanded(
                        child: antiparasites.when(
                          data: (data) {
                            if (data.isEmpty) {
                              return Column(
                                children: [
                               const   SizedBox(
                                    height: 20,
                                  ),
                                  // CustomWidget1(),
                                const  Padding(
                                    padding:  EdgeInsets.only(right: 20),
                                    child: Text(
                                      "Aún no hay antiparasitarios registrados",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ),
                              const    Spacer(
                                    flex: 1,
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
                  child: Icon(Icons.error_outline, color: Colors.black),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    "Importante: siempre consulta a un veterinario sobre cómo medicar a tu mascota",
                    style: TextStyle(fontSize: 14, color: Colors.black),
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
                                itemBuilder: (context, index) {
                                  Antiparasites antiparasitee = data[index];
                                  late Widget leadingWidget;

                                  if (antiparasitee.brand == "Bravecto") {
                                    leadingWidget = Image.asset(
                                        "assets/Frame1000004651.png");
                                  } else {
                                    leadingWidget = Icon(Icons.image);
                                  }
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                   const   Divider(
                                        color: Colors
                                            .grey, // Color de la línea separadora
                                        thickness:
                                            0.9, // Grosor de la línea separadora
                                        indent:
                                            20, // Margen en el inicio de la línea
                                        endIndent:
                                            16, // Margen en el final de la línea
                                      ),
                                      ListTile(
                                        onTap: () {
                                          ref
                                              .read(antiparasitesProvider
                                                  .notifier)
                                              .update((state) => antiparasitee);
                                          ref
                                              .read(
                                                  pressAntiparasitesIntoProvider
                                                      .notifier)
                                              .update((state) => true);
                                        },
                                        leading: leadingWidget,
                                        title: antiparasitee.brand=="Seleccionar" ? const Text("No-Marca"): Text(antiparasitee.brand),
                                        subtitle:  antiparasitee.type !="Seleccionar" ?Text(
                                          antiparasitee.type,
                                          style:const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ) : Text(
                                          "No-Tipo",
                                          style:const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ) ,
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              '${antiparasitee.date.day} ${getShortMonthName(antiparasitee.date.month)} ${antiparasitee.date.year} ',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey),
                                            ),
                                          const  Icon(
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
                      )
                    ],
                  ) // Contenido de la pestaña 2
          ],
        ),
      ),
    );
  }
}

Stream<List<Vaccine>> getvaccinefilter() {
  final currentDate = DateTime.now();
  final twoMonthsFromNow =
      currentDate.add(Duration(days: 60)); // 60 días = 2 meses

  return FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("vaccine")
      .where('nextdose',
          isGreaterThan:
              currentDate) // Filtra las próximas dosis que están en el futuro
      .where('nextdose',
          isLessThan:
              twoMonthsFromNow) // Filtra las próximas dosis que están dentro de los próximos 2 meses
      .snapshots()
      .map((querySnapshot) {
    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      final dateTimestamp = data['date'] as Timestamp;
      final nextdoseTimestamp = data['nextdose'] as Timestamp;
      return Vaccine(
        photovaccinelabel: data["photovaccinelabel"],
        photocertificate: data["photocertificate"],
        vaccination: data["vaccination"],
        type: data['type'] ?? '',
        brand: data['brand'] ?? '',
        date: dateTimestamp.toDate(),
        nextdose: nextdoseTimestamp.toDate(),
        id: doc.id,
      );
    }).toList();
  }).map((list) => list.cast<Vaccine>());
}

Stream<List<Antiparasites>> getAntiparasitesfilter() {
  final currentDate = DateTime.now();
  final twoMonthsFromNow =
      currentDate.add(const Duration(days: 60)); // 60 días = 2 meses

  return FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("Antiparasites")
      .where('nextdose',
          isGreaterThan:
              currentDate) // Filtra las próximas dosis que están en el futuro
      .where('nextdose',
          isLessThan:
              twoMonthsFromNow) // Filtra las próximas dosis que están dentro de los próximos 2 meses
      .snapshots()
      .map((querySnapshot) {
    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      final dateTimestamp = data['date'] as Timestamp;
      final nextdoseTimestamp = data['nextdose'] as Timestamp;
      return Antiparasites(
        type: data['type'] ?? '',
        brand: data['brand'] ?? '',
        date: dateTimestamp.toDate(),
        nextdose: nextdoseTimestamp.toDate(),
        id: doc.id,
      );
    }).toList();
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
          return Padding(
            padding: const EdgeInsets.all(40),
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
                              if (i < antiparasitesList.length - 1)
                              const  Divider(), // Agrega un Divider excepto después del último
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

    return  Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           const   Row(
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
          const    SizedBox(height: 4), // Espacio entre los textos
              Text(
                antiparasite.brand,
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${antiparasite.date.day} ${getShortMonthName(antiparasite.date.month)} ${antiparasite.date.year}", // Ajusta según tu modelo de datos
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const  SizedBox(height: 4), // Espacio entre los textos
              isDelayed
                  ? Text(
                      'La fecha está atrasada por $differenceInDays días.',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.red,
                      ),
                    )
                  : const Text("")
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
      stream: getvaccinefilter(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Muestra un indicador de carga mientras se carga el stream
          return const Padding(
            padding: const EdgeInsets.all(40),
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
                  padding:  EdgeInsets.all(40),
                  child: Text("No hay Recordatorios"),
                )
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
                        for (var i = 0; i < vaccineList.length; i++)
                          Column(
                            children: [
                              _buildVaccineContainer(vaccineList[i]),
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
           const   SizedBox(height: 4), // Espacio entre los textos
              Text(
                vaccine.brand,
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${vaccine.date.day} ${getShortMonthName(vaccine.date.month)} ${vaccine.date.year}", // Ajusta según tu modelo de datos
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const  SizedBox(height: 4), // Espacio entre los textos
              isDelayed
                  ? Text(
                      '$differenceInDays días de atraso.',
                      style:const TextStyle(
                        fontSize: 16.0,
                        color: Colors.red,
                      ),
                    )
                  :const Text("")
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
            Text(
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
                icon: const Icon(Icons.add,color: Colors.white,),
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
                      borderRadius: BorderRadius.circular(10), // Bordes redondeados
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10), // Espaciado interno del botón
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

class Historial extends StatelessWidget {
  const Historial({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
          const  Text("Historial "),
            IconButton(onPressed: () {}, icon: const Icon(Icons.abc))
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(
                    "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAO0AAADVCAMAAACMuod9AAAAwFBMVEX///8AmQDPz8/MzMzOzs7Ly8sAlwDy8vLd3d3IyMj19fXa2tr39/fY2NjS0tL8/PwAkABIq0ji4uJjtWO427jt7e1ar1rc2NxUq1TW0dYAjABnuGen0Kf//P/0+PTk4OTk8eTO5c7w9/Cu0653vHeKxIpqs2ognSCVx5UxojG83LyhzKHU6dQ3ojfc6tx9u31LqUvD3sMwmjBdtl3E2cSHwoeTyJMbnRux0LHd591utW52snaDuIN/wX+Yw5jd1N3Ohif3AAAO7ElEQVR4nO2de2PiKgLFo0nQ6ytYW2utdeKjWrW+7t22d2d39n7/b7UEyItAAgnx0ZF/TnU6Jqdw+AVI0DBQsatVk1FLoFWOOma12uGrJdI20paCNiPaEGgNaT1VjZtbVbe2vMsLcPuHaf+B1aZq2rZATfp7VkzN4HWVUewuUJNR9n3bxu7Q67iy79t2k77GbgO1Y69r6DV2iV4TNWybcRqqLVC+Y1vScbbGHYq1GdEGR+sxx1hRY7QLtGIj2YqlMqvSmmVacSOzFWPV5dZWy+yZ3JqmSbMaqC1Qk6rFV9pyQ+VnVaz8zIo1nlmTyazJZJaoUWpmcZ9dQmaj2eVlNt5L+WowrfjGW2ne2tmZvQC3xTNrVhmlWZTWdkRlMxtk104qdpfQG29vvJXgrcVkV/hXOKNby7JIy7UsO66mryZVS6BVnlpPT4+ePvH1JUNbtkUyzNFmRBscJRm1bJ4apWT28S8IAEQFAGWF3acr4+3jM6jkLaD/dMG8NdjMIr1gt8nMBkrco3ALtMpRB2lBt7kz2yQZ9bPLqApvTUZTOTso4LZ3bbwt7PZSeZvI7AW7tWhG7VBNRlUzq8Ut+hyaVUslsw1hZonKZVaZt8V6qRtvz89b6wp5qzmzGnjLZjbQZkQbHKUZFeiNtzfeqmS2TLdprtV4qyuzJfE2nlkzqcRVuspl9sbb34a31nXzVmdmtfHWtAJtRpSX2aZEZpHbG28VMvvteZuZWd1uZV3LucUuzVAtgVY5KlobOHXdCl1acZXL7KXxNiuzN94q8zaR2SvkbUpWJTNbTt1a1CXVRoryMprUU/IW0JLp9hvwFsLD6+b+fvN5yPJ7EbyVzizPLdyuHcMvf6+gilu9vFXJqmHRzFq0LgX6EnMLVkcjVmZpdrFb9Dk0s1WaTaHSbGbpqXgL9wZbdimt+bp5C2e+R9d1gx/FdsvnbUZ2rQK8hf8i/tYHb/Ed9Kn3ibAxl+zWoq4iWk3RrMx6GrqFG3yM6QqSdwCsrPE7c1HtIrexzKZlVzKz1RPxFvSxtXEUO/DDe8sRVe4V8xaOsdtlrCLhyHvvU1C5p+Ut49rKym4abwFpxxumHvHfwBVU7gl4K5HZrKzyeEurlq1F8Oq9u01xK8lb+cwSNcrkLVjgA6wTtbjk1bjv9lp5CwhufibqdoXff+XaPRtvMzObwVv4jg/QZf2QKhdcY5TN207HoloVKMlkpyqrjz3ilgwFgMAsaswcuyFvOzSjfK0hradpldWSeQuJJ7ZH3gVup5y2fLW8pW6ZCoTTwO2YV7fn4G0is2nZFfCWumVQA93ALY+5JfK242XWcUhG+dpB6sip4etLzC3TJ4NR4PZeVLdVL5uO0UjROtKakuISPLUYavpTi/5TikmtUvX7ZNJL3TM1uArcLvi9lNpTFNJPQBn8VqyLt5RA7AAArn23ZyBQyFsrT2ZTeAvuiak31hW5oDTeeZcXJbp1UjJbpZnMoZS3AVmXjKEBeZuHW89tB2XTQdmMqhFVmsUsZbIbeWpRW2aj41tAZxrZvhe+4be54wLCW8UnoDgaz6x5gvEtHfEZxo61OxE15NPwNsisRt4GQz5Uu1/MDPPRGC85XsvmrZ9RVvNmto30hZmp8f4QexifwFjyQkvcspmNKcqgU8uhd+Q8/tCf3XAWDsx9u8buAAUG426vlbe4Dn8Gdo3dAkqsepXNW6sk3pKzP4SjAMOY9WBGDed1m51dzFtRZh9R8U5QoC8p+iO6MgLgfcSu4UxeVwCKlzZB75/HH/7nKGtadjm7BPgZNc2/np+fB6g859BVzADcvhux4uzWHz0A+e16u8Cf00cf01PVQ17ePkGQv7D1BQeMX69MJ5s+r10XOC58SudtIrO+607+mwk4BcDtMekXlff9l1RXLXmYjgJvo9x80urW8/v1NuUb7mvzC55IRjudhCZ4G89u6gp6vnOBvTXXr7vQdDCYm7f63Xp+4TPX8KSipXphNm+Td9uX5raCDR9GnCY90HE87FZ4x64jviYuy23F63Th6nPH2v3QcEBokKw6TkzvkD500nblsTT3UkwBcPnpxu32ih8RWHl5W65b79Tgahazq8FtKm/FT8ho5q2gQBD1K74ZQ7YEvOVmt8NkthNqW2p4VrjAbqTH6qZ+osz5tLmZJWowmY1lV+IPDbrFCwSh3TXcpvymhF0ozKwG3kYWOXIXF3wFP4/hq/gX2bktgdsSefvl8M9MpUyGm+Dn1VL4a86XxPlk8hZnlaMvMm4B4IxtVMtyG/w4B6Jf2kldbMGXcnkL+/dj0RlKls9h+CPkDhzG93257rp03qJutXIYvK354xtFt38P3fi/Tddvg0NFYjqLnswpeOuRBF0M5jQsdDv9XMGUOR3eiWTyVpBdKd7GDwW7kzxu96HbUaQlT7rqw14Bbx+08Dbpd5vDbzdE0Af0O/nJNs8Qv1Te8o7XU27Py2BBwVjQPnnayzedcfLxLYAjQ6mM4a/g50oPyyzv1E25vOUfcqB0zXEM1+rHeKnTyT+wZ3gbZrbE8S2oJIbqKWUf9kzHIbpYcQtM2pxnfAtnHFuCAsK7Tn6CjAdKMt2eZ3wbXexKL2sYXCa/oP/1s9AYN5237XabZDWpj8VG82DlyrldwuDHEVxvCx71kWa2TbMaVXwMjbyNHRhItebRMOzCvypF51lPzdvoobvZ6HVhOABi7yLL5/Zs88mA3jsjLs4y7JAdDRNhErzlZzc/byMFAP5SCC2NJfx38CJxi3qOgnnbpnNRbHZPMJ8MlzPhtcY7AKFZDe34EuaTYWXPvdiYzofbMNiiB2bUijRv2exqnE8G8Gt/jM9wjCeLYQhaZF3P0SR422qRrMa1IG/Z04Cwstjc79wpbtfjIayMIi18qmeJD/G2XXdaXmbbd0gfYmowmdXJW86pwCE4HIZj7DbWW+9U5ifSyhl5yxQAP3be1QRxGx0WaumgcMnFW7MEt/BXy/vUpFtH18J8JYu3LX5m20i18DZyHnQKJ+F2pKsV46O8CDLbOu36rWvw3DqjL72d4dl565Vwwch3i4YMznGu8eYhXC6Bt97dyIxbuNhvs+54zFGUeetltqWXtyAc2o/nkLgli7d4135tx8G8RRlt0ay2HtpRNZjMlsTbYJzTWkDgu4Wr+Wjy7u4mbzlmyYVHOj9vg0dHxt4VE3X7KzL2dQ/arsnPz9tg1Ifv44XJqwstt9PgIsXbNpNZvbz1O2Q8zAFct4auQ70wWY3qaXjrx3YG0Oh+wHf7qmlUcH7e+m7fAOy2ZpS3n7PX/3yE496jnpZ0Abz1H6b+r3cPic9bQiDXd1v8VilcMnmLM0u1FVF9vKWPapJVad8t+ZejbreIty2a1YQaTGbL4S2gY9n7IRoZbPhuRfu4KJZL4G3X73iBu/avLsjJBdCVuT1IolwAb4Om7HqXiWQhBH84/Ns3W2ipK3okI9yxn8vbFiezmse34EBNoatkAPq/3v73y+uiVsG9VnomHCshb7nZTeNtVecYKJiFGo+eV2AIwWrwFuJnrKkdo79r9ey8rbDrueP4bKurb/biAnjrFc7Gf34ZaZwS8nnLz66XUT+7jD5qfNbLs7vk31v0vk2YLXBcqMLb2LeFHvr9fg+Vvrr2Ek/EH2YQdpNPe71znsld9nIft3/IzdsnVHLqP+y2HWBuTOcQVvbHcIHAmXwA3lN8vX8S37/4Q0Fz8lbnN+bg7QLGb97cTLf/5pW+aFpK+zfmJHmrqE2ONiL6gx2d07sSvHfB4fDnnyk77YL+Y7uOPqeGPidL7yIq5qwMbwt94y+7ozB163E1ci3Fd6uw34Xomfnz7HfBuv0Zzkuluy1nv4sU3qpk1sj6xhy6zYe3vCXlNkdmm7zM2rK8zZtZT1/6rFtyt6Yj5falhMxm8rbAt3Qnd3mH5FjouinTrYb9LnLwVtP+ydQDvXLsA3y/dbrb6/+GOn9yagGXs2lqn1zWN9RR3jab7QxtxpVmVKwJ3kbsTrrDIWRzHXP7g2azKdS7iD5I68l4i+36m3y4o/12CQW7XWjhbTKzJ+Utsdt3jaCM3eNmztv84RvwlhqBC2bY526WbIJL4S3RpnJmmzSbqZrgbei3sl+7McPsxsKEt80mzWhC7yIqn9nmSXkbNTyElcV8c390p3jGZsJsbvkNeBsW+L7+WHyRhXmwXKFLyo/YL38L3oZu8Xg+aL5w0Nrw3ermrS3ibZ6sRpXH28Aec+XIzl8g3spmVlFleGsympu3Ards+S68VXD7HXhL3Hq5FX4TRfm8bTRIZok2OdpQ0DpSIW+DafS9+FtVAt42YnoX0YdcamRkVjNvvYfO/fvNN6LHw0vjLTZzIt4ip6D7Gr1wnLx2AcfxdfA2mt3kfDI8zFzOsyPuLLFLWom8bejJqqc0Y1jjvEXV+ireJWL8Gq9gwlv0Oc1moHcRfcinrYdmybwlt21WDnNX6BVX8Bx/LxQ1ncXbXHuw2qXzFsD+aLKTfcy69e7t7giulbdgr77HyXgPSuYtziqjDQVlM+bzdnC8Vy/HgcfbRGZzZpVR/Acti7c5l7m189Y+A2+ly+l4qyu7WtyWw9scWU3LrKdp49tstz/EmW0UUR28ZTObNb7NdKuTt/bJeFvE7cl5K8pu0fGtlNvyeNugWZTUeoNmNEVTxrcSbglvi2WUp0ZGZsuYT850q4u39o23vxdvG806zWS61pDWJbUob0nW6pr12/I2kdkbb785b+v1erNRq6FsCrWOtKaoRXmLsla/a9Si2iyuRkZmr5K3/MzeeJuR2SvnbU1fVqNakLdeVms0sxr12/HWvvG2CG9F2b0u3hbNalQbxXgrn8W6ihoZmb0q3to33v7evK3VaebyaI2vhXlbo1nTqlHeZmVWibddCOiSrLLCQ7HMnp63jkWewTOe+PqSodfFWxltR5SX0XJ4K8qebr2LqP5MyqhBs6abt5hMSDuS2o5oK1S57Nrn5i1VS6QsT7P0snmrkl2ZzGrm7bfPbKm8VchsNLstiexmZfYMvM3IrEp2L5O37LMF5+BtSnbNcnl7GVm9It6mZ1eQ2RtvfyvemuXw9vKympe3KpnVyNtEdrMyK+bt/wHsQ1AxQcWpiQAAAABJRU5ErkJggg=="),
                title:const Text("asd"),
                subtitle:const Text("asd"),
              );
            },
          ),
        )
      ],
    );
  }
}
