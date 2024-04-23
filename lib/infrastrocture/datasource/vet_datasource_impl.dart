import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:migu/domain/datasource/vet_datasource.dart';
import 'package:migu/domain/entities/Tutor.dart';

class VetDatasourceImpl extends VetDatasource {
@override
Stream<List<Tutor>> getAllTutors() {
  final collection = FirebaseFirestore.instance.collectionGroup("users");

  return collection.snapshots().map((querySnapshot) {
    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      final uid = doc.id;
      final name = data['name'] as String?; // Usar 'String?' para permitir valores nulos
      final urlImage = data['urlImage'] as String?;

      return Tutor(
        type: data['type'] ?? '',
        namePet: name ?? '', // Si 'name' es nulo, asignar una cadena vacía
        uid: uid,
        urlImage: urlImage ?? '', // Si 'urlImage' es nulo, asignar una cadena vacía
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
      int yearsofexperience,
      String speciality,
      String choseAtencion,
      String address,
      String choosespecies,
      String offerparagraph) {
    // TODO: implement setProfile
    throw UnimplementedError();
  }
}
