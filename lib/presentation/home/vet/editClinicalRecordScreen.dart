import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:migu/presentation/home/addvaccine_Screen.dart';
import 'package:migu/presentation/home/vet/intopatientScreen.dart';
import 'package:migu/presentation/providers/vets/vets_provider.dart';
import 'package:migu/widgets/shared/custom_text_form_field.dart';

final namepetProvider = StateProvider<String>((ref) {
  return "";
});
final birthdateprovider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});
final nutritionprovider = StateProvider<String>((ref) {
  return "";
});
final behaviorprovider = StateProvider<String>((ref) {
  return "";
});
final treatmenprovider = StateProvider<String>((ref) {
  return "";
});
final observationsprovider = StateProvider<String>((ref) {
  return "";
});
final weightprovider = StateProvider<int>((ref) {
  return 0;
});

class EditClinicalRecordScreen extends ConsumerWidget {
  const EditClinicalRecordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(namepetProvider);
    final birthdate = ref.watch(birthdateprovider);
    final nutrition = ref.watch(nutritionprovider);
    final behavior = ref.watch(behaviorprovider);
    final treatmen = ref.watch(treatmenprovider);
    final observation = ref.watch(observationsprovider);
    final weight = ref.watch(weightprovider);

    final uid = ref.watch(uidUserProvider);
    final clinicalRecordStream = ref.watch(getclinicalRecord(uid));
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: clinicalRecordStream.when(
          data: (data) {
            if (data.isEmpty) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nombre mascota",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                              child: CustomTextFormField(
                                  enable: false,
                                  
                            onChanged: (namepet) {
                              ref
                                  .read(namepetProvider.notifier)
                                  .update((state) => namepet);
                              //state para obtener el nombre
                            },
                            label: "Beatriz",
                            hint: "Nombre",
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      DateSelectionWidget(
                        onChanged: (day, month, year) {
                          // Convertir los valores de cadena a enteros
                          int dayInt = int.tryParse(day) ?? 1;
                          int monthInt = getMonthNumber(month);
                          int yearInt =
                              int.tryParse(year) ?? DateTime.now().year;
                          final date = DateTime(yearInt, monthInt, dayInt);

                          ref
                              .read(birthdateprovider.notifier)
                              .update((state) => date);
                          // Verificar si los valores son válidos
                          // if (_isValidDate(dayInt, monthInt, yearInt)) {
                          //   // Crear un objeto DateTime
                          //   final date =
                          //       DateTime(yearInt, monthInt, dayInt);

                          //   // Actualizar el estado con la fecha seleccionada
                          //   // ref
                          //   //     .read(datevaccineProvider.notifier)
                          //   //     .update((state) => date);
                          // } else {
                          //   // Manejar el caso de fecha inválida aquí
                          //   print("Fecha inválida");
                          // }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nutricion",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                              child: CustomTextInput(
                            hint: "Nutricion",
                            onChanged: (nutritions) {
                              ref
                                  .read(nutritionprovider.notifier)
                                  .update((state) => nutritions);
                            },
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Peso",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                              child: CustomTextInput(
                            numericKeyboard: true,
                            hint: "40kg",
                            onChanged: (p0) {
                              ref
                                  .read(weightprovider.notifier)
                                  .update((state) => int.parse(p0));
                            },
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Conducta",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                              child: CustomTextInput(
                            onChanged: (p0) {
                              ref
                                  .read(behaviorprovider.notifier)
                                  .update((state) => p0);
                            },
                            label: "Beatriz",
                            hint: "Conducta",
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tratamiento",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                              child: CustomTextInput(
                            onChanged: (p0) {
                              ref
                                  .read(treatmenprovider.notifier)
                                  .update((state) => p0);
                            },
                            hint:
                                "Está tomando Apoquel 5,4mg desde hace 1 año y medio",
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Observaciones",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          CustomTextInput(
                            hint: "Sufre de dermatitis atópica",
                            onChanged: (p0) {
                              ref
                                  .read(observationsprovider.notifier)
                                  .update((state) => p0);
                            },
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FilledButton.tonal(
                              style: FilledButton.styleFrom(
                                  backgroundColor: Colors.white),
                              onPressed: () {},
                              child: Text(
                                "Cancelar",
                                style: TextStyle(color: Colors.red),
                              )),
                          SizedBox(
                            width: 30,
                          ),
                          FilledButton.tonal(
                              style: FilledButton.styleFrom(
                                  backgroundColor: Color(0xff3D9A51)),
                              onPressed: () {
                                if (name.isEmpty) {
                                  final snackBar = SnackBar(
                                    content:
                                        Text('debes editar al menos un campo'),
                                    action: SnackBarAction(
                                      label: 'Close',
                                      onPressed: () {
                                        context.pop();
                                        // Código que se ejecutará cuando se presione el botón de acción
                                      },
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  ref
                                      .read(vetProvider.notifier)
                                      .addclinicalRecord(
                                          uid,
                                          name,
                                          birthdate,
                                          nutrition,
                                          weight,
                                          behavior,
                                          treatmen,
                                          observation)
                                      .then((value) {
                                    context.pop();
                                    final snackBar = SnackBar(
                                      content: Text(
                                          'Ficha Clinica Editada con exito'),
                                      action: SnackBarAction(
                                        label: 'Close',
                                        onPressed: () {
                                          // Código que se ejecutará cuando se presione el botón de acción
                                        },
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  });
                                }
                              },
                              child: Text(
                                "Guardar",
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: data.map((record) {
                    return Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nombre mascota",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                  child: CustomTextInput(
                                onChanged: (namepet) {
                                  ref
                                      .read(namepetProvider.notifier)
                                      .update((state) => namepet);
                                  //state para obtener el nombre
                                },
                                label: "Beatriz",
                                hint: "${record.name}",
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Fecha Nacimiento",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              DateSelectionWidget(
                                onChanged: (day, month, year) {
                                  // Convertir los valores de cadena a enteros
                                  int dayInt = int.tryParse(day) ?? 1;
                                  int monthInt = getMonthNumber(month);
                                  int yearInt =
                                      int.tryParse(year) ?? DateTime.now().year;
                                  final date =
                                      DateTime(yearInt, monthInt, dayInt);

                                  ref
                                      .read(birthdateprovider.notifier)
                                      .update((state) => date);
                                  // Verificar si los valores son válidos
                                  // if (_isValidDate(dayInt, monthInt, yearInt)) {
                                  //   // Crear un objeto DateTime
                                  //   final date =
                                  //       DateTime(yearInt, monthInt, dayInt);

                                  //   // Actualizar el estado con la fecha seleccionada
                                  //   // ref
                                  //   //     .read(datevaccineProvider.notifier)
                                  //   //     .update((state) => date);
                                  // } else {
                                  //   // Manejar el caso de fecha inválida aquí
                                  //   print("Fecha inválida");
                                  // }
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nutricion",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                  child: CustomTextInput(
                                hint: "${record.nutrition}",
                                onChanged: (nutritions) {
                                  ref
                                      .read(nutritionprovider.notifier)
                                      .update((state) => nutritions);
                                },
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Peso",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                  child: CustomTextInput(
                                numericKeyboard: true,
                                enabled: true,
                                hint: "${record.weight}kg",
                                onChanged: (p0) {
                                  ref
                                      .read(weightprovider.notifier)
                                      .update((state) => int.parse(p0));
                                },
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Conducta",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                  child: CustomTextInput(
                                onChanged: (p0) {
                                  ref
                                      .read(behaviorprovider.notifier)
                                      .update((state) => p0);
                                },
                                label: "",
                                hint: "${record.behavior}",
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tratamiento",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              CustomTextInput(
                                onChanged: (p0) {
                                  ref
                                      .read(treatmenprovider.notifier)
                                      .update((state) => p0);
                                },
                                hint: "${record.treatmen}",
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Observaciones",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                  child: CustomTextInput(
                                label: "",
                                hint: "${record.observations}",
                                onChanged: (p0) {
                                  ref
                                      .read(observationsprovider.notifier)
                                      .update((state) => p0);
                                },
                              )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FilledButton.tonal(
                                  style: FilledButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: Text(
                                    "Cancelar",
                                    style: TextStyle(color: Colors.red),
                                  )),
                              SizedBox(
                                width: 30,
                              ),
                              FilledButton.tonal(
                                  style: FilledButton.styleFrom(
                                      backgroundColor: Color(0xff3D9A51)),
                                  onPressed: () {
                                    if (name.isEmpty) {
                                      final snackBar = SnackBar(
                                        content: Text('This is a SnackBar'),
                                        action: SnackBarAction(
                                          label: 'Close',
                                          onPressed: () {
                                            // Código que se ejecutará cuando se presione el botón de acción
                                          },
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      ref
                                          .read(vetProvider.notifier)
                                          .addclinicalRecord(
                                              uid,
                                              name,
                                              birthdate,
                                              nutrition,
                                              weight,
                                              behavior,
                                              treatmen,
                                              observation)
                                          .then((value) {
                                        context.pop();
                                        final snackBar = SnackBar(
                                          content: Text(
                                              'Ficha Clinica editada con exito'),
                                          action: SnackBarAction(
                                            label: 'Close',
                                            onPressed: () {
                                              // Código que se ejecutará cuando se presione el botón de acción
                                            },
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      });
                                    }
                                  },
                                  child: Text(
                                    "Guardar",
                                    style: TextStyle(color: Colors.white),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 100,
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            }
          },
          error: (error, stackTrace) {
            return Text("error");
          },
          loading: () {
            return CircularProgressIndicator();
          },
        ));
  }
}
