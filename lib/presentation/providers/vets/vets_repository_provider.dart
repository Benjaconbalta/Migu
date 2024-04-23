import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:migu/infrastrocture/datasource/Vaccineandantiparasites_datasource_impl.dart';
import 'package:migu/infrastrocture/datasource/vet_datasource_impl.dart';
import 'package:migu/infrastrocture/repository/Vaccineandantiparasites_repository_impl.dart';
import 'package:migu/infrastrocture/repository/vet_repository_impl.dart';

final vetsRepositoryProvider = Provider((ref) {
  return VetRepositoryImpl(
      VetDatasourceImpl());
});
