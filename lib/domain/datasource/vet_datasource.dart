import 'package:migu/domain/entities/Tutor.dart';
import 'package:migu/domain/entities/Vet.dart';
import 'package:migu/domain/entities/clinicalrecord.dart';

abstract class VetDatasource {
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
      );

  Stream<List> getProfile();

  Stream<List<Tutor>> getAllTutors();

  Future<void> addclinicalRecord(String uid,String name,DateTime birthdate,String nutrition,int weight,String behavior,String treatmen,String observations);

  Stream<List<ClinicalRecord>> getclinicalRecord(String uid);
}

