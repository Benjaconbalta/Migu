import 'package:flutter/material.dart';
class VetView extends StatelessWidget {
  const VetView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:    AppBar(
            toolbarHeight: 80,
            backgroundColor: const Color(0xFF272B4E), // Color azul marino
            title: Row(
              children: [
               const Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Vets',
                      style: TextStyle(fontSize: 20.0, color: Colors.white,),
                    ),
                    
                  ),
                  
                ),
               const CircleAvatar(
                  backgroundImage: NetworkImage('https://w7.pngwing.com/pngs/711/768/png-transparent-white-and-brown-dog-illustration-emoji-emoticon-dog-smiley-whatsapp-emoji-carnivoran-dog-like-mammal-car-thumbnail.png'), // Imagen del perfil del usuario
                  radius: 18.0, // Radio para hacerlo redondo
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_drop_down_rounded, color: Colors.white),
                  onPressed: () {
                    // Acción al presionar el icono de fecha
                  },
                ),
              ],
            ),
         ),
        body: const Column(
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

