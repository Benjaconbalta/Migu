import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:migu/presentation/providers/auth/register_form_provider.dart';
import 'package:migu/widgets/shared/custom_text_form_field.dart';

final showerrorProvider = StateProvider<bool>((ref) {
  return false;
});

 void signInwithGoogle() async {
    GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleauth = await googleuser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleauth?.accessToken,
      idToken: googleauth?.idToken,
    );
    UserCredential userCretendial =
        await FirebaseAuth.instance.signInWithCredential(credential);
    // print(userCretendial.user?.displayName);
  }
/// Pantalla de registro de usuarios.
class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerForm = ref.watch(registerformProvider);
    final show = ref.watch(showerrorProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Image.asset(
              "assets/Migu.png",
              width: 90,
              height: 60,
            ),

            SizedBox(height: 100),
            Container(
                constraints: BoxConstraints(maxWidth: 300),
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 60,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Color(0xff3D9A51), width: 1)
                          // Bordes cuadrados
                          ),
                    ),
                    onPressed: () {
                      signInwithGoogle();
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.black,
                    ),
                    label: Text(
                      "Continuar con google",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ))),

            SizedBox(height: 20),
            Padding(
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
                    padding: const EdgeInsets.symmetric(horizontal: 8),
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

            SizedBox(height: 20),
            Padding(
                padding: EdgeInsets.only(right: 300),
                child: Text("Correo", style: TextStyle(fontSize: 17))),

            Container(
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
            SizedBox(height: 20),

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
                  if (registerForm.email.isValid) {
                    context.push("/additionalInfo");
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Ingresa un email valido'),
                        duration: Duration(seconds: 3), // Duración del Snackbar
                      ),
                    );
                  }

                  // ref.read(registerformProvider.notifier).onFormSubmit(context);

                  // Aquí puedes manejar la acción de continuar
                },
                child: Text(
                  "Continuar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(text: "Al registrarte, aceptas nuestros"),
                      TextSpan(
                          text:
                              " Términos y Condiciones,  Política de privacidad",
                          style: TextStyle(color: Colors.green))
                    ]
                    //  Text(
                    //                 softWrap: true,
                    //                 "Al registrarte, aceptas nuestros Términos y Condiciones, y la Política de privacidad",
                    //                 style: TextStyle(),
                    //                 textAlign: TextAlign.center,
                    //               ),
                    ),
              ),
            ),
            SizedBox(height: 80),
            // Spacer(), // Spacer para llenar el espacio restante

            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: '¿Ya tienes una cuenta? ',
                  ),
                  TextSpan(
                    text: 'Inicia sesión',
                    style: TextStyle(color: Colors.green), // Color verde
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Navigator.push(
                        context.push("/login");
                      },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: TextStyle(fontSize: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
