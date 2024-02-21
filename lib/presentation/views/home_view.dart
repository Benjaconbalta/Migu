import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.abc),
              itemBuilder: (BuildContext context) {
                return {'Cambiar mascota', 'cerrar sesíon', 'Opción 3'}
                    .map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
              onSelected: (String choice) {
                // Aquí puedes definir las acciones que quieras realizar
                context.push("/Addantiparasitic");
              },
            ),
          ],
          toolbarHeight: 80,  
          backgroundColor: Color(0xFF272B4E), // Color azul marino
          title: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Carnet Veterinario',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://w7.pngwing.com/pngs/711/768/png-transparent-white-and-brown-dog-illustration-emoji-emoticon-dog-smiley-whatsapp-emoji-carnivoran-dog-like-mammal-car-thumbnail.png'), // Imagen del perfil del usuario
                radius: 18.0, // Radio para hacerlo redondo
              ),
              IconButton(
                icon: Icon(Icons.arrow_drop_down_rounded, color: Colors.white),
                onPressed: () {
                  context.go("/register");
                  // Acción al presionar el icono de fecha
                },
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.0), // Altura del TabBar
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                tabs: [
                  Tab(text: 'Vacunas'), // Pestaña 1
                  Tab(text: 'Desparasitación'), // Pestaña 2
                ],
                indicator: BoxDecoration(
                  color: Colors
                      .white, // Color del fondo de la pestaña seleccionada
                  borderRadius: BorderRadius.circular(3), // Borde redondeado
                ),

                labelColor:
                    Colors.black, // Color del texto de la pestaña seleccionada
                unselectedLabelColor: Colors
                    .grey, // Color del texto de la pestaña no seleccionada
                indicatorColor: Colors.white, // Color de la línea indicadora
                indicatorSize:
                    TabBarIndicatorSize.tab, // Tamaño de la línea indicadora
                indicatorWeight: 0.0, // Grosor de la línea indicadora
                isScrollable: false, // Desactiva el desplazamiento del TabBar
                // backgroundColor: Colors.blue[900], // Color del TabBar (opcional, puedes comentarlo para que coincida con el color del AppBar)
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Center(
                child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CustomWidget1(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "   Historial ",
                      style: TextStyle(fontSize: 20),
                    ),
                    TextButton(onPressed: () {
                                context.push("/Addantiparasitic");
                    }, child: Text("+Agregar"))
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.network(
                            "https://w7.pngwing.com/pngs/23/16/png-transparent-pharmacy-logo-pharmaceutical-drug-pasteur-blue-drug-pharmacist.png"),
                        title: Text("Rabguard"),
                        subtitle: Text("Antirrabica"),
                        trailing: Text("8 dic 2021"),
                      );
                    },
                  ),
                )
              ],
            )), // Contenido de la pestaña 1
            Center(child: CustomWidget1()), // Contenido de la pestaña 2
          ],
        ),
      ),
    );
  }
}

class CustomWidget1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 370,
      padding: EdgeInsets.all(30.0),
      color: Colors.grey[200], // Fondo gris claro
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Próxima dosis',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4), // Espacio entre los textos
              Text(
                'Antirrábica',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '10 Ene 2024',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4), // Espacio entre los textos
              Text(
                '8 días de atrazo',
                style: TextStyle(fontSize: 16.0, color: Colors.red),
              ),
            ],
          ),
          TextButton(
              onPressed: () {
                context.push("/addvaccine");
              },
              child: const Icon(Icons.add))
        ],
      ),
    );
  }
}

class Historial extends StatelessWidget {
  const Historial({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("Historial "),
            IconButton(onPressed: () {}, icon: Icon(Icons.abc))
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(
                    "data:image/png;base64,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"),
                title: Text("asd"),
                subtitle: Text("asd"),
              );
            },
          ),
        )
      ],
    );
  }
}
