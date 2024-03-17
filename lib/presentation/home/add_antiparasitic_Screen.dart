import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:migu/domain/entities/antiparasites.dart';
import 'package:migu/presentation/auth/Addpet_Screen.dart';
import 'package:migu/presentation/home/addvaccine_Screen.dart';
import 'package:migu/presentation/home/into_antiparasitic.dart';
import 'package:migu/presentation/providers/Vaccineandantiparasites/Vaccineandantiparasites_repository_provider.dart';
import 'package:migu/presentation/providers/Vaccineandantiparasites/vaccineandAntiparasites_provider.dart';
import 'package:migu/presentation/views/home_view.dart';
int _getMonthNumber(String month) {
  switch (month) {
    case 'Ene':
      return 1;
    case 'Feb':
      return 2;
    case 'Mar':
      return 3;
    case 'Abr':
      return 4;
    case 'May':
      return 5;
    case 'Jun':
      return 6;
    case 'Jul':
      return 7;
    case 'Ago':
      return 8;
    case 'Sep':
      return 9;
    case 'Oct':
      return 10;
    case 'Nov':
      return 11;
    case 'Dic':
      return 12;
    default:
      return 1;
  }
}
bool _isValidDate(int day, int month, int year) {
  if (month < 1 || month > 12) {
    return false;
  }
  if (day < 1 || day > _daysInMonth(month, year)) {
    return false;
  }
  return true;
}

// Método para obtener el número de días en un mes
int _daysInMonth(int month, int year) {
  return DateTime(year, month + 1, 0).day;
}

final typeAntiparasitesProvider = StateProvider<String>((ref) {
  return "";
});
final marcaAntiparasitesProvider = StateProvider<String>((ref) {
  return "";
});

final dataAntiparasitesProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});
final nextAntiparasitesProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

class Addantiparasitic extends ConsumerStatefulWidget {
  const Addantiparasitic({super.key});

  @override
  _AddantiparasiticState createState() => _AddantiparasiticState();
}

class _AddantiparasiticState extends ConsumerState<Addantiparasitic> {
  late List<bool> _selections;
  @override
  void initState() {
    super.initState();
    _selections = List.generate(2, (index) => false); // Inicializar selecciones
  }

