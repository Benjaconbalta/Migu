import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:migu/domain/entities/Tutor.dart';
import 'package:migu/presentation/providers/vets/vets_repository_provider.dart';

final vetFirebaseProvider = StreamProvider.autoDispose<List<Tutor>>((ref) {
  final tutors = ref.watch(vetsRepositoryProvider).getAllTutors();

// print ()
  return tutors;
});
//poner al autodispose
// final antiparasitesFirebaseProvider = StreamProvider.autoDispose<List<Antiparasites>>((ref) {
//   final antiparasites = ref.watch(vetsRepositoryProvider).setProfile();
// // print ()
//   return antiparasites;
// });