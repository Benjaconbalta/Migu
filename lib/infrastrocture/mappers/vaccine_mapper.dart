import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:migu/domain/entities/vaccine.dart';

class VaccineMapper{
   static Vaccine vaccineFirebaseToEntity(Map<String, dynamic> vaccineFb,String id, Timestamp dateTimestamp,Timestamp nextdoseTimestamp) =>
      Vaccine(
          type:vaccineFb["type"] ,
          brand: vaccineFb["brand"],
          vaccination: vaccineFb["vaccination"],
         date:dateTimestamp.toDate() ,
         nextdose:nextdoseTimestamp.toDate(),
         photocertificate:vaccineFb["photocertificate"] ,
         photovaccinelabel:vaccineFb["photovaccinelabel"] ,
         id: id

         
          );
}