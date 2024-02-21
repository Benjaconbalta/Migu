import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:migu/presentation/auth/Addpet_Screen.dart';
import 'package:migu/presentation/home/addvaccine_Screen.dart';

class Addantiparasitic extends StatefulWidget {
  const Addantiparasitic({super.key});

  @override
  State<Addantiparasitic> createState() => _AddantiparasiticState();
}

class _AddantiparasiticState extends State<Addantiparasitic> {
     late List<bool> _selections;
    @override
  void initState() {
    super.initState();
    _selections = List.generate(2, (index) => false); // Inicializar selecciones
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Antiparasitario  "),
      ),
      body: Padding(
  padding: const EdgeInsets.symmetric(horizontal: 30), 
        child: Column(
         
        
          children: [
          Align( alignment: Alignment.centerLeft, child: Text("Tipo*",style: TextStyle(fontSize:18,color: Colors.black ),)),
          ToggleButtons(
              
            
                  borderWidth: 0,
                  borderColor: Colors.white,
                  borderRadius: BorderRadius.circular(20),
            children: [
              SquareButton2(
                icon:FontAwesomeIcons.dog,
                text: 'Interna',
                onPressed: () {
                    setState(() {
                      _selections[0] = !_selections[0];
                    });
                },
                selected: _selections[0],
              ),
             
       
              SquareButton2(
                icon:FontAwesomeIcons.cat,
                text: 'Externa',
                onPressed: () {
                    setState(() {
                      _selections[1] = !_selections[1];
                    });
                },
                selected: _selections[1],
              ),
             
            ],
            isSelected: _selections,
            onPressed: (int index) {
              // setState(() {
              //   _selections[index] = !_selections[index];
              // });
            },
          
            
            ),
        
        
              MultiSelectDropdown(nameInput: "Marca",),
                         SizedBox(height: 30,),
                         Align( alignment: Alignment.centerLeft, child: Text("Fecha de vacunacion*",style: TextStyle(fontSize:18,color: Colors.black ),)),
                    DatePicker(),
                             SizedBox(height: 20,),
                                  Align( alignment: Alignment.centerLeft, child: Text("Proxima dosis",style: TextStyle(fontSize:18,color: Colors.black ),)),
                      DatePicker(),
                       SizedBox(height: 220,),
        
                        ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Bordes cuadrados
                    ),
                    backgroundColor: Color(0xFF3D9A51),
                    padding: EdgeInsets.symmetric(horizontal: 130,vertical: 20)),
                onPressed: () {
                  // context.go("/home/0");
                  // Aquí puedes manejar la acción de continuar
                },
                child: Text(
                  "Agregar",
                  style: TextStyle(color: Colors.white,),
                ),
              ),
          ],
        ),
      ),

    );
  }
}