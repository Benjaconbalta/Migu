class ClinicalRecord {
  final String uid;
  final String name;
  final DateTime birthdate;
  final String nutrition;
  final int weight;
  final String behavior;
  final String treatmen;
  final String observations;

  ClinicalRecord(
      {required this.uid,
      required this.name,
      required this.birthdate,
      required this.nutrition,
      required this.weight,
      required this.behavior,
      required this.treatmen,
      required this.observations});
}
