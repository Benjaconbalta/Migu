import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:migu/widgets/shared/custom_text_form_field.dart';


String imageUrl = "";

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

  @override
  Widget build(BuildContext context) {
    final imageCaptureTemp = ref.watch(imageProvider);
    final typepet = ref.watch(typepetProvider);
    final urlFirebaseDowload = ref.watch(urlProvider);
    final namePet = ref.watch(inputvalueProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                  height: 100,
                ),
                imageCaptureTemp != ""
                    ? Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: FileImage(File(imageCaptureTemp)),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          final photoPath = await takePhoto();

                          if (photoPath == null) return;
                          // Implementa la lógica para subir la foto
                        },
                        child: Container(
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
              const  SizedBox(height: 20),
               const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text("Nombre", style: TextStyle(fontSize: 17))),
                CustomTextFormField(
                  hint: 'Nombre de la Mascota',
                  onChanged: (value) {
                    ref
                        .read(inputvalueProvider.notifier)
                        .update((state) => value);
                  },
                  // Añade cualquier lógica necesaria para el campo de texto
                ),
              const  SizedBox(height: 20),
              const  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text("Especie", style: TextStyle(fontSize: 17))),
               const ToggleButtonsDemo(),
               const SizedBox(height: 20),
                Container(
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Bordes cuadrados
                        ),
                        backgroundColor: Color(0xFF3D9A51),
                        padding: EdgeInsets.symmetric(vertical: 20)),
                    onPressed: () {
                      // context.go("/home/0");
                      if (namePet.isEmpty ||
                          
                          typepet.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Por favor, complete todos los campos'),
                          duration:
                              Duration(seconds: 3), // Duración del Snackbar
                        ));
                      }
                      else if (urlFirebaseDowload.isEmpty) {
                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                     content: Text('Espere mientras la imagen se sube'),
                     duration: Duration(seconds: 3),
                    ));
} 
                      
                       else {
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
                    child: const Text(
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
          )),
    );
  }
}

class SquareButton extends StatelessWidget {
  final IconData icon;
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
          FaIcon(
            icon,
            size: 40,
            color: Colors.black, // Color del icono
          ),

        const  SizedBox(height: 10), // Espaciado entre el icono y el texto
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

  const SquareButton2({super.key, 
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
            style:const TextStyle(
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
  const ToggleButtonsDemo({super.key});

  @override
  _ToggleButtonsDemoState createState() => _ToggleButtonsDemoState();
}

class _ToggleButtonsDemoState extends ConsumerState<ToggleButtonsDemo> {
final  List<bool> _dogSelections = [false];
 final List<bool> _catSelections = [false];
 final List<bool> _otterSelections = [false];
  int _selectedColorIndex = -1;

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
                  icon: FontAwesomeIcons.dog,
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
                  icon: FontAwesomeIcons.cat,
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
                  icon: Icons.navigate_next_sharp,
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
