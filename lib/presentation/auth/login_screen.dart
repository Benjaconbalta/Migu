import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:migu/widgets/shared/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
          ),
          Text(
            "MIGU",
            style: TextStyle(
                color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 100),
          Container(
              constraints: BoxConstraints(maxWidth: 300),
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 30,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.green, width: 1)
                        // Bordes cuadrados
                        ),
                  ),
                  onPressed: () {},
                  icon: FaIcon(FontAwesomeIcons.google,color: Colors.black,),
                  label: Text(
                    "Iniciar Sesión con Google",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ))),

          SizedBox(height: 10),
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
              label: "ejemplo@gmail.com",
              onChanged: (value) {
                // Aquí puedes manejar el cambio en el campo de texto
              },
            ),
          ),
          SizedBox(height: 20),
           Container(
            width: 360,
            child: CustomTextFormField(
              label: "password",
              onChanged: (value) {
                // Aquí puedes manejar el cambio en el campo de texto
              },
            ),
          ),
           SizedBox(height: 20),
          Container(
            width: 300,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Bordes cuadrados
                  ),
                  backgroundColor: Color(0xFF3D9A51),
                  padding: EdgeInsets.symmetric(vertical: 20)),
              onPressed: () {
                context.push("/additionalInfo");
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
          
          ),
          SizedBox(height: 80),
          // Spacer(), // Spacer para llenar el espacio restante

          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: '¿No tienes cuenta? ',
                ),
                TextSpan(
                  text: ' Regístrate',
                  style: TextStyle(color: Colors.green), // Color verde
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Navigator.push(
                      context.push("/register");
                    },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
     
    
  }
}