import 'package:flutter/material.dart';
import 'package:migu/presentation/home/addvaccine_Screen.dart';
import 'package:migu/widgets/shared/custom_text_form_field.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Editar Perfil",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.dock_outlined,
                        size: 40,
                      ),
                      Text(
                        "+Añade una foto",
                        style: TextStyle(color: Color(0xff3D9A51)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nombre",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                              width: 140,
                              height: 50,
                              child: CustomTextFormField(
                                label: "Beatriz",
                                hint: "Beatriz",
                              ))
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Apellido",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                              width: 140,
                              height: 50,
                              child: CustomTextFormField(
                                label: "Beatriz",
                                hint: "Gonzales",
                              ))
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Correo",
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
                            hint: "bea.vet@gmail.com",
                          ))
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Telefono",
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
                            hint: "+56",
                          ))
                    ],
                  ),
                  MyDropdown(
                    defaultValue: "Bravecto",
                    label: "que servicios ofreces",
                    options: [
                      "Bravecto",
                      "NEXGARD",
                      "ADVOCATE",
                      "CEVA",
                      "FRONTLINE SPRAY",
                      "Ehlinger",
                      "Zoetis",
                      "NEXGARD SPECTRA",
                      "Skouts Honor",
                      "TICKELESS",
                      "cleanvet",
                      "frontline plus",
                      "Bayer/Elanco",
                      "drag pharma",
                      "veterquimica",
                      "virbac",
                      "Otro",
                    ],
                    onChanged: (marc) {
                      // ref
                      //     .read(marcaAntiparasitesProvider.notifier)
                      //     .update((state) => marc!);
                    },
                  ),
                  MyDropdown(
                    defaultValue: "Bravecto",
                    label: "Cuantos años de experiencia",
                    options: [
                      "Bravecto",
                      "NEXGARD",
                      "ADVOCATE",
                      "CEVA",
                      "FRONTLINE SPRAY",
                      "Ehlinger",
                      "Zoetis",
                      "NEXGARD SPECTRA",
                      "Skouts Honor",
                      "TICKELESS",
                      "cleanvet",
                      "frontline plus",
                      "Bayer/Elanco",
                      "drag pharma",
                      "veterquimica",
                      "virbac",
                      "Otro",
                    ],
                    onChanged: (marc) {
                      // ref
                      //     .read(marcaAntiparasitesProvider.notifier)
                      //     .update((state) => marc!);
                    },
                  ),
                  MyDropdown(
                    defaultValue: "Bravecto",
                    label: "que Expecialidad",
                    options: const [
                      "Bravecto",
                      "NEXGARD",
                      "ADVOCATE",
                      "CEVA",
                      "FRONTLINE SPRAY",
                      "Ehlinger",
                      "Zoetis",
                      "NEXGARD SPECTRA",
                      "Skouts Honor",
                      "TICKELESS",
                      "cleanvet",
                      "frontline plus",
                      "Bayer/Elanco",
                      "drag pharma",
                      "veterquimica",
                      "virbac",
                      "Otro",
                    ],
                    onChanged: (marc) {
                      // ref
                      //     .read(marcaAntiparasitesProvider.notifier)
                      //     .update((state) => marc!);
                    },
                  ),
                ],
              ),
              const Text(
                "Atencion*",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
              ),
              Container(
                height: 30,
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Icon(Icons.help),
                      Text("Debes añadir al menos uno")
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SwitchDemo(text: "Online",),
              SwitchDemo(text: "A domicilio",),
               Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Direccion",
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
                            hint: "+56",
                          ))
                    ],
                  ),
                  SizedBox(height: 20,),
                const Text(
                "Especies*",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
              ),
               Container(
                height: 30,
                color: Colors.grey[200],
                child: const Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Icon(Icons.help),
                      Text("Debes añadir al menos uno")
                    ],
                  ),
                ),
              ),
                SwitchDemo(text: "perros",),
              SwitchDemo(text: "Gatos",),
              SwitchDemo(text: "Exoticos",),
                   SizedBox(height: 20,),
              const Text(
                "Ofrece*",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
              ),
               Container(
                height: 30,
                color: Colors.grey[200],
                child: const Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Icon(Icons.help),
                      Text("Debes añadir al menos uno")
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "¿Que servicios ofreces?",
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
                            hint: "+56",
                          )),
                          Text("10 máx. Usa una coma (,) para separar")
                    ],
                  ),
                   Container(
            width: 400,
            height: 100,
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton.tonal( style: FilledButton.styleFrom(backgroundColor: Colors.white), onPressed: (){}, child: Text("Cancelar",style: TextStyle(color: Colors.red),)),
                SizedBox(width: 30,),
                 FilledButton.tonal( style: FilledButton.styleFrom(backgroundColor: Color(0xff3D9A51)), onPressed: (){}, child: Text("Guardar",style: TextStyle(color: Colors.white),))
              ],
            )
          )
            ],
          ),
        ),
      ),
    );
  }
}

class SwitchDemo extends StatefulWidget {
  final String text;

  const SwitchDemo({super.key, required this.text});
  @override
  _SwitchDemoState createState() => _SwitchDemoState();
}

class _SwitchDemoState extends State<SwitchDemo> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: _switchValue,
          onChanged: (value) {
            setState(() {
              _switchValue = value;
            });
          },
        ),
        Text(widget.text,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
      ],
    );
  }
}
