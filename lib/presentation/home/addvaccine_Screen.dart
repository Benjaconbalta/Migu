import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:migu/presentation/home/into_vaccine.dart';
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

// Método para verificar si la fecha es válida
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
String imagerUrl = "";

final imagerProvider = StateProvider<String>((ref) {
  return "";
});
final imager2Provider = StateProvider<String>((ref) {
  return "";
});
final isurlrFinishProvider = StateProvider<bool>((ref) {
  return false;
});
final isurlrFinish2Provider = StateProvider<bool>((ref) {
  return false;
});

final urlrProvider = StateProvider<String>((ref) {
  return "";
});
final urlr2Provider = StateProvider<String>((ref) {
  return "";
});

final typeProvider = StateProvider<String>((ref) {
  return "";
});
final marcaProvider = StateProvider<String>((ref) {
  return "";
});
final datevaccineProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});
final nextDosis = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

class AddVaccineScreen extends ConsumerWidget {
  const AddVaccineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<String?> takePhoto1() async {
      final XFile? photo = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 80);
      if (photo == null) return null;

      ref.read(imagerProvider.notifier).update((state) => photo.path);
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child("photosPet");
      Reference referenceImageToUplad = referenceDirImages.child(photo.name);
      try {
        await referenceImageToUplad.putFile(File(photo.path));
        imagerUrl = await referenceImageToUplad.getDownloadURL();
        print("imageurl${imagerUrl}");
        ref.read(urlrProvider.notifier).update((state) => imagerUrl);
        ref.read(isurlrFinishProvider.notifier).update((state) => true);
      } catch (e) {
        return null;
      }
    }

    Future<String?> takePhoto2() async {
      final XFile? photo = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 80);
      if (photo == null) return null;
      print(photo.path);
      ref.read(imager2Provider.notifier).update((state) => photo.path);
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child("photosPet");
      Reference referenceImageToUplad = referenceDirImages.child(photo.name);
      try {
        await referenceImageToUplad.putFile(File(photo.path));
        imagerUrl = await referenceImageToUplad.getDownloadURL();
        print("imageurl${imagerUrl}");
        ref.read(urlr2Provider.notifier).update((state) => imagerUrl);
        ref.read(isurlrFinish2Provider.notifier).update((state) => true);
      } catch (e) {
        return null;
      }
    }

    final nn = ref.watch(sightinProvider);
    final editrueorfalse = ref.watch(editvaccineProvider);
    final image1Temp = ref.watch(imagerProvider);
    final image2Temp = ref.watch(imager2Provider);
    final image1firebase = ref.watch(urlrProvider);
    final imagen2firebase = ref.watch(urlr2Provider);
    final tipo = ref.watch(typeProvider);
    final marca = ref.watch(marcaProvider);
    final datevacine = ref.watch(datevaccineProvider);
    final nestdosis = ref.watch(nextDosis);
    // final trueorfalse = ref.watch(isurlrFinishProvider);
    // final trueor2false = ref.watch(isurlrFinish2Provider);
    final infoedit = ref.watch(infoeditvaccineProvider);
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
              ? const Text(("Editar Vacuna"))
              : const Text("Agregar Vacuna"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                editrueorfalse
                    ? MyDropdown(
                        defaultValue: infoedit.type,
                        label: "Tipo",
                        onChanged: (tipo) {
                          ref
                              .read(typeProvider.notifier)
                              .update((state) => tipo!);
                        },
                        options: const [
                          'Antirrábica ',
                          'Sextuple',
                          'Octuple',
                          'Trivalente',
                          "Cuádruple",
                          "KC",
                          "Intra-Trac",
                          "Moquillo",
                          "Puppy  DP",
                          "Leucémia",
                          "Giardia",
                          "Otra"
                        ],
                      )
                    : MyDropdown1(
                        onChanged: (ti) {
                          ref
                              .read(typeProvider.notifier)
                              .update((state) => ti!);
                        },
                        label: "Tipo",
                        options: const [
                          'Antirrábica ',
                          'Sextuple',
                          'Octuple',
                          'Trivalente',
                          "Cuádruple",
                          "KC",
                          "Intra-Trac",
                          "Moquillo",
                          "Puppy  DP",
                          "Leucémia",
                          "Giardia",
                          "Otra"
                        ],
                      ),
                editrueorfalse
                    ? MyDropdown(
                        defaultValue: infoedit.brand,
                        label: "marca",
                        options: const [
                          'Rabguard',
                          'Nobivac',
                          'Verorab',
                          "Canigen",
                          "Recomtitek",
                          "Feligen",
                          "Felocell",
                          "Hexadog",
                          "Maxivac",
                          "Recombitek",
                          "Vencomax",
                          "Purevax",
                          "GiardiaVax"
                              'Otra',
                        ],
                        onChanged: (p0) {
                          ref
                              .read(marcaProvider.notifier)
                              .update((state) => p0!);
                        },
                      )
                    : MyDropdown2(
                        onChanged: (p0) {
                          ref
                              .read(marcaProvider.notifier)
                              .update((state) => p0!);
                        },
                        label: "Marca",
                        options: const [
                          'Rabguard',
                          'Nobivac',
                          'Verorab',
                          "Canigen",
                          "Recomtitek",
                          "Feligen",
                          "Felocell",
                          "Hexadog",
                          "Maxivac",
                          "Recombitek",
                          "Vencomax",
                          "Purevax",
                          "GiardiaVax"
                              'Otra',
                        ],
                      ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Fecha de vacunación",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    )),
                editrueorfalse
                    ? DateSelectionWidget(
                        deaydefault: infoedit.date.day.toString(),
                        monthdefault: obtenerMesEnPalabras(infoedit.date.month),
                        yeardefault: infoedit.date.year.toString(),
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
      ref.read(datevaccineProvider.notifier).update((state) => date);
    } else {
      // Manejar el caso de fecha inválida aquí
      print("Fecha inválida");
    }
  },
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
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
      ref.read(datevaccineProvider.notifier).update((state) => date);
    } else {
      // Manejar el caso de fecha inválida aquí
      print("Fecha inválida");
    }
  },
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Text(
                          "Proxima dosis ",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),

                        // DateSelectionWidget(),
                        GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: const Wrap(
                                      children: [
                                        Text(
                                            'Siempre consulta con un veterinario antes de vacunar'),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cerrar'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Icon(Icons.help))
                      ],
                    )),
              
                SizedBox(
                  height: 10,
                ),
                       editrueorfalse?
                DateSelectionWidget(
                     deaydefault: infoedit.nextdose.day.toString(),
                         monthdefault: obtenerMesEnPalabras(infoedit.nextdose.month),
                         yeardefault: infoedit.nextdose.year.toString(),
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
      ref.read(nextDosis.notifier).update((state) => date);
    } else {
      // Manejar el caso de fecha inválida aquí
      print("Fecha inválida");
    }
  },
     
                ):     DateSelectionWidget(
                   
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
      ref.read(nextDosis.notifier).update((state) => date);
    } else {
      // Manejar el caso de fecha inválida aquí
      print("Fecha inválida");
    }
  },
     
                ) ,
                SizedBox(
                  height: 30,
                ),
                Container(
                  // Bordes redondeados

                  height: 60,
                  width: 300,
                  padding: const EdgeInsets.all(10.0),
                  color: Colors.grey[200], // Fondo gris claro
                  child: Row(
                    children: [
                      const Text("Etiqueta Vacuna"),
                      GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Etiqueta Vacuna  "),
                                  content: const Wrap(
                                    children: [
                                      Text(
                                          'Cada vacuna viene con una etiqueta que sirve para certificar el número de Lote.'),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cerrar'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Icon(Icons.help)),
                      const SizedBox(
                        width: 50,
                      ),
                      Container(
                        width: 60,
                        height: 40,
                        child: editrueorfalse
                            ? Image.network(nn.photovaccinelabel)
                            : image1Temp == ""
                                ? TextButton(
                                    child: const Text("Foto"),
                                    onPressed: () {
                                      takePhoto1();
                                    },
                                  )
                                : image1firebase == ""
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : Image.file(File(image1Temp)),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  width: 300,
                  padding: const EdgeInsets.all(10.0),
                  color: Colors.grey[200], // Fondo gris claro
                  child: Row(
                    children: [
                      const Text("Certificado"),
                      GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Certificado  "),
                                  content: const Wrap(
                                    children: [
                                      Text(
                                          'La vacuna antirábica debe venir acompañada de un certificado veterinario'),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cerrar'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Icon(Icons.help)),
                      const SizedBox(
                        width: 50,
                      ),
                      Container(
                        width: 60,
                        height: 40,
                        child: editrueorfalse
                            ? Image.network(nn.photocertificate)
                            : image2Temp == ""
                                ? TextButton(
                                    child: const Text("Foto"),
                                    onPressed: () {
                                      takePhoto2();
                                    },
                                  )
                                : imagen2firebase == ""
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : Image.file(File(image2Temp)),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Bordes cuadrados
                        ),
                        backgroundColor: const Color(0xFF3D9A51),
                        padding: const EdgeInsets.symmetric(horizontal: 90)),
                    onPressed: () {
                      // if (trueorfalse == false || trueor2false == false) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //       SnackBar(content: Text('espere un Momento')));
                      // }

                      if (editrueorfalse) {
                        if (nn.type.isEmpty ||
                            nn.brand.isEmpty ||
                            nn.photovaccinelabel.isEmpty ||
                            nn.photocertificate.isEmpty) {
                          final snackBar = SnackBar(
                            content: const Text(
                                '¡porfavor rellenar todos los campos'),
                            action: SnackBarAction(
                              label: 'Cerrar',
                              onPressed: () {
                                // Aquí puedes agregar cualquier acción que desees realizar
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              },
                            ),
                          );

                          // Mostrar el Snackbar en el contexto actual
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
//                           String _dosDigitos(int numero) {
//   return numero.toString().padLeft(2, '0');
// }
// final dateSeleccionada = ref.watch(datevaccineProvider); // Obtener la fecha seleccionada por el usuario
// final dateFormateada = '${dateSeleccionada.year}-${_dosDigitos(dateSeleccionada.month)}-${_dosDigitos(dateSeleccionada.day)}'; // Formatear la fecha

                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection("vaccine")
                              .doc(nn.id)
                              .update(({
                                "type": tipo == "" ? nn.type : tipo,
                                "brand": marca == "" ? nn.brand : marca,
                                "vaccination": "",
                                "date": datevacine,
                                "nextdose": nestdosis,
                                "photovaccinelabel": image1firebase == ""
                                    ? nn.photovaccinelabel
                                    : image1firebase,
                                "photocertificate": imagen2firebase == ""
                                    ? nn.photocertificate
                                    : imagen2firebase,
                              }))
                              .then((value) => {
                                    ref
                                        .read(editvaccineProvider.notifier)
                                        .update((state) => false)
                                  })
                              .then((value) => {
                                    ref
                                        .read(pressVaccineIntoProvider.notifier)
                                        .update((state) => false)
                                  })
                              .then((value) => {context.go("/home/0")});
                        }
                      } else {
                        //TODO:     //aca poner algo como si el image1firebase imagen se esta cargando
                        if (tipo.isEmpty ||
                            marca.isEmpty ||
                            image1firebase.isEmpty ||
                            imagen2firebase.isEmpty) {
                          final snackBar = SnackBar(
                            content: const Text(
                                '¡porfavor rellenar todos los campos'),
                            action: SnackBarAction(
                              label: 'Cerrar',
                              onPressed: () {
                                // Aquí puedes agregar cualquier acción que desees realizar
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              },
                            ),
                          );

                          // Mostrar el Snackbar en el contexto actual
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          ref
                              .read(vaccineandAntiparasitesProvider.notifier)
                              .addVaccine(tipo, marca, "", datevacine,
                                  nestdosis, image1firebase, imagen2firebase)
                              .then((value) => ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('¡Vacuna Agregada!'),
                                  )))
                              .then((value) => {context.pop()})
                              .then((value) => {
                                    ref
                                        .read(imagerProvider.notifier)
                                        .update((state) => ""),
                                    ref
                                        .read(imager2Provider.notifier)
                                        .update((state) => "")
                                  });
                        }
                      }

                      // context.go("/home/0");
                      // Aquí puedes manejar la acción de continuar
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: editrueorfalse
                          ? const Text(
                              "Guardar",
                              style: TextStyle(color: Colors.white),
                            )
                          : const Text(
                              "Continuar",
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class MultiSelectDropdown extends StatefulWidget {
  final String nameInput;
  const MultiSelectDropdown({super.key, required this.nameInput});

  @override
  _MultiSelectDropdownState createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  final List<String> _selectedOptions = [];
  String? _selectedOption;
  final List<String> _options = [
    'Antirrabica ',
    'sextumple',
    'Octuple',
    'Trivalente',
    "cuadruple",
    "KC",
    "intra-trak",
    "moquillo",
    "pupy dp",
    "leucemia",
    "giardia",
    "otra"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${widget.nameInput}*',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        const SizedBox(
          height: 7,
        ),
        DropdownButtonFormField(
          isExpanded: true,
          value: _selectedOption,
          hint: const Text(
            'Seleccionar',
            style: TextStyle(fontSize: 18),
          ),
          onChanged: (String? newValue) {
            // 2. Manejar la posibilidad de que newValue sea nulo
            setState(() {
              _selectedOption = newValue ??
                  _selectedOption; // Utilizar operador ?? para manejar nulos
            });
            print('Selected option: $_selectedOption');
          },
          items: _options.map((option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option,
                  style: const TextStyle(
                    fontSize: 15,
                  )),
            );
          }).toList(),
          validator: (value) {
            if (value == null) {
              return 'Por favor selecciona una opción';
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          selectedItemBuilder: (BuildContext context) {
            return _selectedOptions.map<Widget>((String option) {
              return Text(
                option,
                style: const TextStyle(fontSize: 10, color: Colors.red),
              );
            }).toList();
          },
          isDense: true,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 36,
        ),
      ],
    );
  }
}

class MyDropdown2 extends StatefulWidget {
  final String label;
  final List<String> options;

  final void Function(String?)? onChanged;

  const MyDropdown2({
    Key? key,
    required this.label,
    required this.options,
    this.onChanged,
  }) : super(key: key);

  @override
  _MyDropdown2State createState() => _MyDropdown2State();
}

class _MyDropdown2State extends State<MyDropdown2> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${widget.label}*',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 7),
            DropdownButtonFormField(
              isExpanded: true,
              hint: const Text(
                'Seleccionar',
                style: TextStyle(fontSize: 18),
              ),
              value: _selectedOption,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOption = newValue;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(_selectedOption);
                }
                print('Selected option: $_selectedOption');
              },
              items: [
                ...widget.options.map((option) {
                  return DropdownMenuItem(
                    value: option,
                    child: Text(
                      option,
                      style: const TextStyle(fontSize: 15),
                    ),
                  );
                }),
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDropdown1 extends StatefulWidget {
  final String label;
  final List<String> options;
  final void Function(String?)? onChanged;

  const MyDropdown1({
    Key? key,
    required this.label,
    required this.options,
    this.onChanged,
  }) : super(key: key);

  @override
  _MyDropdown1State createState() => _MyDropdown1State();
}

class _MyDropdown1State extends State<MyDropdown1> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${widget.label}*',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 7),
            DropdownButtonFormField(
              hint: Text(
                'Seleccionar',
                style: TextStyle(fontSize: 18),
              ),
              isExpanded: true,
              value: _selectedOption,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOption = newValue;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(_selectedOption);
                }
                print('Selected option: $_selectedOption');
              },
              items: [
                ...widget.options.map((option) {
                  return DropdownMenuItem(
                    value: option,
                    child: Text(
                      option,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }),
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.red),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDropdown extends StatefulWidget {
  final String label;
  final List<String> options;
  final String? defaultValue; // Valor por defecto
  final void Function(String?)? onChanged;

  const MyDropdown({
    Key? key,
    required this.label,
    required this.options,
    this.defaultValue, // Valor por defecto
    this.onChanged,
  }) : super(key: key);

  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    // Establece el valor inicial al valor por defecto
    _selectedOption = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${widget.label}*',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 7),
            DropdownButtonFormField(
              isExpanded: true,
              hint: Text(
                'Seleccionar',
                style: TextStyle(fontSize: 18),
              ),
              value: _selectedOption,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOption = newValue;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(_selectedOption);
                }
                print('Selected option: $_selectedOption');
              },
              items: widget.options.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(
                    option,
                    style: TextStyle(fontSize: 15),
                  ),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.red),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateSelectionWidget extends StatefulWidget {
  final void Function(String day, String month, String year)? onChanged;
  final String deaydefault;
  final String monthdefault;
  final String yeardefault;
  DateSelectionWidget(
      {Key? key,
      this.onChanged,
      this.deaydefault = "",
      this.monthdefault = "",
      this.yeardefault = ""})
      : super(key: key);

  @override
  _DateSelectionWidgetState createState() => _DateSelectionWidgetState();
}

class _DateSelectionWidgetState extends State<DateSelectionWidget> {
  late String selectedDay;
  late String selectedMonth;
  late String selectedYear;

  @override
  void initState() {
    super.initState();
    selectedDay = widget.deaydefault.toString().isEmpty
        ? 'Dia'
        : widget.deaydefault.toString();
    selectedMonth = widget.monthdefault.toString().isEmpty
        ? 'Mes'
        : widget.monthdefault.toString();
    selectedYear = widget.yeardefault.toString().isEmpty
        ? DateTime.now().year.toString()
        : widget.yeardefault.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 9, vertical: 7),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400, width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            width: 100, // Puedes ajustar este valor según tus necesidades

            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(borderSide: BorderSide.none)),
              value: selectedDay.isNotEmpty ? selectedDay : null,
              onChanged: (String? value) {
                setState(() {
                  selectedDay = value!;
                  _notifyParent();
                });
              },
              items: [
                DropdownMenuItem<String>(
                  value: 'Dia',
                  child: Text(
                    'Día',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ...List.generate(31, (index) {
                  return DropdownMenuItem<String>(
                    value: (index + 1).toString(),
                    child: Text((index + 1).toString(),
                        style: TextStyle(fontSize: 18)),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
        SizedBox(width: 10),
        Flexible(
          fit: FlexFit.loose,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 9, vertical: 7),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400, width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            width: 100, // Puedes ajustar este valor según tus necesidades

            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(borderSide: BorderSide.none)),
              value: selectedMonth,
              onChanged: (String? value) {
                setState(() {
                  selectedMonth = value!;
                  _notifyParent();
                });
              },
              items: [
                DropdownMenuItem<String>(
                  value: 'Mes',
                  child: Text(
                    'Mes',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                ...[
                  
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
                  'Dic',
                ].map((String month) {
                  return DropdownMenuItem<String>(
                    value: month,
                    child: Text(month, style: TextStyle(fontSize: 18)),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          fit: FlexFit.loose,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 9, vertical: 7),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400, width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            width: 100, // Puedes ajustar este valor según tus necesidades

            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(borderSide: BorderSide.none)),
              value: selectedYear,
              onChanged: (String? value) {
                setState(() {
                  selectedYear = value!;
                  _notifyParent();
                });
              },
              items: List.generate(50, (index) {
                int year = DateTime.now().year + index;
                return DropdownMenuItem<String>(
                  value: year.toString(),
                  child: Text(year.toString(),
                      style: const TextStyle(fontSize: 18)),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  void _notifyParent() {
    if (widget.onChanged != null) {
      widget.onChanged!(selectedDay, selectedMonth, selectedYear);
    }
  }
}

// class DatePicker extends ConsumerStatefulWidget {
//   final void Function(int year, int month, int day)? onDateChanged;
//   final int deaydefault;
//   final int monthdefault;
//   final int yeardefault;

//   const DatePicker(
//       {Key? key,
//       this.onDateChanged,
//       this.deaydefault = 0,
//       this.monthdefault = 0,
//       this.yeardefault = 0})
//       : super(key: key);

//   @override
//   _DatePickerState createState() => _DatePickerState();
// }

// class _DatePickerState extends ConsumerState<DatePicker> {
//   late int _selectedYear;
//   late int _selectedMonth;
//   late int _selectedDay;
// //aca pasar

//   @override
//   void initState() {
//     super.initState();
//     _selectedYear = widget.yeardefault;
//     _selectedMonth = widget.monthdefault;
//     _selectedDay = widget.deaydefault;
//     // _selectedDay = now.day
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         _buildDatePicker("", _buildDayDropdown()),
//         SizedBox(width: 10),
//         _buildDatePicker("", _buildMonthDropdown()),
//         SizedBox(width: 10),
//         _buildDatePicker("", _buildYearDropdown()),
//       ],
//     );
//   }

//   Widget _buildDatePicker(String labelText, Widget dropdown) {
//     return Column(
//       children: [
//         Text(
//           labelText,
//           style: TextStyle(fontSize: 18, color: Colors.black),
//         ),
//         dropdown,
//       ],
//     );
//   }

//   Widget _buildYearDropdown() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 9, vertical: 7),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade400, width: 1.0),
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: DropdownButton<int>(
//         value: _selectedYear,
//         items: _buildYearItems(),
//         onChanged: (value) {
//           setState(() {
//             _selectedYear = value!;
//             widget.onDateChanged
//                 ?.call(_selectedYear, _selectedMonth, _selectedDay);
//           });
//         },
//         icon: null,
//         hint: Text('Año'),
//       ),
//     );
//   }

//   Widget _buildMonthDropdown() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 9, vertical: 7),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade400, width: 1.0),
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: DropdownButton<int>(
//         value: _selectedMonth,
//         items: _buildMonthItems(),
//         onChanged: (value) {
//           setState(() {
//             _selectedMonth = value!;
//             widget.onDateChanged
//                 ?.call(_selectedYear, _selectedMonth, _selectedDay);
//           });
//         },
//         icon: null,
//         hint: Text('Mes'),
//       ),
//     );
//   }

//   Widget _buildDayDropdown() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 9, vertical: 7),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade400, width: 1.0),
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: DropdownButton<int>(
//         value: _selectedDay,
//         items: _buildDayItems(),
//         onChanged: (value) {
//           setState(() {
//             _selectedDay = value!;
//             widget.onDateChanged
//                 ?.call(_selectedYear, _selectedMonth, _selectedDay);
//           });
//         },
//         icon: null,
//         hint: Text('Día'),
//       ),
//     );
//   }

//   List<DropdownMenuItem<int>> _buildYearItems() {
//     List<DropdownMenuItem<int>> items = [];
//     int currentYear = DateTime.now().year;
//     for (int year = currentYear; year <= currentYear + 100; year++) {
//       items.add(DropdownMenuItem<int>(
//         value: year,
//         child: Text(
//           year.toString(),
//           style: TextStyle(fontSize: 20),
//         ),
//       ));
//     }
//     return items;
//   }

//   List<DropdownMenuItem<int>> _buildMonthItems() {
//     List<DropdownMenuItem<int>> items = [];
//     for (int month = 1; month <= 12; month++) {
//       items.add(DropdownMenuItem<int>(
//         value: month,
//         child: Text(
//           month.toString(),
//           style: TextStyle(fontSize: 20),
//         ),
//       ));
//     }
//     return items;
//   }

//   List<DropdownMenuItem<int>> _buildDayItems() {
//     List<DropdownMenuItem<int>> items = [];
//     int daysInMonth = DateTime(_selectedYear, _selectedMonth + 1, 0).day;
//     for (int day = 1; day <= daysInMonth; day++) {
//       items.add(DropdownMenuItem<int>(
//         value: day,
//         child: Text(
//           day.toString(),
//           style: TextStyle(fontSize: 20),
//         ),
//       ));
//     }
//     return items;
//   }
// }
