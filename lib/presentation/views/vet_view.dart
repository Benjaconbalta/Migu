import 'package:flutter/material.dart';
class VetView extends StatelessWidget {
  const VetView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar:    AppBar(
            toolbarHeight: 80,
            backgroundColor: Color(0xFF272B4E), // Color azul marino
            title: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Vets',
                      style: TextStyle(fontSize: 20.0, color: Colors.white,),
                    ),
                    
                  ),
                  
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage('https://w7.pngwing.com/pngs/711/768/png-transparent-white-and-brown-dog-illustration-emoji-emoticon-dog-smiley-whatsapp-emoji-carnivoran-dog-like-mammal-car-thumbnail.png'), // Imagen del perfil del usuario
                  radius: 18.0, // Radio para hacerlo redondo
                ),
                IconButton(
                  icon: Icon(Icons.arrow_drop_down_rounded, color: Colors.white),
                  onPressed: () {
                    // Acción al presionar el icono de fecha
                  },
                ),
              ],
            ),
         ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("Muy Pronto"),
            )
          ],
        ),
      ),
    );
  }
}

