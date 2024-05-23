class Vet {
  final String name;
  final String lastname;
  final String correo;
  final int phone;
  final String service;
  final String yearsofexperience;
  final String speciality;
  final Map<String, dynamic> atentions;
  final Map<String, dynamic> choosespecies;
  final String addres;
  final List<dynamic> offerparagraph;
  Vet( {
    required this.name, required this.lastname, required this.correo, required this.phone, required this.service, required this.yearsofexperience,required this.speciality,required this.atentions,required this.addres,required this.choosespecies,required this.offerparagraph
  });
}
