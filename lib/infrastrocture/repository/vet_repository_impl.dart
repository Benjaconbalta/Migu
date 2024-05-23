import 'package:migu/domain/datasource/vet_datasource.dart';
import 'package:migu/domain/entities/Tutor.dart';
import 'package:migu/domain/entities/Vet.dart';
import 'package:migu/domain/entities/clinicalrecord.dart';
import 'package:migu/domain/repository/vet_repository.dart';

class VetRepositoryImpl extends VetRepository {
  final VetDatasource datasource;

  VetRepositoryImpl(this.datasource);
  @override
  Stream<List<Tutor>> getAllTutors() {
    return datasource.getAllTutors();
  }

//   @override
//   Future<void> setProfile(
//       String name,
//       String lastname,
//       String correo,
//       int phone,
//       String service,
//       String yearsofexperience,
//       String speciality,
//       Map<String, dynamic> atentions,
//       Map<String, dynamic> choosespecies,
//       String addres,
//       String offerparagraph,
//       String image
//       ) {
//      return datasource.setProfile(
//          name,
//          lastname,
//          correo,
//          phone,
//          service,
//          yearsofexperience,
//          speciality,
//          atentions,
//          choosespecies,
//          addres,
//          offerparagraph,
//  image
//          );
//    }

  @override
  Stream<List> getProfile() {
    return datasource.getProfile();
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
      String observations) {
    return datasource.addclinicalRecord(uid, name, birthdate, nutrition, weight,
        behavior, treatmen, observations);
  }

  @override
  Stream<List<ClinicalRecord>> getclinicalRecord(String uid) {
    return datasource.getclinicalRecord(uid);
  }
  
  @override
  Future<void> setProfile(String name, String lastname, String correo, int phone, String service, String yearsofexperience, String speciality, Map<String, dynamic> atentions, Map<String, dynamic> choosespecies, String addres, List<dynamic> paragraph,String image,  List<dynamic> patients,) {
    // TODO: implement setProfile
       return datasource.setProfile(
         name,
         lastname,
         correo,
         phone,
         service,
         yearsofexperience,
         speciality,
         atentions,
         choosespecies,
         addres,
         paragraph,
         image,
       patients,
         
 
         );
   
  }
}
