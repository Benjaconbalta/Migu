import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
                 const SizedBox(
            height: 100,
          ),
           Image.asset("assets/Migu.png",width: 90,height: 60,),
           const SizedBox(height: 90),
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
                   ),
                 ),
         const  SizedBox(width: 10),
                  Flexible(
                   child: CustomTextFormField(
                     hint: 'Apellido',
                      onChanged: (value) =>
                 ref.read(registerformProvider.notifier).onNameChange(value),
             errorMessage: registerForm.isFormPosted
                 ? registerForm.name.errorMessage
                 : null,
                   ),
                 ),         
               ],

             ),
         const  SizedBox(height: 20),
          CustomTextFormField(
               hint: 'Contraseña',
                 onChanged: (value) =>
                 ref.read(registerformProvider.notifier).onPasswordChange(value),
             errorMessage: registerForm.isFormPosted
                 ? registerForm.password.errorMessage
                 : null,
             ),
            const SizedBox(height: 20),

             Container(
             width: 300,
             child: ElevatedButton(
               style: ElevatedButton.styleFrom(
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10), // Bordes cuadrados
                   ),
                   backgroundColor: const Color(0xFF3D9A51),
                   padding: const EdgeInsets.symmetric(vertical: 20)),
               onPressed: () {
                 if(registerForm.name.isValid&& registerForm.password.isValid){
                   ref.read(registerformProvider.notifier).onFormSubmit(context);
                 }else{
                       ScaffoldMessenger.of(context).showSnackBar(
             const  SnackBar(
                 content: Text('Rellena toda la informaciom'),
                 duration: Duration(seconds: 3), // Duración del Snackbar
               ),
             );
                 }
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
          const SizedBox(height: 100,),
           RichText(
             text: TextSpan(
               style: const TextStyle(color: Colors.black),
               children: [
                
                const TextSpan(
                   text: '¿Ya tienes una cuenta? ',
                 ),
                 TextSpan(
                   text: 'Inicia sesión',
                   style:const TextStyle(color: Colors.green), // Color verde
                   recognizer: TapGestureRecognizer()
                     ..onTap = () {
                       // Navigator.push(
                       context.push("/login");
                     },
                 ),
               ],
             ),
           ),
          const SizedBox(height: 20),
            ]
          ),
        )
     ),
    );
  }
}