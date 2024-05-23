import 'package:migu/domain/entities/Vet.dart';
import 'package:migu/domain/entities/antiparasites.dart';
import 'package:migu/domain/entities/vaccine.dart';
abstract class Vaccineandantiparasitesrepository {
 Future<void> addVaccine(
      String type,
      String brand,
      String vaccination,
      DateTime date,
      DateTime nextdose,
      String photovaccinelabel,
      String photocertificate);

  Future<void> addAntiparasites(
       String type,
       String brand,
       DateTime date,
       DateTime nextdose,
  );

   Stream<List<Vaccine>> getVaccine();
   Stream<List<Antiparasites>> getAntiparasites();
   
   Future<void> getInfopet(
   
  );
    Stream<List<Vet>> getVets();

}