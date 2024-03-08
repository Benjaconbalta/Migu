import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:migu/infrastrocture/datasource/Vaccineandantiparasites_datasource_impl.dart';
import 'package:migu/infrastrocture/repository/Vaccineandantiparasites_repository_impl.dart';

final vaccineandAntiparasitesRepositoryProvider = Provider((ref) {
  return Vaccineandantiparasitesrepositoryimpl(
      VaccineandantiparasitesDatasourceImpl());
});
