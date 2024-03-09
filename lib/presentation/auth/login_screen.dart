import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:migu/presentation/providers/auth/login_form_provider.dart';
import 'package:migu/widgets/shared/custom_text_form_field.dart';
 void signInwithGoogle() async {
    GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleauth = await googleuser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleauth?.accessToken,
      idToken: googleauth?.idToken,
    );
    UserCredential userCretendial =
        await FirebaseAuth.instance.signInWithCredential(credential);
  }

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});
 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
         const SizedBox(
              height: 100,
            ),
            Image.asset(
              "assets/Migu.png",
              width: 90,
              height: 60,
            ),

           const SizedBox(height: 80),
            Container(
                constraints: const BoxConstraints(maxWidth: 300),
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 30,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side:const BorderSide(color: Color(0xff3D9A51), width: 1)
                          // Bordes cuadrados
                          ),
                    ),
                    onPressed: () {
                      signInwithGoogle();
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Iniciar Sesión con Google",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ))),

          const  SizedBox(height: 10),
         const   Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "o",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 20),
          const  Padding(
                padding: EdgeInsets.only(right: 300),
                child: Text("Correo", style: TextStyle(fontSize: 17))),

            Container(
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
         const   SizedBox(height: 20),
         const   Padding(
                padding: EdgeInsets.only(right: 300),
                child: Text(" password", style: TextStyle(fontSize: 17))),

           Container(
              width: 360,
              child: CustomTextFormField(
                hint: "password",
                onChanged: (value) => ref
                    .read(loginFormProvider.notifier)
                    .onPasswordChange(value),
                errorMessage: loginForm.isFormPosted
                    ? loginForm.password.errorMessage
                    : null,
              ),
            ),
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
                  // context.push("/additionalInfo");

                  ref.read(loginFormProvider.notifier).onFormSubmit(context);

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
              padding: const EdgeInsets.all(30.0),
            ),
           const SizedBox(height: 20),
            // Spacer(), // Spacer para llenar el espacio restante

            RichText(
              text: TextSpan(
                style:const TextStyle(color: Colors.black),
                children: [
                 const TextSpan(
                    text: '¿No tienes cuenta? ',
                  ),
                  TextSpan(
                    text: ' Regístrate',
                    style: const TextStyle(color: Colors.green), // Color verde
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Navigator.push(
                        context.push("/register");
                      },
                  ),
                ],
              ),
            ),
           const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
