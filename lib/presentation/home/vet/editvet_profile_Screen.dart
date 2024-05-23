import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:migu/presentation/home/addvaccine_Screen.dart';
import 'package:migu/presentation/providers/vets/vets_provider.dart';
import 'package:migu/widgets/shared/custom_text_form_field.dart';

final atentionSwitchProvider = StateProvider<bool>((ref) {
  return false;
});
final atention2SwitchProvider = StateProvider<bool>((ref) {
  return false;
});

final typeSwitchProvider = StateProvider<bool>((ref) {
  return false;
});
final typ1SwitchProvider = StateProvider<bool>((ref) {
  return false;
});
final type2atention2SwitchProvider = StateProvider<bool>((ref) {
  return false;
});

final yearOfExperience = StateProvider<String>((ref) {
  return "seleccionar";
});

final phoneNumber = StateProvider<int>((ref) {
  return 0;
});

final specialtyProvider = StateProvider<String>((ref) {
  return "Seleccionar";
});

final imageUrlProvider = StateProvider<String>((ref) {
  return "";
});

final isLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

final lasnameProvider = StateProvider<String>((ref) {
  return "";
});

final offerparagraphProvider = StateProvider<String>((ref) {
  return "";
});
final directionProvider = StateProvider<String>((ref) {
  return "";
});
final offerparagrapharrayProvider = StateProvider<List>((ref) {
  return [];
});

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late String name = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((doc) {
        if (doc.exists) {
          setState(() {
            name = doc['name'];
          });
        }
      });
    }
  }

  Future<String?> uploadPhoto(WidgetRef ref) async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    ref.read(isLoadingProvider.notifier).update((state) => true);
    if (image != null) {
      try {
        // Sube la imagen a Firebase Storage
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('imagesvet/${DateTime.now().millisecondsSinceEpoch}');
        final uploadTask = storageRef.putFile(File(image.path));
        await uploadTask.whenComplete(() => null);

        // Obtiene la URL de la imagen subida
        final imageUrl = await storageRef.getDownloadURL();

        // Imprime la URL de la imagen subida
        print('URL de la imagen subida: $imageUrl');

        // Devuelve la URL de la imagen subida
        ref.read(imageUrlProvider.notifier).update((state) => imageUrl);
        ref.read(isLoadingProvider.notifier).update((state) => false);
      } catch (error) {
        print('Error al subir la imagen: $error');
        return null;
      }
    }

    // Si no se seleccionó ninguna imagen, devuelve null
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final profileVet = ref.watch(getProfileProvider);
    final uid = FirebaseAuth.instance.currentUser!.email;
    final atentionswitch = ref.watch(atentionSwitchProvider);
    final atention2switch = ref.watch(atention2SwitchProvider);
    final phone = ref.watch(phoneNumber);
    final yearOfExperiences = ref.watch(yearOfExperience);
    final specialty = ref.watch(specialtyProvider);
    final typevalueSwitchProvider = ref.watch(typeSwitchProvider);
    final typegatoSwitchProvider = ref.watch(typ1SwitchProvider);
    final typeExoticos = ref.watch(type2atention2SwitchProvider);
    final isloading = ref.watch(isLoadingProvider);
    final paragraph = ref.watch(offerparagrapharrayProvider);
    final lasname = ref.watch(lasnameProvider);
    final descrip = ref.watch(directionProvider);

    bool isLoading = false;
    final imagep = ref.watch(imageUrlProvider);

    void _createCollectionAndDocument(BuildContext context, String text) async {
      await FirebaseFirestore.instance.collection("example_collection").add({
        "example_field": "asdasd",
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Documento creado con éxito')));
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: profileVet.when(
          data: (data) {
            if (data.isEmpty) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Color(
                          0xFFF9F2E0), // Define el color usando el código hexadecimal
                      width: 500,
                      padding: EdgeInsets.all(
                          16), // Añade un relleno para espaciar los botones del borde del contenedor
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Centra los elementos en el eje principal (horizontal)
                        children: [
                          // Botón "Cancelar"
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white), // Fondo blanco
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Bordes cuadrados
                                ),
                              ),
                            ),
                            onPressed: () {
                              context.pop();
                              // Acción cuando se presiona el botón "Cancelar"
                            },
                            child: Text(
                              "Cancelar",
                              style: TextStyle(color: Colors.red), // Texto rojo
                            ),
                          ),
                          SizedBox(width: 16), // Espacio entre los botones
                          // Botón "Guardar"
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green), // Fondo verde
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Bordes cuadrados
                                ),
                              ),
                            ),
                            onPressed: () {
                              List<String> errores = [];
                              if (yearOfExperiences.isEmpty) {
                                errores.add(
                                    "El campo de años de experiencia está vacío");
                              }
                              // Validar cada campo y almacenar mensajes de error según corresponda
                              if (!atentionswitch && !atention2switch) {
                                errores.add(
                                    "Debe seleccionar al menos una opción de atención");
                              }
                              if (!typevalueSwitchProvider &&
                                  !typegatoSwitchProvider &&
                                  !typeExoticos) {
                                errores.add(
                                    "Debe seleccionar al menos una opción de tipo");
                              }

                              // Mostrar solo el primer error de cada tipo, si lo hay
                              if (errores.isNotEmpty) {
                                final snackbar =
                                    SnackBar(content: Text(errores.first));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                              } else {
                                ref
                                    .read(vetProvider.notifier)
                                    .setUser(
                                      name,
                                      lasname,
                                      uid!,
                                      phone,
                                      "",
                                      yearOfExperiences,
                                      specialty,
                                      {
                                        "online": atentionswitch,
                                        "home": atention2switch
                                      },
                                        descrip,
                                      {
                                        "perro": typevalueSwitchProvider,
                                        "gato": typegatoSwitchProvider,
                                        "exoticos": typeExoticos
                                      },
                                    
                                      paragraph,
                                      [],
                                      imagep,
                                    )
                                    .then((value) => context.pop());
                                // Acción cuando se presiona el botón "Guardar"
                              }
                            },
                            child: Text(
                              "Guardar",
                              style: TextStyle(
                                  color: Colors.white), // Texto blanco
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Editar Perfil",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              isLoading == false
                                  ? Row(
                                      children: [
                                        if (!imagep
                                            .isEmpty) // Condición para mostrar la imagen cargada
                                          Image.network(
                                            imagep,
                                            width: 40,
                                          ),
                                        if (imagep
                                            .isEmpty) // Condición para mostrar el botón de añadir foto
                                          GestureDetector(
                                              onTap: () async {
                                                setState(() {
                                                  isLoading =
                                                      true; // Activa el estado de carga
                                                });
                                                // Inicia la carga de la imagen
                                                await uploadPhoto(ref);
                                                setState(() {
                                                  isLoading =
                                                      false; // Desactiva el estado de carga
                                                });
                                              },
                                              child: Row(children: [
                                                Image.asset(
                                                  "assets/Frame1.png",
                                                  width: 60,
                                                ),
                                                Text(
                                                  "+Añade una Foto",
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                )
                                              ])),
                                      ],
                                    )
                                  : CircularProgressIndicator(), // Muestra un indicador de carga mientras se está cargando la imagen

                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Nombre",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      SizedBox(
                                          width: 140,
                                          height: 50,
                                          child: CustomTextFormField(
                                            label: "${name}",
                                            hint: "${name}",
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Apellido",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      SizedBox(
                                          width: 140,
                                          height: 50,
                                          child: CustomTextFormField(
                                            onChanged: (p0) {
                                              ref
                                                  .watch(
                                                      lasnameProvider.notifier)
                                                  .update((state) => p0);
                                            },
                                            label: "Beatriz",
                                            hint: "${lasname}",
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Correo",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  SizedBox(
                                      width: 340,
                                      height: 50,
                                      child: CustomTextFormField(
                                        enable: false,
                                        label: "Beatriz",
                                        hint:
                                            "${FirebaseAuth.instance.currentUser!.email!}",
                                      ))
                                ],
                              ),
                              SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Telefono",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  SizedBox(
                                      width: 340,
                                      height: 50,
                                      child: CustomTextFormField(
                                        keyboardType: TextInputType.number,
                                        onChanged: (number) {
                                          final parser = int.parse(number);
                                          ref
                                              .watch(phoneNumber.notifier)
                                              .update((state) => parser);
                                          //validacion debe emepzar con un nueve y debe ser nueve digitos
                                          //de lo contrario de numero invalido
                                        },
                                        label: "",
                                        hint: "+56 9",
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              MyDropdown(
                                defaultValue: "seleccionar",
                                label: "¿Cuántos años de experiencia?",
                                options: const [
                                  "seleccionar",
                                  "Menos de 3 años",
                                  "De 3 a 5 años",
                                  "De 5 a 10 años",
                                  "Más de 10 años"
                                ],
                                onChanged: (years) {
                                  ref
                                      .read(yearOfExperience.notifier)
                                      .update((state) => years!);
                                  // ref
                                  //     .read(marcaAntiparasitesProvider.notifier)
                                  //     .update((state) => marc!);
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              MyDropdown(
                                defaultValue: "Seleccionar",
                                label: "¿Qué especialidad?",
                                options: const [
                                  "Seleccionar",
                                  "Cardiologia",
                                  "Dermatología",
                                  "Cirugía Dental",
                                  "Ecografía",
                                  "Endocrinología",
                                  "Fisiatría",
                                  "Gastroenterología",
                                  "Medicina Felina",
                                  "Veterinaria Exótica",
                                  "Medicina Respiratoria",
                                  "Nefro-urología",
                                  "Neurología",
                                  "Oncología",
                                  "Radiología",
                                  "Otro",
                                ],
                                onChanged: (speciality) {
                                  ref
                                      .read(specialtyProvider.notifier)
                                      .update((state) => speciality!);
                                  // ref
                                  //     .read(marcaAntiparasitesProvider.notifier)
                                  //     .update((state) => marc!);
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Divider(color: Colors.grey[200], thickness: 10),
                          const Text(
                            "Atencion*",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[
                                  200], // Especificar el color dentro de BoxDecoration
                              borderRadius: BorderRadius.circular(
                                  10), // Ajusta el radio según tus necesidades
                            ),
                            height: 35,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Icon(Icons.help_outline),
                                  Text("Debes añadir al menos uno")
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SwitchDemo(
                            atentionswitch: atentionswitch,
                            provideratentionSwitchProvider:
                                atentionSwitchProvider,
                            text: "Online",
                          ),
                          SwitchDemo(
                            atentionswitch: atention2switch,
                            provideratentionSwitchProvider:
                                atention2SwitchProvider,
                            text: "A domicilio",
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Direccion",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                  width: 340,
                                  height: 50,
                                  child: CustomTextFormField(
                                    onChanged: (p0) {
                                      ref
                                          .read(directionProvider.notifier)
                                          .update((state) => p0);
                                    },
                                    label: "Beatriz",
                                    hint: "Direccion",
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Especies*",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[
                                  200], // Especificar el color dentro de BoxDecoration
                              borderRadius: BorderRadius.circular(
                                  10), // Ajusta el radio según tus necesidades
                            ),
                            height: 35,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Icon(Icons.help_outline),
                                  Text("Debes añadir al menos uno")
                                ],
                              ),
                            ),
                          ),
                          SwitchDemo(
                            atentionswitch: typevalueSwitchProvider,
                            provideratentionSwitchProvider: typeSwitchProvider,
                            text: "perros",
                          ),
                          SwitchDemo(
                            atentionswitch: typegatoSwitchProvider,
                            provideratentionSwitchProvider: typ1SwitchProvider,
                            text: "Gatos",
                          ),
                          SwitchDemo(
                            atentionswitch: typeExoticos,
                            provideratentionSwitchProvider:
                                type2atention2SwitchProvider,
                            text: "Exoticos",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Ofrece*",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[
                                  200], // Especificar el color dentro de BoxDecoration
                              borderRadius: BorderRadius.circular(
                                  10), // Ajusta el radio según tus necesidades
                            ),
                            height: 35,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Icon(Icons.help_outline),
                                  Text("Debes añadir al menos uno")
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "¿Que servicios ofreces?",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                 
                                  child: CustomTextFormField(
                                    onChanged: (p0) {
                                      // Dividir el texto en palabras usando la coma como delimitador
                                      List<String> palabras = p0
                                          .split(',')
                                          .map((word) => word.trim())
                                          .toList();
                                      ref
                                          .read(offerparagrapharrayProvider
                                              .notifier)
                                          .update((state) => palabras);
                                      // .trim() elimina cualquier espacio en blanco alrededor de cada palabra
                                    },
                                    label: "Beatriz",
                                    hint: "Ej: Veterinario General",
                                  )),
                              Text("10 máx. Usa una coma (,) para separar")
                            ],
                          ),
                          Container(
                              width: 400,
                              height: 100,
                              color: Colors.grey[200],
                              child: Row(
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
                                        // Lista para almacenar los mensajes de error
                                        List<String> errores = [];
                                        if (yearOfExperiences.isEmpty) {
                                          errores.add(
                                              "El campo de años de experiencia está vacío");
                                        }
                                        // Validar cada campo y almacenar mensajes de error según corresponda
                                        if (!atentionswitch &&
                                            !atention2switch) {
                                          errores.add(
                                              "Debe seleccionar al menos una opción de atención");
                                        }
                                        if (!typevalueSwitchProvider &&
                                            !typegatoSwitchProvider &&
                                            !typeExoticos) {
                                          errores.add(
                                              "Debe seleccionar al menos una opción de tipo");
                                        }

                                        // Mostrar solo el primer error de cada tipo, si lo hay
                                        if (errores.isNotEmpty) {
                                          final snackbar = SnackBar(
                                              content: Text(errores.first));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackbar);
                                        } else {
                                          ref
                                              .read(vetProvider.notifier)
                                              .setUser(
                                                name,
                                                lasname,
                                                uid!,
                                                phone,
                                                "",
                                                yearOfExperiences,
                                                specialty,
                                                {
                                                  "online": atentionswitch,
                                                  "home": atention2switch
                                                },
                                                descrip,
                                                {
                                                  "perro":
                                                      typevalueSwitchProvider,
                                                  "gato":
                                                      typegatoSwitchProvider,
                                                  "exoticos": typeExoticos
                                                },
                                           
                                                paragraph,
                                                [],
                                                imagep,
                                              )
                                              .then((value) => context.pop());
                                          //agregar que ya se ha creado la coleccion usuarios con un doc que dice perfilcompleto
                                          // vamos a subir solo la que sea tru
                                        }
                                      },
                                      child: const Text(
                                        "Guardar",
                                        style: TextStyle(color: Colors.white),
                                      ))
                                ],
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Editar Perfil",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Row(
                          //   children: [
                          //     Image.asset(
                          //       'assets/Frame1.png',
                          //       width: 80,
                          //     ),
                          //     imagep.isEmpty
                          //         ? GestureDetector(
                          //             onTap: () async {
                          //               // Inicia la carga de la imagen
                          //               uploadPhoto(ref);
                          //             },
                          //             child: Text(
                          //               "+Añade una foto",
                          //               style:
                          //                   TextStyle(color: Color(0xff3D9A51)),
                          //             ),
                          //           )
                          //         : Image.network(
                          //             imagep,
                          //             width: 50,
                          //           ),
                          //   ],
                          // ),
                          isloading == true
                              ? const CircularProgressIndicator() // Muestra un indicador de carga mientras se está cargando la imagen
                              : data[0]["image"] == ""
                                  ? GestureDetector(
                                      onTap: () {
                                        uploadPhoto(ref);
                                      },
                                      child: const Icon(
                                        Icons.image,
                                        size: 40,
                                      ))
                                  : imagep.isNotEmpty? GestureDetector(
                                    onTap: () {
                                           uploadPhoto(ref);
                                    },
                                    child: Image.network(imagep,width: 40,)): GestureDetector(
                                      onTap: () {
                                        uploadPhoto(ref);
                                      },
                                      child: ClipOval(
                                        child: Image.network(
                                          "${data[0]["image"]}",
                                          width: 40,
                                          fit: BoxFit
                                              .cover, // Esto ajustará la imagen para que cubra todo el área del círculo
                                        ),
                                      ),
                                    ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Nombre",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  SizedBox(
                                      width: 140,
                                      height: 50,
                                      child: CustomTextFormField(
                                        label: "${name}",
                                        hint: "${name}",
                                      ))
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Apellido",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  SizedBox(
                                      width: 140,
                                      height: 50,
                                      child: CustomTextFormField(
                                        label: "Beatriz",
                                        hint: "${data[0]["lastname"]}",
                                      ))
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Correo",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                  width: 340,
                                  height: 50,
                                  child: CustomTextFormField(
                                    enable: false,
                                    label: "Beatriz",
                                    hint:
                                        "${FirebaseAuth.instance.currentUser!.email!}",
                                  ))
                            ],
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Telefono",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                  width: 340,
                                  height: 50,
                                  child: CustomTextFormField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (number) {
                                      final parser = int.parse(number);
                                      ref
                                          .watch(phoneNumber.notifier)
                                          .update((state) => parser);
                                      //validacion debe emepzar con un nueve y debe ser nueve digitos
                                      //de lo contrario de numero invalido
                                    },
                                    label: "",
                                    hint: "${data[0]["phone"]}",
                                  ))
                            ],
                          ),
                          MyDropdown(
                            defaultValue: "${data[0]["yearsofexperience"]}",
                            label: "Cuantos años de experiencia",
                            options: const [
                              "seleccionar",
                              "Menos de 3 años",
                              "De 3 a 5 años",
                              "De 5 a 10 años",
                              "Más de 10 años"
                            ],
                            onChanged: (years) {
                              ref
                                  .read(yearOfExperience.notifier)
                                  .update((state) => years!);
                              // ref
                              //     .read(marcaAntiparasitesProvider.notifier)
                              //     .update((state) => marc!);
                            },
                          ),
                          MyDropdown(
                            defaultValue: "${data[0]["speciality"]}",
                            label: "que Expecialidad",
                            options: const [
                              "Seleccionar",
                              "Cardiologia",
                              "Dermatología",
                              "Cirugía Dental",
                              "Ecografía",
                              "Endocrinología",
                              "Fisiatría",
                              "Gastroenterología",
                              "Medicina Felina",
                              "Veterinaria Exótica",
                              "Medicina Respiratoria",
                              "Nefro-urología",
                              "Neurología",
                              "Oncología",
                              "Radiología",
                              "Otro",
                            ],
                            onChanged: (speciality) {
                              ref
                                  .read(specialtyProvider.notifier)
                                  .update((state) => speciality!);
                              // ref
                              //     .read(marcaAntiparasitesProvider.notifier)
                              //     .update((state) => marc!);
                            },
                          ),
                        ],
                      ),
                      const Text(
                        "Atencion*",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                      ),
                      Container(
                        height: 30,
                        color: Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Icon(Icons.help),
                              Text("Debes añadir al menos uno")
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SwitchDemo(
                        atentionswitch: data.isNotEmpty
                            ? data[0]['atentions']["online"]
                            : null,
                        provideratentionSwitchProvider: atentionSwitchProvider,
                        text: "Online",
                      ),
                      SwitchDemo(
                        atentionswitch: data.isNotEmpty
                            ? data[0]['atentions']["home"]
                            : null,
                        provideratentionSwitchProvider: atention2SwitchProvider,
                        text: "A domicilio",
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Direccion",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                              width: 340,
                              height: 50,
                              child: CustomTextFormField(
                                onChanged: (p0) {
                                  ref
                                      .read(directionProvider.notifier)
                                      .update((state) => p0);
                                },
                                label: "Beatriz",
                                hint: "${data[0]["address"]}",
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Especies*",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                      ),
                      Container(
                        height: 30,
                        color: Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Icon(Icons.help),
                              Text("Debes añadir al menos uno")
                            ],
                          ),
                        ),
                      ),
                      SwitchDemo(
                        atentionswitch: data.isEmpty
                            ? data[0]['choosespecies']["perro"]
                            : typevalueSwitchProvider,
                        provideratentionSwitchProvider: typeSwitchProvider,
                        text: "perros",
                      ),
                      SwitchDemo(
                        atentionswitch: data.isEmpty
                            ? data[0]['choosespecies']["gato"]
                            : typegatoSwitchProvider,
                        provideratentionSwitchProvider: typ1SwitchProvider,
                        text: "Gatos",
                      ),
                      SwitchDemo(
                        atentionswitch: data.isEmpty
                            ? data[0]['choosespecies']["exoticos"]
                            : typeExoticos,
                        provideratentionSwitchProvider:
                            type2atention2SwitchProvider,
                        text: "Exoticos",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Ofrece*",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                      ),
                      Container(
                        height: 30,
                        color: Colors.grey[200],
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Icon(Icons.help),
                              Text("Debes añadir al menos uno")
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "¿Que servicios ofreces?",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                              width: 340,
                              height: 50,
                              child: CustomTextFormField(
                                onChanged: (p0) {
                                 List<String> palabras = p0
                                          .split(',')
                                          .map((word) => word.trim())
                                          .toList();
                                      ref
                                          .read(offerparagrapharrayProvider
                                              .notifier)
                                          .update((state) => palabras);
                                },
                                label: "Beatriz",
                                hint: "${data[0]["offerparagraph"]}",
                              )),
                          Text("10 máx. Usa una coma (,) para separar")
                        ],
                      ),
                      Container(
                          width: 400,
                          height: 100,
                          color: Colors.grey[200],
                          child: Row(
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
                                    // Lista para almacenar los mensajes de error
                                    // List<String> errores = [];
                                    // if (yearOfExperiences.isEmpty) {
                                    //   errores.add(
                                    //       "El campo de años de experiencia está vacío");
                                    // }
                                    // // Validar cada campo y almacenar mensajes de error según corresponda
                                    // if (!atentionswitch && !atention2switch) {
                                    //   errores.add(
                                    //       "Debe seleccionar al menos una opción de atención");
                                    // }
                                    // if (!typevalueSwitchProvider &&
                                    //     !typegatoSwitchProvider &&
                                    //     !typeExoticos) {
                                    //   errores.add(
                                    //       "Debe seleccionar al menos una opción de tipo");
                                    // }

                                    // // Mostrar solo el primer error de cada tipo, si lo hay
                                    // if (errores.isNotEmpty) {
                                    //   final snackbar = SnackBar(
                                    //       content: Text(errores.first));
                                    //   ScaffoldMessenger.of(context)
                                    //       .showSnackBar(snackbar);
                                    // } else {

                                    //agregar apellido

                                  ref.read(vetProvider.notifier).setUser(
    name == "" ? data[0]["name"] : name,
    lasname == "" ? data[0]["lastname"] : lasname,
  
    uid!,
    phone,
  "servici",
    yearOfExperiences == "" ? data[0]["yearsofexperience"] : yearOfExperiences,
    specialty == "" ? data[0]["speciality"] : specialty,
    {
      "online": atentionswitch,
      "home": atention2switch
    },
    descrip,
    {
      "perro": typevalueSwitchProvider,
      "gato": typegatoSwitchProvider,
      "exoticos": typeExoticos
    },

       paragraph.isEmpty ? data[0]["offerparagraph"] : paragraph,
   [],
    imagep.isEmpty ? data[0]["image"] : imagep
   
).then((value) => context.pop());

                                    //agregar que ya se ha creado la coleccion usuarios con un doc que dice perfilcompleto
                                    // vamos a subir solo la que sea tru
                                  },
                                  // },
                                  child: const Text(
                                    "Guardar",
                                    style: TextStyle(color: Colors.white),
                                  ))
                            ],
                          ))
                    ],
                  ),
                ),
              );
            }
          },
          error: (error, stackTrace) {
            return Text("");
          },
          loading: () {
            return Text("asd");
          },
        ));
  }
}

