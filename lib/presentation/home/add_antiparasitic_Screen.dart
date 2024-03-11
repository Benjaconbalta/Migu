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
   int _selectedIndex = typeAntiparasites=="Interna"?0:1; // Índice de la opción predeterminada
  List<String> options = ["Interna", "Externa"];

  
    return Scaffold(
      appBar: AppBar(
        title: editrueorfalse
            ?const Text("Editar Antiparasitario")
            :const Text("Agregar Antiparasitario  "),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
        const    Align(
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
          _selectedIndex = index; // Cambia el índice de la opción seleccionada
          ref.read(typeAntiparasitesProvider.notifier).update((state) =>
              index == 0 ? "Interna" : "Externa"); // Actualiza el estado según la selección
        });
      },
      children: [
            SquareButton2(
          icon: FontAwesomeIcons.dog,
          text: 'Interna',
          onPressed: () {
            setState(() {
              _selectedIndex = 0; // Cambia el índice de la opción seleccionada
              ref
                  .read(typeAntiparasitesProvider.notifier)
                  .update((state) => "Interna");
            });
          },
          selected: _selectedIndex == 0, // Verifica si esta opción está seleccionada
        ),
        SquareButton2(
          icon: FontAwesomeIcons.cat,
          text: 'Externa',
          onPressed: () {
            setState(() {
              _selectedIndex = 1; // Cambia el índice de la opción seleccionada
              ref
                  .read(typeAntiparasitesProvider.notifier)
                  .update((state) => "externa");
            });
          },
          selected: _selectedIndex == 1, // Verifica si esta opción está seleccionada
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
                      "Seleccionar"
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
                    options:const [
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
                        "Seleccionar"
                      ]),
           const SizedBox(
              height: 30,
            ),
          const  Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Fecha de desparasitación*",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                )),
            DatePicker(
              deaydefault: nn.date.day,
              monthdefault: nn.date.month,
              yeardefault: nn.date.year,
              onDateChanged: (year, month, day) {
                final date = DateTime(year, month, day);

                ref
                    .read(dataAntiparasitesProvider.notifier)
                    .update((state) => date);
              },
            ),
           const SizedBox(
              height: 20,
            ),
           const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Proxima dosis",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                )),
            DatePicker(
              deaydefault: nn.nextdose.day,
              monthdefault: nn.nextdose.month,
              yeardefault: nn.nextdose.year,
              onDateChanged: (year, month, day) {
                final date = DateTime(year, month, day);
                ref
                    .read(nextAntiparasitesProvider.notifier)
                    .update((state) => date);
              },
            ),
         const   Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Bordes cuadrados
                  ),
                  backgroundColor: const Color(0xFF3D9A51),
                  padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 20)),
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
                          "date": date == DateTime.now() ? nn.date : date,
                          "nextdose": nextAntiparasites == DateTime.now()
                              ? nn.nextdose
                              : nextAntiparasites,
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
                    ref
                        .read(vaccineandAntiparasitesRepositoryProvider)
                        .addAntiparasites(typeAntiparasites.isEmpty?"Seleccionar":typeAntiparasites, marcaAntiparasites.isEmpty?"Seleccionar":marcaAntiparasites,
                            date, nextAntiparasites)
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
                },

                // context.go("/home/0");
                // Aquí puedes manejar la acción de continuar
              
              child: editrueorfalse? const Text("Editar", style:  TextStyle(
                  color: Colors.white,
                ),): const Text(
                "Agregar",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          const  SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
