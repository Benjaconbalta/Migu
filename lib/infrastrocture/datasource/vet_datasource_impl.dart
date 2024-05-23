import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:migu/domain/datasource/vet_datasource.dart';
import 'package:migu/domain/entities/Tutor.dart';
import 'package:migu/domain/entities/Vet.dart';
import 'package:migu/domain/entities/clinicalrecord.dart';

class VetDatasourceImpl extends VetDatasource {
  @override
  Stream<List<Tutor>> getAllTutors() {
    final collection = FirebaseFirestore.instance.collectionGroup("users");

    return collection.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        final uid = doc.id;
        final role = data["role"] ?? true;
        final name = data['name']//tomando nombremascota
            as String?; 
             final othername = data['namePet']//tomando nombremascota
            as String?;
            
            // Usar 'String?' para permitir valores nulos
        final urlImage = data['urlImage'] as String?;

        return Tutor(
          type: data['type'] ?? '',
          othername: othername??"",
          name: name ?? '', // Si 'name' es nulo, asignar una cadena vacía
          uid: uid,
          role: role ?? true,
          urlImage:
              urlImage ?? '', // Si 'urlImage' es nulo, asignar una cadena vacía
        );
      }).toList();
    }).map((list) => list.cast<Tutor>());
  }

  @override
  Future<void> setProfile(
      String name,
      String lastname,
      String correo,
      int phone,
      String service,
      String yearsofexperience,
      String speciality,
      Map<String, dynamic> atentions,
      Map<String, dynamic> choosespecies,
      String addres,
List<dynamic> paragraph,
      String image,
       List<dynamic> patients,
      ) {
    return FirebaseFirestore.instance
        .collection("vets")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "name": name,
      "lastname": lastname,
      "correo": correo,
      "phone": phone,
      "service": service,
      "yearsofexperience": yearsofexperience,
      "speciality": speciality,
      "atentions": atentions,
      "address": addres,
      "choosespecies": choosespecies,
      "offerparagraph": paragraph,
      "image":image,
      "patients":patients
    });
  }

  @override
  Stream<List<Map<String, dynamic>>> getProfile() {
    return FirebaseFirestore.instance
        .collection('vets')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((doc) {
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return [data]; // Devuelve una lista que contiene el mapa de datos
      } else {
        return []; // Retornar una lista vacía si no hay datos
      }
    });
  }

  @override
  Future<void> addclinicalRecord(
    String uid,
    String name,
    DateTime birthdate,
    String nutrition,
    int weight,
    String behavior,
    String treatmen,
    String observations,
  ) async {
    final collection = FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("clinicalRecord");
    print(uid);
    // Verificar si el registro ya existe
    final existingRecord = await collection.doc(uid).get();

    if (existingRecord.exists) {
      // Si el registro ya existe, actualiza los datos
      await collection.doc(uid).set({
        "uid": uid,
        "name": name,
        "birthdate": birthdate,
        "nutrition": nutrition,
        "weight": weight,
        "behavior": behavior,
        "treatment": treatmen,
        "observations": observations,
      });
    } else {
      // Si el registro no existe, crea uno nuevo
      await collection.doc(uid).set({
        "uid": uid,
        "name": name,
        "birthdate": birthdate,
        "nutrition": nutrition,
        "weight": weight,
        "behavior": behavior,
        "treatment": treatmen,
        "observations": observations,
      });
    }
  }

  @override
  Stream<List<ClinicalRecord>> getclinicalRecord(String uid) {
    final coleccion = FirebaseFirestore.instance.collection("users");

    return coleccion
        .doc(uid)
        .collection("clinicalRecord")
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((e) {
        final data = e.data();
        // Convertir el Timestamp a DateTime si es necesario
        DateTime? birthdate = data["birthdate"] is Timestamp
            ? (data["birthdate"] as Timestamp).toDate()
            : data["birthdate"];
        // Crear el objeto ClinicalRecord con los datos convertidos
        return ClinicalRecord(
            uid: data["uid"] ?? "",
            name: data["name"] ?? "",
            birthdate: birthdate!,
            nutrition: data["nutrition"] ?? "",
            weight: data["weight"],
            behavior: data["behavior"] ?? "",
            treatmen: data["treatment"] ?? "",
            observations: data["observations"] ?? "");
      }).toList();
    }).map((list) => list.cast<ClinicalRecord>());
  }
}
