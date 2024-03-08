import 'package:migu/domain/datasource/vaccineandantiparasites_datasource.dart';
import 'package:migu/domain/entities/antiparasites.dart';
import 'package:migu/domain/entities/vaccine.dart';
import 'package:migu/domain/repository/Vaccineandantiparasites_repository.dart';

class Vaccineandantiparasitesrepositoryimpl
    extends Vaccineandantiparasitesrepository {
  final Vaccineandantiparasites datasource;

  Vaccineandantiparasitesrepositoryimpl(this.datasource);
  @override
  Future<void> addAntiparasites(
      String type, String brand, DateTime date, DateTime nextdose) {
    return datasource.addAntiparasites(type, brand, date, nextdose);
  }

  @override
  Future<void> addVaccine(
      String type,
      String brand,
      String vaccination,
      DateTime date,
      DateTime nextdose,
      String photovaccinelabel,
      String photocertificate) {
    // TODO: implement addVaccine
    return datasource.addVaccine(type, brand, vaccination, date, nextdose,
        photovaccinelabel, photocertificate);
  }

  @override
  Stream<List<Antiparasites>> getAntiparasites() {
    // TODO: implement getAntiparasites
    return datasource.getAntiparasites();
  }

  @override
  Stream<List<Vaccine>> getVaccine() {
    return datasource.getVaccine();
  }

  @override
  Future<void> getInfopet() {
    // TODO: implement addInfopet
    return getInfopet();
  }
}
