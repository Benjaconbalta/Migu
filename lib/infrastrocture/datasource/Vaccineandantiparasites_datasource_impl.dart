import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:migu/domain/datasource/vaccineandantiparasites_datasource.dart';
import 'package:migu/domain/entities/antiparasites.dart';
import 'package:migu/domain/entities/vaccine.dart';
import 'package:migu/infrastrocture/mappers/Antiparasites_mapper.dart';
import 'package:migu/infrastrocture/mappers/vaccine_mapper.dart';

final collection = FirebaseFirestore.instance;

class VaccineandantiparasitesDatasourceImpl extends Vaccineandantiparasites {
  @override
  Future<void> addAntiparasites(
      String type, String brand, DateTime date, DateTime nextdose) async {
    await collection
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Antiparasites")
        .add(
            {"type": type, "brand": brand, "date": date, "nextdose": nextdose});
  }

  @override
  Future<void> addVaccine(
      String type,
      String brand,
      String vaccination,
      DateTime date,
      DateTime nextdose,
      String photovaccinelabel,
      String photocertificate) async {
    await collection
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("vaccine")
        .add({
      "type": type,
      "brand": brand,
      "vaccination": vaccination,
      "date": date,
      "nextdose": nextdose,
      "photovaccinelabel": photovaccinelabel,
      "photocertificate": photocertificate
    });
  }

  @override
  Stream<List<Antiparasites>> getAntiparasites() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Antiparasites")
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        final dateTimestamp = data['date'] as Timestamp;
        final nextdoseTimestamp = data['nextdose'] as Timestamp;
        return Antiparasites(
          type: data['type'] ?? '',
          brand: data['brand'] ?? '',
          date: dateTimestamp.toDate(), // Convierte el Timestamp a DateTime
          nextdose:
              nextdoseTimestamp.toDate(), // Convierte el Timestamp a DateTime
          id: doc.id,
        );
      }).toList();
    }).map((list) => list.cast<Antiparasites>());
  }

  @override
  Stream<List<Antiparasites>> getAntiparasitesfilter() {
    final currentDate = DateTime.now();
    final twoMonthsFromNow =
        currentDate.add(Duration(days: 60)); // 60 días = 2 meses

    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Antiparasites")
        .where('nextdose',
            isGreaterThan:
                currentDate) // Filtra las próximas dosis que están en el futuro
        .where('nextdose',
            isLessThan:
                twoMonthsFromNow) // Filtra las próximas dosis que están dentro de los próximos 2 meses
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final dateTimestamp = data['date'] as Timestamp;
        final nextdoseTimestamp = data['nextdose'] as Timestamp;
        return Antiparasites(
          type: data['type'] ?? '',
          brand: data['brand'] ?? '',
          date: dateTimestamp.toDate(),
          nextdose: nextdoseTimestamp.toDate(),
          id: doc.id,
        );
      }).toList();
    }).map((list) => list.cast<Antiparasites>());
  }

  @override
  Stream<List<Vaccine>> getVaccine() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("vaccine")
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        final dateTimestamp = data['date'] as Timestamp;
        final nextdoseTimestamp = data['nextdose'] as Timestamp;
        return VaccineMapper.vaccineFirebaseToEntity(
            doc.data(), doc.id, dateTimestamp, nextdoseTimestamp);
      }).toList();
    }).map((list) => list.cast<Vaccine>());
  }

  @override
  Future<void> getInfopet() async {
  }
}
