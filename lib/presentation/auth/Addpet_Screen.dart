import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:migu/presentation/views/home_view.dart';
import 'package:migu/widgets/shared/custom_text_form_field.dart';

String imageUrl = "";
final finishEdititProvider = StateProvider<bool>((ref) {
  return false;
});
final photopetProvider = StateProvider<String>((ref) {
  return "";
});

class AddPet extends ConsumerStatefulWidget {
  const AddPet({super.key});

  @override
  _AddPetState createState() => _AddPetState();
}

class _AddPetState extends ConsumerState<AddPet> {
  late List<bool> _selections;
  @override
  void initState() {
    super.initState();
    _selections = List.generate(3, (index) => false); // Inicializar selecciones
  }

  final imageProvider = StateProvider<String>((ref) {
    return "";
  });

  final inputvalueProvider = StateProvider<String>((ref) {
    return "";
  });
  final isurlFinishProvider = StateProvider<bool>((ref) {
    return false;
  });

  final urlProvider = StateProvider<String>((ref) {
    return "";
  });

  Future<String?> takePhoto() async {
    final XFile? photo = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (photo == null) return null;

    ref.read(imageProvider.notifier).update((state) => photo.path);
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child("photosUserPet");
    Reference referenceImageToUplad = referenceDirImages.child(photo.name);
    try {
      await referenceImageToUplad.putFile(File(photo.path));
      imageUrl = await referenceImageToUplad.getDownloadURL();

      ref.read(urlProvider.notifier).update((state) => imageUrl);
      ref.read(isurlFinishProvider.notifier).update((state) => true);
    } catch (e) {
      return null;
    }
  }

  final namepetProvider = StateProvider<String>((ref) {
    return "";
  });
  @override
  Widget build(BuildContext context) {
    final imageCaptureTemp = ref.watch(imageProvider);
    final typepet = ref.watch(typepetProvider);
    final urlFirebaseDowload = ref.watch(urlProvider);
    final namePet = ref.watch(inputvalueProvider);
    final isEditing = ref.watch(isEditPerProvider);
    final name = ref.watch(namepetProvider);
    return Scaffold(
        backgroundColor: Colors.white,
        body: isEditing
            ? const EditPet()
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Agrega tu mascota',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final photoPath = await takePhoto();

                          if (photoPath == null) return;
                          // Implementa la lógica para subir la foto
                        },
                        child: imageCaptureTemp != ""
                            ? urlFirebaseDowload == ""
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                  )
                                : Container(
                                    width: 80, // Ancho del contenedor
                                    height: 80, // Altura del contenedor
                                    decoration: BoxDecoration(
                                      shape: BoxShape
                                          .circle, // Hace que el contenedor tenga forma de círculo
                                    ),
                                    child: ClipOval(
                                      child: Image.file(
                                        File(imageCaptureTemp),
                                        fit: BoxFit
                                            .contain, // Ajustar la imagen dentro del contenedor
                                        width:
                                            80, // Ancho de la imagen dentro del ClipOval
                                        height:
                                            80, // Altura de la imagen dentro del ClipOval
                                      ),
                                    ),
                                  )
                            : Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 1,
                                  ),
                                ),
                                child: const Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Text(
                                      'Subir Foto',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      const SizedBox(height: 20),
                      const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child:
                              Text("Nombre", style: TextStyle(fontSize: 17))),
                      CustomTextFormField(
                        hint: 'Nombre de la Mascota',
                        onChanged: (value) {
                          ref
                              .read(inputvalueProvider.notifier)
                              .update((state) => value);
                        },
                        // Añade cualquier lógica necesaria para el campo de texto
                      ),
                      const SizedBox(height: 20),
                      const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child:
                              Text("Especie:", style: TextStyle(fontSize: 17))),
                      ToggleButtonsDemo(
                        type: typepet,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 300,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Bordes cuadrados
                              ),
                              backgroundColor: Color(0xFF3D9A51),
                              padding: EdgeInsets.symmetric(vertical: 20)),
                          onPressed: () {
                            // context.go("/home/0");
                            if (namePet.isEmpty || typepet.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    'Por favor, complete todos los campos'),
                                duration: Duration(
                                    seconds: 3), // Duración del Snackbar
                              ));
                            } else {
                              ref
                                  .read(photopetProvider.notifier)
                                  .update((state) => urlFirebaseDowload);
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .set({
                                "name": namePet,
                                "urlImage": urlFirebaseDowload,
                                "type": typepet
                              });
                            }
                          },
                          child: isEditing
                              ? Text(
                                  "Guardar",
                                  style: TextStyle(color: Colors.white),
                                )
                              : const Text(
                                  "Continuar",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                )));
  }
}

