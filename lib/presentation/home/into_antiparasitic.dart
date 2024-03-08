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
  const IntoAntiparasites({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nn = ref.watch(antiparasitesProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: () {
                ref.read(editantiparasitesProvider.notifier).update((state) => false);
                ref.read(pressAntiparasitesIntoProvider.notifier).update((state) => false);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              label: const Text("Atras", style: TextStyle(color: Colors.black)),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.share),
              label: const Text("Compartir"),
            ),
          ],
        ),
        Container(
          height: 100,
          width: screenWidth * 0.8,
          padding: const EdgeInsets.all(10.0),
          color: Colors.grey[200],
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (nn.brand == "Bravecto")
                    Image.asset('assets/Frame1000004651.png', width: screenWidth * 0.15),
                  if (nn.brand != "Bravecto")
                    Icon(Icons.image, size: screenWidth * 0.19),
                ],
              ),
              SizedBox(width: screenWidth * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  nn.type.isEmpty
                      ? const Text("No-Tipo")
                      : Text(
                          " Antiparasitario ${nn.type}",
                          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                  const SizedBox(height: 4),
                  nn.brand=="Seleccionar"
                      ? Text("No-Marca")
                      : Text(
                          "${nn.brand}",
                          style: TextStyle(fontSize: 16.0, color: Colors.red),
                        ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.only(right: screenWidth * 0.3),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(text: "Ultima dosis: ", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500)),
                TextSpan(text: "${nn.nextdose.day} ${getShortMonthName(nn.nextdose.month)} ${nn.nextdose.year}", style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.only(right: screenWidth * 0.3),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(text: "Proxima dosis: ", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500)),
                TextSpan(text: "${nn.nextdose.day} ${getShortMonthName(nn.nextdose.month)} ${nn.nextdose.year}", style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Spacer(),
        ElevatedButton(
          
          onPressed: () {
            context.push("/Addantiparasitic");
            ref.read(editantiparasitesProvider.notifier).update((state) => true);
            ref.read(infoeditantiparasitesProvider.notifier).update((state) => nn);
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.4, vertical: 20),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: Colors.green),
            ),
          ),
          child: Text(
            'Editar',
            style: TextStyle(color: Colors.black),
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
                .then((value) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Antiparasitario borrado!'))))
                .then((value) => ref.read(pressAntiparasitesIntoProvider.notifier).update((state) => false));
          },
          child: Text("Eliminar", style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
