import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:migu/widgets/shared/custom_text_form_field.dart';

class AdditionalInfoRegisterScreen extends StatelessWidget {
  const AdditionalInfoRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              SizedBox(
            height: 100,
          ),
           Image.asset("assets/Migu.png",width: 90,height: 60,),
         
         
            SizedBox(height: 90),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
           
                Expanded(
                  child: CustomTextFormField(
                    label: 'Nombre',
                    // Añade cualquier lógica necesaria para el campo de texto
                  ),
                ),
                SizedBox(width: 10),
               
                Expanded(
                  child: CustomTextFormField(
                    label: 'Apellido',
                    // Añade cualquier lógica necesaria para el campo de texto
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              label: 'Contraseña',
              // Añade cualquier lógica necesaria para el campo de texto
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
                context.push("/addpet");
                // Aquí puedes manejar la acción de continuar
              },
              child: Text(
                "Continuar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
           SizedBox(height: 20),
         Padding(
              padding: const EdgeInsets.all(30.0),
           child: RichText(
                
                textAlign: TextAlign.center,
                
                text: TextSpan(
                  
                  style: TextStyle(color: Colors.black),
                  children: 
           [
             TextSpan(text: "Al registrarte, aceptas nuestros"),
             
             TextSpan(text: " Términos y Condiciones,  Política de privacidad",style: TextStyle(color: Colors.green))
           ]
                )),
         ),
        
          Spacer(), // Spacer para llenar el espacio restante

        
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
                      context.push("/additionalInfo");
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