  @override
  Widget build(BuildContext context) {
    final antiparasites = ref.watch(antiparasitesFirebaseProvider);
    final typeAntiparasites = ref.watch(typeAntiparasitesProvider);
    final marcaAntiparasites = ref.watch(marcaAntiparasitesProvider);
    final nextAntiparasites = ref.watch(nextAntiparasitesProvider);
    final date = ref.watch(dataAntiparasitesProvider);
    final editrueorfalse = ref.watch(editantiparasitesProvider);
    final nn = ref.watch(antiparasitesProvider);
    final infoedit = ref.watch(infoeditantiparasitesProvider);
    int _selectedIndex = typeAntiparasites == "Interna"
        ? 0
        : 1; // Índice de la opción predeterminada
    List<String> options = ["Interna", "Externa"];
  String obtenerMesEnPalabras(int numeroMes) {
      switch (numeroMes) {
        case 1:
          return 'Ene';
        case 2:
          return 'Feb';
        case 3:
          return 'Mar';
        case 4:
          return 'Abr';
        case 5:
          return 'May';
        case 6:
          return 'Jun';
        case 7:
          return 'Jul';
        case 8:
          return 'Ago';
        case 9:
          return 'Sep';
        case 10:
          return 'Oct';
        case 11:
          return 'Nov';
        case 12:
          return 'Dic';
        default:
          return ''; // En caso de que el número de mes no esté en el rango válido
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: editrueorfalse
            ? const Text("Editar Antiparasitario")
            : const Text("Agregar Antiparasitario  "),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tipo",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                )),
            ToggleButtons(
              borderWidth: 0,
              borderColor: Colors.white,
              borderRadius: BorderRadius.circular(20),
              selectedColor: Colors.green, // Color de la opción seleccionada

              isSelected: [
                _selectedIndex == 0, // Opción interna
                _selectedIndex == 1, // Opción externa (predeterminada)
              ],
              onPressed: (int index) {
                setState(() {
                  _selectedIndex =
                      index; // Cambia el índice de la opción seleccionada
                  ref.read(typeAntiparasitesProvider.notifier).update((state) =>
                      index == 0
                          ? "Interna"
                          : "Externa"); // Actualiza el estado según la selección
                });
              },
              children: [
                SquareButton2(
                  icon: FontAwesomeIcons.dog,
                  text: 'Interna',
                  onPressed: () {
                    setState(() {
                      _selectedIndex =
                          0; // Cambia el índice de la opción seleccionada
                      ref
                          .read(typeAntiparasitesProvider.notifier)
                          .update((state) => "Interna");
                    });
                  },
                  selected: _selectedIndex ==
                      0, // Verifica si esta opción está seleccionada
                ),
                SquareButton2(
                  icon: FontAwesomeIcons.cat,
                  text: 'Externa',
                  onPressed: () {
                    setState(() {
                      _selectedIndex =
                          1; // Cambia el índice de la opción seleccionada
                      ref
                          .read(typeAntiparasitesProvider.notifier)
                          .update((state) => "externa");
                    });
                  },
                  selected: _selectedIndex ==
                      1, // Verifica si esta opción está seleccionada
                ),
              ],
            ),
            editrueorfalse
                ? MyDropdown(
                    defaultValue: infoedit.brand,
                    label: "Marca*",
                    options: const [
                      "Bravecto",
                      "NEXGARD",
                      "ADVOCATE",
                      "CEVA",
                      "FRONTLINE SPRAY",
                      "Ehlinger",
                      "Zoetis",
                      "NEXGARD SPECTRA",
                      "Skouts Honor",
                      "TICKELESS",
                      "cleanvet",
                      "frontline plus",
                      "Bayer/Elanco",
                      "drag pharma",
                      "veterquimica",
                      "virbac",
                      "Otro",
                      
                    ],
                    onChanged: (marc) {
                      ref
                          .read(marcaAntiparasitesProvider.notifier)
                          .update((state) => marc!);
                    },
                  )
                : MyDropdown1(
                    onChanged: (marc) {
                      ref
                          .read(marcaAntiparasitesProvider.notifier)
                          .update((state) => marc!);
                    },
                    label: "marca",
                    options: const [
                        "Bravecto",
                        "NEXGARD",
                        "ADVOCATE",
                        "CEVA",
                        "FRONTLINE SPRAY",
                        "Ehlinger",
                        "Zoetis",
                        "NEXGARD SPECTRA",
                        "Skouts Honor",
                        "TICKELESS",
                        "cleanvet",
                        "frontline plus",
                        "Bayer/Elanco",
                        "drag pharma",
                        "veterquimica",
                        "virbac",
                        "Otro",
                  
                      ]),
            const SizedBox(
              height: 30,
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Fecha de desparasitación*",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                )),

                editrueorfalse?
             DateSelectionWidget(
                     deaydefault: nn.date.day.toString(),
                         monthdefault: obtenerMesEnPalabras(nn.date.month),
                         yeardefault: nn.date.year.toString(),
                               onChanged: (day, month, year) {
    // Convertir los valores de cadena a enteros
    int dayInt = int.tryParse(day) ?? 1;
    int monthInt = _getMonthNumber(month);
    int yearInt = int.tryParse(year) ?? DateTime.now().year;

    // Verificar si los valores son válidos
    if (_isValidDate(dayInt, monthInt, yearInt)) {
      // Crear un objeto DateTime
      final date = DateTime(yearInt, monthInt, dayInt);
      
      // Actualizar el estado con la fecha seleccionada
      ref.read(dataAntiparasitesProvider.notifier).update((state) => date);
    } else {
      // Manejar el caso de fecha inválida aquí
      print("Fecha inválida");
    }
  },
             ):

               DateSelectionWidget(
                  
                               onChanged: (day, month, year) {
    // Convertir los valores de cadena a enteros
    int dayInt = int.tryParse(day) ?? 1;
    int monthInt = _getMonthNumber(month);
    int yearInt = int.tryParse(year) ?? DateTime.now().year;

    // Verificar si los valores son válidos
    if (_isValidDate(dayInt, monthInt, yearInt)) {
      // Crear un objeto DateTime
      final date = DateTime(yearInt, monthInt, dayInt);
      
      // Actualizar el estado con la fecha seleccionada
      ref.read(dataAntiparasitesProvider.notifier).update((state) => date);
    } else {
      // Manejar el caso de fecha inválida aquí
      print("Fecha inválida");
    }
  },
             )
             
             ,
            const SizedBox(
              height: 20,
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Proxima dosis",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                )),
                editrueorfalse?
              DateSelectionWidget(
                     deaydefault: nn.nextdose.day.toString(),
                         monthdefault: obtenerMesEnPalabras(nn.nextdose.month),
                         yeardefault: nn.nextdose.year.toString(),
                               onChanged: (day, month, year) {
    // Convertir los valores de cadena a enteros
    int dayInt = int.tryParse(day) ?? 1;
    int monthInt = _getMonthNumber(month);  
    int yearInt = int.tryParse(year) ?? DateTime.now().year;

    // Verificar si los valores son válidos
    if (_isValidDate(dayInt, monthInt, yearInt)) {
      // Crear un objeto DateTime
      final date = DateTime(yearInt, monthInt, dayInt);
      
      // Actualizar el estado con la fecha seleccionada
      ref.read(nextAntiparasitesProvider.notifier).update((state) => date);
    } else {
      // Manejar el caso de fecha inválida aquí
      print("Fecha inválida");
    }
  },
             ): DateSelectionWidget(
                  
                               onChanged: (day, month, year) {
    // Convertir los valores de cadena a enteros
    int dayInt = int.tryParse(day) ?? 1;
    int monthInt = _getMonthNumber(month);
    int yearInt = int.tryParse(year) ?? DateTime.now().year;

    // Verificar si los valores son válidos
    if (_isValidDate(dayInt, monthInt, yearInt)) {
      // Crear un objeto DateTime
      final date = DateTime(yearInt, monthInt, dayInt);
      
      // Actualizar el estado con la fecha seleccionada
      ref.read(nextAntiparasitesProvider.notifier).update((state) => date);
    } else {
      // Manejar el caso de fecha inválida aquí
      print("Fecha inválida");
    }
  },
             ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Bordes cuadrados
                  ),
                  backgroundColor: const Color(0xFF3D9A51),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 130, vertical: 20)),
              onPressed: () {
                if (editrueorfalse) {
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("Antiparasites")
                      .doc(nn.id)
                      .update(({
                        "type": typeAntiparasites == ""
                            ? nn.type
                            : typeAntiparasites,
                        "brand": marcaAntiparasites == ""
                            ? nn.brand
                            : marcaAntiparasites,
                        "date":date,
                        "nextdose": nextAntiparasites
                      }))
                      .then((value) => {
                            ref
                                .read(editantiparasitesProvider.notifier)
                                .update((state) => false)
                          })
                      .then((value) => {
                            ref
                                .read(pressAntiparasitesIntoProvider.notifier)
                                .update((state) => false)
                          })
                      .then((value) => {context.go("/home/0")});
                } else {
                  if (typeAntiparasites.isEmpty ||
                      marcaAntiparasites.isEmpty 
                     ) {
                    final snackBar = SnackBar(
                      content:
                          const Text('¡porfavor rellenar todos los campos'),
                      action: SnackBarAction(
                        label: 'Cerrar',
                        onPressed: () {
                          // Aquí puedes agregar cualquier acción que desees realizar
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                    );

                    // Mostrar el Snackbar en el contexto actual
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }else{
   ref
                      .read(vaccineandAntiparasitesRepositoryProvider)
                      .addAntiparasites(
                          typeAntiparasites,
                            
                          marcaAntiparasites,
                          date,
                          nextAntiparasites)
                      .then((value) => {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('¡subido con exito!'),
                              // action: SnackBarAction(
                              //   label: 'Cerrar',
                              //   onPressed: () =>
                              //       ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                              // ),
                            ))
                          })
                      .then((value) => {context.pop()})
                      .then((value) => {});
                }
                  }
               
              },

              // context.go("/home/0");
              // Aquí puedes manejar la acción de continuar

              child: editrueorfalse
                  ? const Text(
                      "Guardar",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      "Agregar",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
