import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:migu/presentation/providers/auth/auth_provider.dart';

import 'package:migu/presentation/providers/auth/login_form_provider.dart';
import 'package:migu/widgets/shared/custom_text_form_field.dart';


class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
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
              const SizedBox(height: 80),
            //   Container(
            //       constraints: const BoxConstraints(maxWidth: 300),
            //       child: Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.white,
            //         padding: const EdgeInsets.symmetric(
            //           vertical: 15,
            //           horizontal: 30,
            //         ),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(10),
            //           side: const BorderSide(
            //             color: Color(0xff3D9A51),
            //             width: 1,
            //           ),
            //         ),
            //       ),
            //       onPressed: () {
            //             ref.read(authProvider.notifier).googleLogin();
            //         // Acción al presionar el botón de inicio de sesión con Google
            //       },
            //       child: Row(
            //         children: [
            //           Image.asset(
            //             'assets/google.png', // Reemplaza con la ruta de la imagen de Google
            //             width: 24,
            //             height: 24,
            //           ),
            //        const   SizedBox(width: 10), // Espacio entre la imagen y el texto
            //        const   Text(
            //             "Iniciar Sesión con Google",
            //             style: TextStyle(
            //               color: Colors.black,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
          
            //           ),
          
              const SizedBox(height: 10),
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
          
              const SizedBox(height: 20),
              // const Padding(
              //     padding: EdgeInsets.only(right: 300),
              //     child: Text("Correo", style: TextStyle(fontSize: 17))),
          
              SizedBox(
                width: 360,
                child: CustomTextFormField(
                  hint: "ejemplo@gmail.com",
                  onChanged: (value) =>
                      ref.read(loginFormProvider.notifier).onEmailChange(value),
                  //esto es para que solo te diga el error cuando se haga el posteo y no cuando se este escribiendo
                  errorMessage: loginForm.isFormPosted
                      ? loginForm.email.errorMessage
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              // const Padding(
              //     padding: EdgeInsets.only(right: 300),
              //     child: Text(" password", style: TextStyle(fontSize: 17))),
          
              SizedBox(
                width: 360,
                child: CustomTextFormField(
                  obscureText: true,
                  hint: "*******",
                  onChanged: (value) => ref
                      .read(loginFormProvider.notifier)
                      .onPasswordChange(value),
                  
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
                    // context.push("/additionalInfo");
          // Dentro de tu widget
          void showSnackBar(String message) {
            final snackBar = SnackBar(
              content: Text(message),
              action: SnackBarAction(
                label: 'Cerrar',
                onPressed: () {
          // Aquí puedes agregar cualquier acción que desees realizar
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            );
          
            // Mostrar el SnackBar en el contexto actual
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
                    ref.read(loginFormProvider.notifier).onFormSubmit(showSnackBar);
          
                    // Aquí puedes manejar la acción de continuar
                  },
                  child: const Text(
                    "Continuar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding:  EdgeInsets.all(30.0),
              ),
              const SizedBox(height: 120),
              // Spacer(), // Spacer para llenar el espacio restante
          
            GestureDetector(
                onTap: () {
                  // Navegar a la pantalla de inicio de sesión
                  context.push("/register");
                },
                child: RichText(
                  text: const TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: [
                      const TextSpan(
                        text: '¿No tienes cuenta? ',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextSpan(
                        text: 'Regístrate',
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
