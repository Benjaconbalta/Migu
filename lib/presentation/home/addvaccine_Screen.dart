import 'package:flutter/material.dart';

class AddVaccineScreen extends StatelessWidget {
  const AddVaccineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Agregar Vacuna"),
        ),
        body: const Column(
          children: [
            MultiSelectDropdown(nameInput: "Tipo",),
             MultiSelectDropdown(nameInput: "Marca",)
            ],
        ));
  }
}

class MultiSelectDropdown extends StatefulWidget {
  final String nameInput;
  const MultiSelectDropdown({super.key, required this.nameInput});

  @override
  _MultiSelectDropdownState createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  List<String> _selectedOptions = [];
  List<String> _options = [
    'Antirrabica ',
    'sextumple',
    'Octuple',
    'Trivalente',
    "cuadruple",
    "KC",
    "intra-trak",
    "moquillo",
    "pupy dp",
    "leucemia",
    "giardia",
    "otra"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${widget.nameInput}',
          style: TextStyle(fontSize: 16),
        ),
        DropdownButtonFormField(
          isExpanded: true,
          value: _selectedOptions.isNotEmpty ? _selectedOptions : null,
          hint: Text('Seleccionar',style: TextStyle(fontSize: 18   ),),
          onChanged: (value) {},
          items: _options.map((option) {
            return DropdownMenuItem(
              value: option,
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            );
          }).toList(),
          validator: (value) {
            if (value == null) {
              return 'Por favor selecciona una opción';
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          selectedItemBuilder: (BuildContext context) {
            return _selectedOptions.map<Widget>((String option) {
              return Text(
                option,
                style: TextStyle(fontSize: 10),
              );
            }).toList();
          },
          isDense: true,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 36,
        ),
      ],
    );
  }
}
