import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:migu/presentation/providers/auth/auth_provider.dart';
import 'package:migu/presentation/providers/auth/register_form_provider.dart';
import 'package:migu/widgets/shared/custom_text_form_field.dart';

import 'package:url_launcher/url_launcher.dart';

signInWithGoogle() async {
  final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
  print(gUser);
  final GoogleSignInAuthentication? gAuth = await gUser?.authentication;

  AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: gAuth?.accessToken,
    idToken: gAuth?.idToken,
  );
  UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
  print(userCredential.user?.displayName);
}

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerForm = ref.watch(registerformProvider);
    final Uri _urlTerm = Uri.parse('https://migupets.com/tc.html');
    final Uri privacypolicy = Uri.parse('https://migupets.com/privacy.html');

    Future<void> termsandConditions() async {
      if (!await launchUrl(_urlTerm)) {
        throw Exception('Could not launch $_urlTerm');
      }
    }

    Future<void> _launchUrl() async {
      if (!await launchUrl(privacypolicy)) {
        throw Exception('Could not launch $privacypolicy');
      }
    }

    GoogleSignIn _googleSignIn = GoogleSignIn();
    handleSignIn() async {
      try {
        GoogleSignInAccount? account = await _googleSignIn.signIn();
        if (account != null) {
          print("account.displayName${account.displayName}");
          // Resto del código aquí
        }
      } catch (error) {
        print(error);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Image.asset(
                "assets/Migu1.png",
                width: 90,
                height: 60,
              ),
              const SizedBox(height: 100),
              // Container(
              //   constraints: const BoxConstraints(maxWidth: 300),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: Color.fromARGB(255, 255, 255, 255),
              //           padding: const EdgeInsets.symmetric(
              //             vertical: 15,
              //             horizontal: 30,
              //           ),
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(10),
              //             side: const BorderSide(
              //               color: Color(0xff3D9A51),
              //               width: 1,
              //             ),
              //           ),
              //         ),
              //         onPressed: () {
              //           // ref.read(authProvider.notifier).googleLogin();
              //           signInWithGoogle();

              //           // Acción al presionar el botón de inicio de sesión con Google
              //         },
              //         child: Row(
              //           children: [
              //             Image.asset(
              //               'assets/google.png', // Reemplaza con la ruta de la imagen de Google
              //               width: 24,
              //               height: 24,
              //             ),
              //             SizedBox(
              //                 width: 10), // Espacio entre la imagen y el texto
              //             const Text(
              //               "Regístrate con Google",
              //               style: TextStyle(
              //                 color: Colors.black,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              // const SizedBox(height: 20),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Expanded(
              //         child: Divider(
              //           color: Colors.grey,
              //           thickness: 1,
              //         ),
              //       ),
              //       Padding(
              //         padding: EdgeInsets.symmetric(horizontal: 8),
              //         child: Text(
              //           "o",
              //           style: TextStyle(fontSize: 18),
              //         ),
              //       ),
              //       Expanded(
              //         child: Divider(
              //           color: Colors.grey,
              //           thickness: 1,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              const SizedBox(height: 10),
              // const  Padding(
              //       padding: EdgeInsets.only(right: 300),
              //       child: Text("Correo", style: TextStyle(fontSize: 17))),

              SizedBox(
                width: 360,
                child: CustomTextFormField(
                  hint: "ejemplo@gmail.com",
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => ref
                      .read(registerformProvider.notifier)
                      .onEmailChange(value),
                  errorMessage: registerForm.isFormPosted
                      ? registerForm.email.errorMessage
                      : null,
                  // Aquí puedes manejar el cambio en el campo de texto
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Bordes cuadrados
                      ),
                      backgroundColor: const Color(0xFF3D9A51),
                      padding: const EdgeInsets.symmetric(vertical: 20)),
                  onPressed: () {
                    if (registerForm.email.isValid) {
                      context.push("/additionalInfo");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Ingresa un email valido'),
                          duration:
                              Duration(seconds: 3), // Duración del Snackbar
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Continuar",
                    style: TextStyle(color: Colors.white),
                  ),  
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: "Al registrarte, aceptas nuestros"),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Aquí puedes agregar la lógica para abrir los términos y condiciones
                                // por ejemplo, puedes usar Navigator para navegar a otra página
                                termsandConditions();
                              },
                            text: " Términos y Condiciones",
                            style: const TextStyle(color: Colors.green)),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Aquí puedes agregar la lógica para abrir los términos y condiciones
                                // por ejemplo, puedes usar Navigator para navegar a otra página
                                _launchUrl();
                              },
                            text: " Política de privacidad",
                            style: const TextStyle(color: Colors.green))
                      ]),
                ),
              ),
              const SizedBox(height: 140),
              // Spacer(), // Spacer para llenar el espacio restante

              GestureDetector(
                onTap: () {
                  // Navegar a la pantalla de inicio de sesión
                  context.push("/login");
                },
                child: RichText(
                  text: const TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: [
                       TextSpan(
                        text: '¿Ya tienes una cuenta? ',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextSpan(
                        text: 'Inicia sesión',
                        style: const TextStyle(
                            color: Colors.green, fontSize: 15), // Color verde
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget de botón personalizado con fondo lleno.
class FilledButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const FilledButton({required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ElevatedButton.styleFrom(
        primary: Colors.blue, // Cambiar el color del botón aquí
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: const TextStyle(fontSize: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
