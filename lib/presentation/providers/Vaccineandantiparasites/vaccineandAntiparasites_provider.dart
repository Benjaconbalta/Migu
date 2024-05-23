import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:migu/domain/entities/Vet.dart';
import 'package:migu/domain/entities/antiparasites.dart';
import 'package:migu/domain/entities/vaccine.dart';
import 'package:migu/domain/repository/Vaccineandantiparasites_repository.dart';
import 'package:migu/infrastrocture/datasource/Vaccineandantiparasites_datasource_impl.dart';
import 'package:migu/infrastrocture/repository/Vaccineandantiparasites_repository_impl.dart';
import 'package:migu/presentation/providers/Vaccineandantiparasites/Vaccineandantiparasites_repository_provider.dart';

final vaccineandAntiparasitesProvider = StateNotifierProvider<
    VaccineandAntiparasitesNotifier, VaccineandAntiparasitesState>((ref) {
  final repositori = Vaccineandantiparasitesrepositoryimpl(
      VaccineandantiparasitesDatasourceImpl());
  return VaccineandAntiparasitesNotifier(vaccineRepository: repositori);
});

class VaccineandAntiparasitesNotifier
    extends StateNotifier<VaccineandAntiparasitesState> {
  final Vaccineandantiparasitesrepository vaccineRepository;

  VaccineandAntiparasitesNotifier({required this.vaccineRepository})
      : super(VaccineandAntiparasitesState());

  Future<void> addAntiparasites(
      String type, String brand, DateTime date, DateTime nextdose) {
    return vaccineRepository.addAntiparasites(type, brand, date, nextdose);
  }

  Future<void> addVaccine(
      String type,
      String brand,
      String vaccination,
      DateTime date,
      DateTime nextdose,
      String photovaccinelabel,
      String photocertificate) {
    // TODO: implement addVaccine
    return vaccineRepository.addVaccine(type, brand, vaccination, date,
        nextdose, photovaccinelabel, photocertificate);
  }

  Stream<List<Antiparasites>> getAntiparasites() {
    // TODO: implement getAntiparasites
    throw UnimplementedError();
  }

  @override
  Stream<List<Vaccine>> getVaccine() {
    // TODO: implement getVaccine
    throw UnimplementedError();
  }

  @override
  Future<void> addInfopet(String photo, String namePet, String typepet) {
    // TODO: implement addInfopet
    throw UnimplementedError();
  }
}

final getvetFirebaseProvider = StreamProvider.autoDispose<List<Vet>>((ref) {
  final allvets =
      ref.watch(vaccineandAntiparasitesRepositoryProvider).getVets();

// print ()|
  return allvets;
});

class VaccineandAntiparasitesState {
  final Vaccine? vaccine;
  VaccineandAntiparasitesState({this.vaccine});

  VaccineandAntiparasitesState copywith({vaccine}) =>
      VaccineandAntiparasitesState(
        vaccine: vaccine ?? this.vaccine,
      );
}

final vaccineFirebaseProvider =
    StreamProvider.autoDispose<List<Vaccine>>((ref) {
  final vaccineF =
      ref.watch(vaccineandAntiparasitesRepositoryProvider).getVaccine();
// print ()
  return vaccineF;
});
//poner al autodispose
final antiparasitesFirebaseProvider =
    StreamProvider.autoDispose<List<Antiparasites>>((ref) {
  final antiparasites =
      ref.watch(vaccineandAntiparasitesRepositoryProvider).getAntiparasites();
// print ()
  return antiparasites;
});

final antiparasitesProvider = StateProvider<Antiparasites>((ref) {
  return Antiparasites(
      brand: "",
      date: DateTime.now(),
      nextdose: DateTime.now(),
      type: "",
      id: "");
});

final vetinfoProvider = StateProvider<Vet>((ref) {
  return Vet(
      name: "",
      lastname: "",
      correo: "",
      phone: 0,
      service: "",
      yearsofexperience: "",
      speciality: "",
      atentions: {},
      addres: "",
      choosespecies: {},
      offerparagraph: []);
});
