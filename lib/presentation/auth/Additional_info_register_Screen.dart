import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:migu/presentation/providers/auth/register_form_provider.dart';
import 'package:migu/widgets/shared/custom_text_form_field.dart';

class AdditionalInfoRegisterScreen extends ConsumerWidget {
  const AdditionalInfoRegisterScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
   

       final registerForm = ref.watch(registerformProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
        
            children: [
                  SizedBox(
            height: 100,
          ),
           Image.asset("assets/Migu.png",width: 90,height: 60,),
         SizedBox(height: 90),

         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
   Flexible(
                   child: CustomTextFormField(
                     hint: 'Nombre',
                      onChanged: (value) =>
                 ref.read(registerformProvider.notifier).onNameChange(value),
             errorMessage: registerForm.isFormPosted
                 ? registerForm.name.errorMessage
                 : null,
                     // Añade cualquier lógica necesaria para el campo de texto
                   ),
                 ),
      SizedBox(width: 10),
                  Flexible(
                   child: CustomTextFormField(
                     hint: 'Apellido',
                      onChanged: (value) =>
                 ref.read(registerformProvider.notifier).onNameChange(value),
             errorMessage: registerForm.isFormPosted
                 ? registerForm.name.errorMessage
                 : null,
                     // Añade cualquier lógica necesaria para el campo de texto
                   ),
                 ),
              
            
               ],

             ),
           SizedBox(height: 20),
          CustomTextFormField(
               hint: 'Contraseña',
                 onChanged: (value) =>
                 ref.read(registerformProvider.notifier).onPasswordChange(value),
             errorMessage: registerForm.isFormPosted
                 ? registerForm.password.errorMessage
                 : null,

               // Añade cualquier lógica necesaria para el campo de texto
             ),
            const SizedBox(height: 20),

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

                 if(registerForm.name.isValid&& registerForm.password.isValid){
 // context.push("/addpet");
                   ref.read(registerformProvider.notifier).onFormSubmit(context);

                 }else{
                       ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                 content: Text('Rellena toda la informaciom'),
                 duration: Duration(seconds: 3), // Duración del Snackbar
               ),
             );
                 }
                 
//                 // Aquí puedes manejar la acción de continuar
               },
               child:const Text(
                 "Continuar",
                 style: TextStyle(color: Colors.white),
               ),
             ),
           ),

             const SizedBox(height: 20),
          Padding(
               padding: const EdgeInsets.all(30.0),
            child: RichText(
                
                 textAlign: TextAlign.center,
                
                 text:const TextSpan(
                  
                   style: TextStyle(color: Colors.black),
                   children: 
            [
              TextSpan(text: "Al registrarte, aceptas nuestros"),
             
              TextSpan(text: " Términos y Condiciones,  Política de privacidad",style: TextStyle(color: Colors.green)),
              
          
          
            ]
                 )),
          ),
SizedBox(height: 100,),
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
          // Spacer para llenar el espacio restante

            ]
          ),
        )
     ),
    );
  }
}


//      Column(
//           // mainAxisAlignment: MainAxisAlignment.center,
//           // crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//               SizedBox(
//             height: 100,
//           ),
//            Image.asset("assets/Migu.png",width: 90,height: 60,),
         
         
//             SizedBox(height: 90),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
           
//                 Flexible(
//                   child: CustomTextFormField(
//                     hint: 'Nombre',
//                      onChanged: (value) =>
//                 ref.read(registerformProvider.notifier).onNameChange(value),
//             errorMessage: registerForm.isFormPosted
//                 ? registerForm.name.errorMessage
//                 : null,
//                     // Añade cualquier lógica necesaria para el campo de texto
//                   ),
//                 ),
//                 SizedBox(width: 10),
               
//                 Flexible(
//                   child: CustomTextFormField(
//                     hint: 'Apellido',
//                      onChanged: (value) =>
//                 ref.read(registerformProvider.notifier).onNameChange(value),
//             errorMessage: registerForm.isFormPosted
//                 ? registerForm.name.errorMessage
//                 : null,
//                     // Añade cualquier lógica necesaria para el campo de texto
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             CustomTextFormField(
//               hint: 'Contraseña',
//                 onChanged: (value) =>
//                 ref.read(registerformProvider.notifier).onPasswordChange(value),
//             errorMessage: registerForm.isFormPosted
//                 ? registerForm.password.errorMessage
//                 : null,

//               // Añade cualquier lógica necesaria para el campo de texto
//             ),
//            const SizedBox(height: 20),
//              Container(
//             width: 300,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10), // Bordes cuadrados
//                   ),
//                   backgroundColor: Color(0xFF3D9A51),
//                   padding: EdgeInsets.symmetric(vertical: 20)),
//               onPressed: () {

//                 if(registerForm.name.isValid&& registerForm.password.isValid){
// // context.push("/addpet");
//                   ref.read(registerformProvider.notifier).onFormSubmit(context);

//                 }else{
//                       ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('Rellena toda la informaciom'),
//                 duration: Duration(seconds: 3), // Duración del Snackbar
//               ),
//             );
//                 }
                 
//                 // Aquí puedes manejar la acción de continuar
//               },
//               child:const Text(
//                 "Continuar",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//          Padding(
//               padding: const EdgeInsets.all(30.0),
//            child: RichText(
                
//                 textAlign: TextAlign.center,
                
//                 text:const TextSpan(
                  
//                   style: TextStyle(color: Colors.black),
//                   children: 
//            [
//              TextSpan(text: "Al registrarte, aceptas nuestros"),
             
//              TextSpan(text: " Términos y Condiciones,  Política de privacidad",style: TextStyle(color: Colors.green))
//            ]
//                 )),
//          ),
        
//           Spacer(), // Spacer para llenar el espacio restante

        
//           RichText(
//             text: TextSpan(
//               style: TextStyle(color: Colors.black),
//               children: [
//                 TextSpan(
//                   text: '¿Ya tienes una cuenta? ',
//                 ),
//                 TextSpan(
//                   text: 'Inicia sesión',
//                   style: TextStyle(color: Colors.green), // Color verde
//                   recognizer: TapGestureRecognizer()
//                     ..onTap = () {
//                       // Navigator.push(
//                       context.push("/login");
//                     },
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 20),
//           ],
//         ),
    