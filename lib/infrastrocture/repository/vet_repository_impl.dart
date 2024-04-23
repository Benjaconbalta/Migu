import 'package:migu/domain/datasource/vet_datasource.dart';
import 'package:migu/domain/entities/Tutor.dart';
import 'package:migu/domain/repository/vet_repository.dart';

class VetRepositoryImpl extends VetRepository {
  final VetDatasource datasource;

  VetRepositoryImpl(this.datasource);
  @override
  Stream<List<Tutor>> getAllTutors() {
    return datasource.getAllTutors();
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
    return datasource.setProfile(
        name,
        lastname,
        correo,
        phone,
        service,
        yearsofexperience,
        speciality,
        choseAtencion,
        address,
        choosespecies,
        offerparagraph);
  }
}