class SquareButton extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback onPressed;
  final bool selected;
  final Color selectedColor;

  const SquareButton({
    required this.icon,
    required this.text,
    required this.onPressed,
    required this.selected,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? selectedColor : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Bordes redondeados
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          Image.asset(
            icon,
            width: 45,
          ),
          // FaIcon(
          //   icon,
          //   size: 40,
          //   color: Colors.black, // Color del icono
          // ),

          const SizedBox(height: 10), // Espaciado entre el icono y el texto
          Text(
            text,
            style: const TextStyle(
              color: Colors.black, // Color del texto
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class SquareButton2 extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final bool selected;

  const SquareButton2({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: selected
            ? const Color(0xffD8EBDC)
            : Colors.white, // Color de fondo del botón
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Bordes redondeados
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.black, // Color del texto
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

final typepetProvider = StateProvider<String>((ref) {
  return "";
});

class ToggleButtonsDemo extends ConsumerStatefulWidget {
  String type;
  ToggleButtonsDemo({super.key, this.type = ""});

  @override
  _ToggleButtonsDemoState createState() => _ToggleButtonsDemoState();
}

class _ToggleButtonsDemoState extends ConsumerState<ToggleButtonsDemo> {
  List<bool> _dogSelections = [];
  List<bool> _catSelections = [];
  List<bool> _otterSelections = [];
  int _selectedColorIndex = -1;

  @override
  void initState() {
    super.initState();
    _initializeSelections();
  }

  void _initializeSelections() {
    switch (widget.type) {
      case "Perro":
        _dogSelections = [true];
        _catSelections = [false];
        _otterSelections = [false];
        break;
      case "Gato":
        _dogSelections = [false];
        _catSelections = [true];
        _otterSelections = [false];
        break;
      case "otro":
        _dogSelections = [false];
        _catSelections = [false];
        _otterSelections = [true];
        break;
      default:
        _dogSelections = [false];
        _catSelections = [false];
        _otterSelections = [false];
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ToggleButtons(
            borderWidth: 0,
            borderColor: Colors.white,
            borderRadius: BorderRadius.circular(20),
            isSelected: [
              ..._dogSelections,
              ..._catSelections,
              ..._otterSelections
            ],
            onPressed: (int index) {
              setState(() {
                _selectedColorIndex = index;
              });
            },
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(5),
                height: 140,
                child: SquareButton(
                  icon: "assets/perro.png",
                  text: 'Perro',
                  onPressed: () {
                    setState(() {
                      _dogSelections[0] = !_dogSelections[0];
                      if (_dogSelections[0]) {
                        _selectedColorIndex = 0;
                      } else {
                        _selectedColorIndex = -1;
                      }
                      _catSelections[0] = false;
                      _otterSelections[0] = false;
                    });
                    ref
                        .read(typepetProvider.notifier)
                        .update((state) => "Perro");
                  },
                  selected: _dogSelections[0],
                  selectedColor: const Color(0xffD8EBDC),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(5),
                child: SquareButton(
                  icon: "assets/gato.png",
                  text: 'Gato',
                  onPressed: () {
                    setState(() {
                      _catSelections[0] = !_catSelections[0];
                      if (_catSelections[0]) {
                        _selectedColorIndex = 1;
                      } else {
                        _selectedColorIndex = -1;
                      }
                      _dogSelections[0] = false;
                      _otterSelections[0] = false;
                    });
                    ref
                        .read(typepetProvider.notifier)
                        .update((state) => "Gato");
                  },
                  selected: _catSelections[0],
                  selectedColor: const Color(0xffD8EBDC),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(5),
                child: SquareButton(
                  icon: "assets/conejo.png",
                  text: 'Otro',
                  onPressed: () {
                    setState(() {
                      _otterSelections[0] = !_otterSelections[0];
                      if (_otterSelections[0]) {
                        _selectedColorIndex = 2;
                      } else {
                        _selectedColorIndex = -1;
                      }
                      _dogSelections[0] = false;
                      _catSelections[0] = false;
                      ref
                          .read(typepetProvider.notifier)
                          .update((state) => "otro");
                    });
                  },
                  selected: _otterSelections[0],
                  selectedColor: Color(0xffD8EBDC),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

final newnameProvider = StateProvider<String>((ref) {
  return "";
});

final image2Provider = StateProvider<String>((ref) {
  return "";
});
final urlProvider = StateProvider<String>((ref) {
  return "";
});
final isurlFinishProvider = StateProvider<bool>((ref) {
  return false;
});

class EditPet extends ConsumerWidget {
  const EditPet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<String?> takePhoto() async {
      
      final XFile? photo = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (photo == null) return null;

      ref.read(image2Provider.notifier).update((state) => photo.path);
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child("photosUserPet");
      Reference referenceImageToUplad = referenceDirImages.child(photo.name);
      try {
        await referenceImageToUplad.putFile(File(photo.path));
        imageUrl = await referenceImageToUplad.getDownloadURL();

        ref.read(urlProvider.notifier).update((state) => imageUrl);
        ref.read(isurlFinishProvider.notifier).update((state) => false);
      } catch (e) {
        return null;
      }
    }

    final updateimage = ref.watch(urlProvider);
    final typePet = ref.watch(typepetProvider);
    final namePet = ref.watch(newnameProvider);
    final isSaving = ref.watch(finishEdititProvider);
    final tempUrl = ref.watch(isurlFinishProvider);
    final imagecaptur = ref.watch(image2Provider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Aquí puedes ejecutar la acción que desees
            ref.read(isurlFinishProvider.notifier).update((state) => false);
            // Por ejemplo, puedes navegar hacia atrás en el historial de navegación
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        // TODO: agregar una flecha
        children: [
          if (isSaving)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
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

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Editar mascota',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 50),

                      imagecaptur != ""
                          ? updateimage == ""
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                )
                              : Container(
                                  width: 80, // Ancho del contenedor
                                  height: 80, // Altura del contenedor
                                  decoration: const BoxDecoration(
                                    shape: BoxShape
                                        .circle, // Hace que el contenedor tenga forma de círculo
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                        final snackBar = SnackBar(
                content: const Text('No puede volver a editar la imagen'),
                duration: const Duration(seconds: 3), // Duración del Snackbar
                action: SnackBarAction(
                  label: 'Cerrar',
                  onPressed: () {
                    // Código a ejecutar cuando se presiona el botón de acción
                  
                  },
                ),
              );
              // Mostrar el Snackbar utilizando ScaffoldMessenger
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      // await takePhoto();
                               
                                    },
                                    child: ClipOval(
                                      child: Image.file(
                                        File(imagecaptur),
                                        fit: BoxFit
                                            .cover, // Ajustar la imagen dentro del contenedor
                                        width:
                                            80, // Ancho de la imagen dentro del ClipOval
                                        height:
                                            80, // Altura de la imagen dentro del ClipOval
                                      ),
                                    ),
                                  ),
                                )
                          : GestureDetector(
                              onTap: () async {
                                await takePhoto();
                              },
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(photoUrl),
                                radius: 48.0,
                              ),
                            ),
                      // if (photoUrl.isEmpty)
                      //   GestureDetector(
                      //     onTap: () async {
                      //       final photoPath = await takePhoto();

                      //       if (photoPath == null) {
                      //         ref
                      //             .read(isurlFinishProvider.notifier)
                      //             .update((state) => false);
                      //       }
                      //     },
                      //     child: const Icon(
                      //       Icons.image_not_supported_rounded,
                      //       size: 70,
                      //     ),
                      //   )
                      // // _buildPetImage(type)
                      // else
                      //   GestureDetector(
                      //     onTap: () {
                      //       takePhoto();
                      //     },
                      //     child: tempUrl == false
                      //         ? updateimage != ""
                      //             ? CircleAvatar(
                      //                 backgroundImage:
                      //                     NetworkImage(updateimage),
                      //                 radius: 48.0,
                      //               )
                      //             : CircleAvatar(
                      //                 backgroundImage: NetworkImage(photoUrl),
                      //                 radius: 48.0,
                      //               )
                      //         : CircularProgressIndicator(),
                      //   ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 20),
                            const Text("Nombre",
                                style: TextStyle(fontSize: 17)),
                            CustomTextFormField(
                              hint: name,
                              onChanged: (value) {
                                ref
                                    .read(newnameProvider.notifier)
                                    .update((state) => value);
                              },
                            ),
                            const SizedBox(height: 20),
                            const Text("Especie:",
                                style: TextStyle(fontSize: 17)),
                            ToggleButtonsDemo(type: type),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 300,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: const Color(0xFF3D9A51),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                ),
                                onPressed: () async {
                                  if (typePet.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Por favor, complete todos los campos'),
                                        duration: Duration(seconds: 3),
                                      ),
                                    );
                                  } else {
                                    ref
                                        .read(finishEdititProvider.notifier)
                                        .update((state) => true);

                                    try {
                                      await FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .update({
                                        'name': namePet.isEmpty?name:namePet,
                                        'urlImage': updateimage.isEmpty?photoUrl:updateimage,
                                        'type': typePet.isEmpty?type:typePet,
                                      }).then((value) => {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content:
                                                      Text('Perfil Editado'),
                                                  duration:
                                                      Duration(seconds: 3),
                                                ))
                                              });
                                      ref
                                          .read(finishEdititProvider.notifier)
                                          .update((state) => false);
                                            ref.read(isurlFinishProvider.notifier).update((state) => false);
                                      context.go("/home/0");
                                    } catch (error) {
                                      ref
                                          .read(finishEdititProvider.notifier)
                                          .update((state) => false);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Error: $error'),
                                          duration: Duration(seconds: 3),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: const Text(
                                  "Guardar",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const CircularProgressIndicator(); // Placeholder for loading state
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPetImage(String type) {
    if (type == "Perro") {
      return GestureDetector(
        onTap: () {},
        child: ClipOval(
          child: Image.asset(
            "assets/perro.png",
            width: 50,
          ),
        ),
      );
    } else if (type == "otro") {
      return SizedBox(
        height: 100,
        child: ClipOval(
          child: Image.asset(
            "assets/conejo.png",
            width: 50,
          ),
        ),
      );
    } else {
      return ClipOval(
        child: Image.asset(
          "assets/gato.png",
          width: 90,
        ),
      );
    }
  }
}
