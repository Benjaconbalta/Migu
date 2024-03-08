import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:migu/domain/entities/antiparasites.dart';
import 'package:migu/presentation/providers/Vaccineandantiparasites/vaccineandAntiparasites_provider.dart';
import 'package:migu/presentation/views/home_view.dart';


final editantiparasitesProvider = StateProvider<bool>((ref) {
  return false;
});

final infoeditantiparasitesProvider = StateProvider<Antiparasites>((ref) {
  return Antiparasites(
      type: "",
      brand: "",
      date: DateTime.now(),
      nextdose: DateTime.now(),
    
      id: "");
});


class IntoAntiparasites extends ConsumerWidget {
  const IntoAntiparasites({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nn = ref.watch(antiparasitesProvider);
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
                onPressed: () {
                    ref.read(editantiparasitesProvider.notifier).update((state) => false);
                    ref
                        .read(pressAntiparasitesIntoProvider.notifier)
                        .update((state) => false);
                },
                  icon: Icon(Icons.arrow_back,color: Colors.black,),
                label: Text("Atras",style: TextStyle(color: Colors.black),)),
            TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.share),
                label: Text("Compartir")),
          ],
        ),
        Container(
          height: 100,
          width: 270,
          padding: EdgeInsets.all(10.0),
          color: Colors.grey[200], // Fondo gris claro
          child: Row(
            
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (nn.brand == "Bravecto")
                    Image.asset(width: 70, 'assets/Frame1000004649.png'),
 if(nn.brand!="Bravecto")
  Icon(Icons.image,size: 70,)

                  // Image.network()
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${nn.type}",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4), // Espacio entre los textos
                  Text(
                    "${nn.brand}",
                    style: TextStyle(fontSize: 16.0, color: Colors.red),
                  ),
                ],
              ),
       
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
       
        Padding(
            padding: EdgeInsets.only(right: 160),
            child: RichText(text: TextSpan(children: [
              TextSpan(text: "Ultima dosis: ",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500)),
              TextSpan(text: "${nn.date.year}",style: TextStyle(color: Colors.black))
              
            ])) ),
        SizedBox(
          height: 20,
        ),
        Padding(
            padding: EdgeInsets.only(right: 130),
            child: RichText(text: TextSpan(children: [
              TextSpan(text: "Proxima dosis: ",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500)),
              TextSpan(text: "${nn.nextdose.day} ${getShortMonthName(nn.nextdose.month)} ${nn.nextdose.year}",style: TextStyle(color: Colors.black))
              
            ]))),
        SizedBox(
          height: 20,
        ),
        Spacer(
          flex: 1,
        ),

               ElevatedButton(
  onPressed: () {
     context.push("/Addantiparasitic");
            ref.read(editantiparasitesProvider.notifier).update((state) => true);
            ref.read(infoeditantiparasitesProvider.notifier).update((state) => nn);
    // Aquí puedes añadir la función que se ejecutará cuando se presione el botón
  },
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 160, vertical: 20), // Padding del botón
backgroundColor: Colors.white,// Color de fondo blanco
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15), // Bordes redondeados
      side: BorderSide(color: Colors.green), // Bordes de color verde
    ),
    
  ),
  child: Text(
    'Editar',
    style: TextStyle(color: Colors.black), // Color del texto
  ),
),

        TextButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("Antiparasites")
                  .doc(nn.id)
                  .delete()
                  .then((value) => {
                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Antiparasitario borrado!'),
                  ))
                  })
                  .then((value) => {
                    ref.read(pressAntiparasitesIntoProvider.notifier).update((state) => false)
                  });
            },
            child: Text("Eliminar",   style: TextStyle(color: Colors.red),))
      ],
    );
  }
}
