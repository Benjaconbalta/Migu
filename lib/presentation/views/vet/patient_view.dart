import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:migu/widgets/shared/custom_text_form_field.dart';

class PatientView extends ConsumerWidget {
  const PatientView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FilledButton(
                  onPressed: () {}, child: const Text("Crear Paciente")),
              CustomTextFormField(),
              Text("Pacientes",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
              SizedBox(
                width: 500,
                height: 500,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      subtitle: Text("Tutor: benjamin molina",style: TextStyle(fontSize:15,fontWeight: FontWeight.w400 ),),
                        onTap: () {},
                        leading: Icon(Icons.pets,size: 40,),
                        title: Text("Evolet",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                        trailing: IconButton(onPressed: () {
                          
                        }, icon: Icon(Icons.arrow_forward_ios_sharp, )));
                  },
                ),
              )
            ],
          ),
        ));
  }
}
