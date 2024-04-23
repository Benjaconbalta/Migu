import 'package:flutter/material.dart';
import 'package:migu/widgets/shared/custom_text_form_field.dart';

class EditClinicalRecordScreen extends StatelessWidget {
  const EditClinicalRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
            
              children: [
                 Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nombre mascota",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                              width: 340,
                              height: 50,
                              child: CustomTextFormField(
                                label: "Beatriz",
                                hint: "Nombre",
                              ))
                        ],
                      ),
          SizedBox(height: 30,),
                        Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nutricion",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        SizedBox(
                            width: 340,
                            height: 50,
                            child: CustomTextFormField(
                              label: "Beatriz",
                              hint: "Nutricion",
                            ))
                      ],
                    ),
          
          SizedBox(height: 30,),
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Peso",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        SizedBox(
                            width: 340,
                            height: 50,
                            child: CustomTextFormField(
                              label: "Beatriz",
                              hint: "40kg",
                            ))
                      ],
                    ),
                    SizedBox(height: 30,),
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Conducta",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        SizedBox(
                            width: 340,
                            height: 50,
                            child: CustomTextFormField(
                              label: "Beatriz",
                              hint: "Conducta",
                            ))
                      ],
                    ),
                    SizedBox(height: 30,),
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tratamiento",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        SizedBox(
                            width: 340,
                            height: 50,
                            child: CustomTextFormField(
                              label: "Beatriz",
                              hint: "Está tomando Apoquel 5,4mg desde hace 1 año y medio",
                            ))
                      ],
                    ),
                    SizedBox(height: 30,),
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Observaciones",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        SizedBox(
                            width: 340,
                            height: 50,
                            child: CustomTextFormField(
                              label: "Beatriz",
                              hint: "Sufre de dermatitis atópica",
                            ))
                      ],
                    ),
                  
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton.tonal( style: FilledButton.styleFrom(backgroundColor: Colors.white), onPressed: (){}, child: Text("Cancelar",style: TextStyle(color: Colors.red),)),
                  SizedBox(width: 30,),
                   FilledButton.tonal( style: FilledButton.styleFrom(backgroundColor: Color(0xff3D9A51)), onPressed: (){}, child: Text("Guardar",style: TextStyle(color: Colors.white),))
                ],
              ),
              SizedBox(height: 100,)
          
              ],
            ),
          ),
        ),
    );
  }
}