class SwitchDemo extends ConsumerStatefulWidget {
  final String text;
  final bool? atentionswitch; // Cambiado a tipo bool nullable
  StateProvider<bool> provideratentionSwitchProvider;

  SwitchDemo({
    Key? key,
    required this.text,
    this.atentionswitch, // Permitiendo que el valor sea opcional
    required this.provideratentionSwitchProvider,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SwitchDemoState();
}

class _SwitchDemoState extends ConsumerState<SwitchDemo> {
  late bool _switchValue;

  @override
  void initState() {
    super.initState();
    // Si el valor inicial es null, establecerlo en false
    _switchValue = widget.atentionswitch ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          activeColor: Colors.green, // Color del switch cuando está activado
          activeTrackColor: Colors.green.withOpacity(0.8),
          value: _switchValue,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.grey[200],

          onChanged: (value) {
            setState(() {
              _switchValue = value;
            });
            // Actualizar el estado del switch usando el provider
            ref
                .read(widget.provideratentionSwitchProvider.notifier)
                .update((state) => value);
          },
        ),
        Text(
          widget.text,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ],
    );
  }
}




//nombre
//apellido
//correo
//telefono
//que servicio ofreces
//cuantos años de experiencia
//que expecialidad
//atencion
//direcion
//especies
//servicio que ofreces
