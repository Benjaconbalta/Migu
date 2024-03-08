import 'package:migu/domain/entities/antiparasites.dart';
import 'package:migu/domain/entities/vaccine.dart';

class AntiparasitesMapper{
   static Antiparasites antiparasitesFirebaseToEntity(Map<String, dynamic> antiparasites,String id) =>
      Antiparasites(
       brand: antiparasites["brand"],
       date: antiparasites["date"],
       nextdose:antiparasites["nextdose"] ,
       type:antiparasites["type"]      ,
       id: id 
   );
}