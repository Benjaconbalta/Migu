import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:migu/presentation/home/addvaccine_Screen.dart';
import 'package:migu/widgets/shared/custom_text_form_field.dart';

final atentionSwitchProvider = StateProvider<bool>((ref) {
  return false;
});
final atention2SwitchProvider = StateProvider<bool>((ref) {
  return false;
});

final typeSwitchProvider = StateProvider<bool>((ref) {
  return false;
});
final typ1SwitchProvider = StateProvider<bool>((ref) {
  return false;
});
final type2atention2SwitchProvider = StateProvider<bool>((ref) {
  return false;
});

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final atentionswitch = ref.watch(atentionSwitchProvider);
    final atention2switch = ref.watch(atention2SwitchProvider);
final typevalueSwitchProvider=ref.watch(typeSwitchProvider);
final typegatoSwitchProvider=ref.watch(typ1SwitchProvider);
final typeExoticos=ref.watch(type2atention2SwitchProvider);

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
                  const Text(
                    "Editar Perfil",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  const SizedBox(
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
                            keyboardType: TextInputType.number,
                            onChanged: (p0) {
                              //validacion debe emepzar con un nueve y debe ser nueve digitos
                              //de lo contrario de numero invalido
                            },
                            label: "Beatriz",
                            hint: "+56",
                          ))
                    ],
                  ),
                  MyDropdown(
                    defaultValue: "seleccionar",
                    label: "que servicios ofreces",
                    options: const [
                      "seleccionar",
                      "Atencion Domicilio",
                      "veterinaria",
                    ],
                    onChanged: (marc) {
                      // ref
                      //     .read(marcaAntiparasitesProvider.notifier)
                      //     .update((state) => marc!);
                    },
                  ),
                  MyDropdown(
                    defaultValue: "seleccionar",
                    label: "Cuantos años de experiencia",
                    options: const [
                      "seleccionar",
                      "1 año",
                      "2 años",
                      "3 años",
                      "4 años",
                      "5 años"
                    ],
                    onChanged: (marc) {
                      // ref
                      //     .read(marcaAntiparasitesProvider.notifier)
                      //     .update((state) => marc!);
                    },
                  ),
                  MyDropdown(
                    defaultValue: "Seleccionar",
                    label: "que Expecialidad",
                    options: const [
                      "Seleccionar",
                      "Cardiologia",
                      "Dermatología",
                      "Cirugía Dental",
                      "Ecografía",
                      "Endocrinología",
                      "Fisiatría",
                      "Gastroenterología",
                      "Medicina Felina",
                      "Veterinaria Exótica",
                      "Medicina Respiratoria",
                      "Nefro-urología",
                      "Neurología",
                      "Oncología",
                      "Radiología",
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
              SwitchDemo(
                atentionswitch: atentionswitch,
                provideratentionSwitchProvider: atentionSwitchProvider,
                text: "Online",
              ),
              SwitchDemo(
                atentionswitch: atention2switch,
                provideratentionSwitchProvider: atention2SwitchProvider,
                text: "A domicilio",
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Direccion",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
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
              SizedBox(
                height: 20,
              ),
              const Text(
                "Especies*",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
              ),
              Container(
                height: 30,
                color: Colors.grey[200],
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Icon(Icons.help),
                      Text("Debes añadir al menos uno")
                    ],
                  ),
                ),
              ),
               SwitchDemo(
                  atentionswitch: typevalueSwitchProvider,
                  provideratentionSwitchProvider:typeSwitchProvider ,
                 text: "perros",
               ),
               SwitchDemo(
                  atentionswitch:typegatoSwitchProvider ,
                  provideratentionSwitchProvider: typ1SwitchProvider,
                  text: "Gatos",
               ),
               SwitchDemo(
                 atentionswitch:typeExoticos ,
                  provideratentionSwitchProvider:type2atention2SwitchProvider ,
                 text: "Exoticos",
               ),
              SizedBox(
                height: 20,
              ),
              const Text(
                "Ofrece*",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
              ),
              Container(
                height: 30,
                color: Colors.grey[200],
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Icon(Icons.help),
                      Text("Debes añadir al menos uno")
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "¿Que servicios ofreces?",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
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
                      FilledButton.tonal(
                          style: FilledButton.styleFrom(
                              backgroundColor: Colors.white),
                          onPressed: () {},
                          child: Text(
                            "Cancelar",
                            style: TextStyle(color: Colors.red),
                          )),
                      SizedBox(
                        width: 30,
                      ),
                      FilledButton.tonal(
                          style: FilledButton.styleFrom(
                              backgroundColor: Color(0xff3D9A51)),
                          onPressed: () {},
                          child: Text(
                            "Guardar",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class SwitchDemo extends ConsumerStatefulWidget {
  final String text;
  final bool atentionswitch;
  StateProvider<bool> provideratentionSwitchProvider;

  SwitchDemo(
      {super.key,
      required this.text,
      required this.atentionswitch,
      required this.provideratentionSwitchProvider});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SwitchDemoState();
}

class _SwitchDemoState extends ConsumerState<SwitchDemo> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: widget.atentionswitch,
          onChanged: (value) {
            ref
                .read(widget.provideratentionSwitchProvider.notifier)
                .update((state) => !widget.atentionswitch);
          },
        ),
        Text(
          widget.text,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ],
    );
  }
}

//nombre
//apellido
//correo
//telefono
//que servicio ofreces
//cuantos años de experiencia
//que expecialidad
//atencion
//direcion
//especies
//servicio que ofreces
