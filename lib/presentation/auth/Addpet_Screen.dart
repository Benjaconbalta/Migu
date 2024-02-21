import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_forest/amazingneoicons.dart';
import 'package:icon_forest/bytesize.dart';
import 'package:icon_forest/gala_icons.dart';
import 'package:icon_forest/icon_forest.dart';
import 'package:migu/widgets/shared/custom_text_form_field.dart';
import 'package:icon_forest/kicons_emoji.dart';
class AddPet extends StatefulWidget {
  const AddPet({super.key});

  @override
  State<AddPet> createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {
   late List<bool> _selections;
    @override
  void initState() {
    super.initState();
    _selections = List.generate(3, (index) => false); // Inicializar selecciones
  }
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Agrega tu mascota',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
         
         Spacer(),
            GestureDetector(
              onTap: () {
                // Implementa la lógica para subir la foto
              },
               child: Container(
                width: 150,
        height: 150,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.green,
            width: 1,
            
            
          ),
        ),
                 child: Stack(
                           alignment: Alignment.center,
                           children: [
                           
                             Text(
                               'Subir Foto',
                               style: TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                               ),
                             ),
                           ],
                         ),
               ),
      
    
            ),
            SizedBox(height: 20),
              Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("Nombre", style: TextStyle(fontSize: 17))),

            CustomTextFormField(
              label: 'Nombre de la Mascota',
              // Añade cualquier lógica necesaria para el campo de texto
            ),


      
            SizedBox(height: 20),
                  Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("Especie", style: TextStyle(fontSize: 17))),


               ToggleButtons(
                borderWidth: 0,
                borderColor: Colors.white,
                borderRadius: BorderRadius.circular(20),
          children: [
            SquareButton(
              icon:FontAwesomeIcons.dog,
              text: 'Perro',
              onPressed: () {
                 setState(() {
                   _selections[0] = !_selections[0];
                 });
              },
              selected: _selections[0],
            ),
            SquareButton(
              icon:FontAwesomeIcons.cat,
              text: 'Gato',
              onPressed: () {
                 setState(() {
                   _selections[1] = !_selections[1];
                 });
              },
              selected: _selections[1],
            ),
            SquareButton(
       icon:FontAwesomeIcons.otter,
              text: 'Otro',
              onPressed: () {
                 setState(() {
                   _selections[2] = !_selections[2];
                 });
              },
              selected: _selections[2],
            ),
          ],
          isSelected: _selections,
          onPressed: (int index) {
            // setState(() {
            //   _selections[index] = !_selections[index];
            // });
          },
        
          
    ),
                  Spacer(),
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
                context.go("/home/0");
                // Aquí puedes manejar la acción de continuar
              },
              child: Text(
                "Continuar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          ],
        ),
      ),
    
    );
  }
}
class SquareButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final bool selected;

  const SquareButton({
    required this.icon,
    required this.text,
    required this.onPressed,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? Color(0xffD8EBDC) : Colors.white, // Color de fondo del botón
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Bordes redondeados
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30,),
            FaIcon(
             icon,
             size: 40,
             color: Colors.black, // Color del icono
           ),
          
          SizedBox(height: 10), // Espaciado entre el icono y el texto
          Text(
            text,
            style: TextStyle(
              color: Colors.black, // Color del texto
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}


class SquareButton2 extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final bool selected;

  const SquareButton2({
    required this.icon,
    required this.text,
    required this.onPressed,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? Color(0xffD8EBDC) : Colors.white, // Color de fondo del botón
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Bordes redondeados
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
       

          Text(
            text,
            style: TextStyle(
              color: Colors.black, // Color del texto
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

