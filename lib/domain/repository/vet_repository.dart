import 'package:migu/domain/entities/Tutor.dart';

abstract class VetRepository{
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
      String offerparagraph);

   Stream<List<Tutor>> getAllTutors();
}