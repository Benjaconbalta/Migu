import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:migu/domain/entities/Tutor.dart';
import 'package:migu/domain/entities/Vet.dart';
import 'package:migu/domain/entities/clinicalrecord.dart';
import 'package:migu/domain/entities/vaccine.dart';
import 'package:migu/domain/repository/vet_repository.dart';
import 'package:migu/infrastrocture/datasource/vet_datasource_impl.dart';
import 'package:migu/infrastrocture/repository/vet_repository_impl.dart';
import 'package:migu/presentation/providers/vets/vets_repository_provider.dart';

final vetFirebaseProvider = StreamProvider.autoDispose<List<Tutor>>((ref) {
  final tutors = ref.watch(vetsRepositoryProvider).getAllTutors();

// print ()|
  return tutors;
});

final getProfileProvider = StreamProvider.autoDispose<List<dynamic>>((ref) {
  final vetProfile = ref.watch(vetsRepositoryProvider).getProfile();

  // print ()|

  return vetProfile;
});
//raro ese family
final getclinicalRecord = StreamProvider.autoDispose.family<List<ClinicalRecord>, String>((ref, uid) {
  final clincalRecord = ref.watch(vetsRepositoryProvider).getclinicalRecord(uid);

  // print ()|

  return clincalRecord;
});

//poner al autodispose
// final antiparasitesFirebaseProvider = StreamProvider.autoDispose<List<Antiparasites>>((ref) {
//   final antiparasites = ref.watch(vetsRepositoryProvider).setProfile();
// // print ()
//   return antiparasites
//
// ;
// });

final vetProvider = StateNotifierProvider.autoDispose<VetNotifier, VetUserState>((ref) {
  final repository = VetRepositoryImpl(VetDatasourceImpl());
  return VetNotifier(vetRepository: repository);
});

class VetNotifier extends StateNotifier<VetUserState> {
  final VetRepository vetRepository;

  VetNotifier({required this.vetRepository}) : super(VetUserState());
Future<void> setUser(
   String name,
   String lastname,
   String correo,
   int phone,
   String service,
   String yearsofexperience,
   String speciality,
   Map<String, dynamic> atentions,
   String addres,
    Map<String, dynamic> choosespecies,
   List<dynamic> paragraph,
   List<dynamic> patients,
   String image
) {
    return vetRepository.setProfile(
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

  Future<void> addclinicalRecord(  String uid,
      String name,
      DateTime birthdate,
      String nutrition,
      int weight,
      String behavior,
      String treatmen,
      String observations){
return vetRepository.addclinicalRecord(uid, name, birthdate, nutrition, weight, behavior, treatmen, observations);
  }
}

class VetUserState {
  final Vet? vet;
  VetUserState({this.vet});

  VetUserState copywith({vet}) => VetUserState(
        vet: vet ?? this.vet,
      );
}
