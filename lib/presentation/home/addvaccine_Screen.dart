import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:migu/presentation/views/home_view.dart';

class AddVaccineScreen extends StatelessWidget {
  const AddVaccineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Agregar Vacuna"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child:  Column(
       
     
         
            children: [
              SizedBox(height: 20,),
          const    MultiSelectDropdown(nameInput: "Tipo",),
                SizedBox(height: 10,),
              MultiSelectDropdown(nameInput: "Marca",),
                       SizedBox(height: 30,),
                       Align( alignment: Alignment.centerLeft, child: Text("Fecha de vacunacion*",style: TextStyle(fontSize:18,color: Colors.black ),)),
                  DatePicker(),
                           SizedBox(height: 20,),
                                Align( alignment: Alignment.centerLeft, child: Text("Proxima dosis",style: TextStyle(fontSize:18,color: Colors.black ),)),
                    DatePicker(),
                     SizedBox(height: 30,),
                    Container(
              // Bordes redondeados
  
      height: 80,
      width: 300,
      padding: EdgeInsets.all(10.0),
      color: Colors.grey[200], // Fondo gris claro
      child: Row(
    
        children: [
          Text("Etiqueta Vacuna"),
          Icon(Icons.help),
          SizedBox(width: 50,),
Container(
  width: 50,
  height: 30,
  child: Text("Foto"),
)


        
         
         
        ],
      ),
    ),
    SizedBox(height: 20,),
                  Container(
                    
      height: 80,
      width: 300,
      padding: EdgeInsets.all(10.0),
      color: Colors.grey[200], // Fondo gris claro
      child: Row(
    
        children: [
          Text("Etiqueta Vacuna"),
          Icon(Icons.help),
          SizedBox(width: 50,),
Container(
  width: 50,
  height: 30,
  child: Text("Foto"),
)


        
         
         
        ],
      ),
    ),
    ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Bordes cuadrados
                  ),
                  backgroundColor: Color(0xFF3D9A51),
                  padding: EdgeInsets.symmetric(horizontal: 90)),
              onPressed: () {
                context.go("/home/0");
                // Aquí puedes manejar la acción de continuar
              },
              child: Text(
                "Continuar",
                style: TextStyle(color: Colors.white),
              ),
            ),
              ],
              
          ),
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
          '${widget.nameInput}*',
          style: TextStyle(fontSize: 18,color: Colors.black),
        ),
        SizedBox(height: 7,),
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
          
            border: OutlineInputBorder( borderRadius:BorderRadius.circular(10),  borderSide: BorderSide(color: Colors.red), ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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

class DatePicker extends StatefulWidget {
  final void Function(int year, int month, int day)? onDateChanged;

  const DatePicker({Key? key, this.onDateChanged}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late int _selectedYear;
  late int _selectedMonth;
  late int _selectedDay;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _selectedYear = now.year;
    _selectedMonth = now.month;
    _selectedDay = now.day;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min, // Ajusta el espaciado entre los botones
      children: [
        _buildDatePicker("Día", _buildDayDropdown()),
                SizedBox(width: 10,),
        _buildDatePicker("Mes", _buildMonthDropdown()),
                SizedBox(width: 10,),
        _buildDatePicker("Año", _buildYearDropdown()),
      
      ],
    );
  }

  Widget _buildDatePicker(String labelText, Widget dropdown) {
    return Column(
      children: [
        
        SizedBox(height: 8),
        dropdown,
      ],
    );
  }

  Widget _buildYearDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButton<int>(
        value: _selectedYear,
        items: _buildYearItems(),
        onChanged: (value) {
          setState(() {
            _selectedYear = value!;
            widget.onDateChanged?.call(_selectedYear, _selectedMonth, _selectedDay);
          });
        },
        icon: null,
        hint: Text('Año'),
      ),
    );
  }

  Widget _buildMonthDropdown() {
    return Container(
   padding: EdgeInsets.symmetric(horizontal: 12,vertical: 7),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButton<int>(
        value: _selectedMonth,
        items: _buildMonthItems(),
        onChanged: (value) {
          setState(() {
            _selectedMonth = value!;
            widget.onDateChanged?.call(_selectedYear, _selectedMonth, _selectedDay);
          });
        },
        icon: null,
        hint: Text('Mes'),
      ),
    );
  }

  Widget _buildDayDropdown() {
    return Container(
  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 7),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButton<int>(
        value: _selectedDay,
        items: _buildDayItems(),
        onChanged: (value) {
          setState(() {
            _selectedDay = value!;
            widget.onDateChanged?.call(_selectedYear, _selectedMonth, _selectedDay);
          });
        },
        icon: null,
        hint: Text('Día'),
      ),
    );
  }

  List<DropdownMenuItem<int>> _buildYearItems() {
    List<DropdownMenuItem<int>> items = [];
    int currentYear = DateTime.now().year;
    for (int year = currentYear; year <= currentYear + 100; year++) {
      items.add(DropdownMenuItem<int>(
        value: year,
        child: Text(year.toString(),style: TextStyle(fontSize: 20),),
      ));
    }
    return items;
  }

  List<DropdownMenuItem<int>> _buildMonthItems() {
    List<DropdownMenuItem<int>> items = [];
    for (int month = 1; month <= 12; month++) {
      items.add(DropdownMenuItem<int>(
        value: month,
        child: Text(month.toString(),style: TextStyle(fontSize: 20),),
      ));
    }
    return items;
  }

  List<DropdownMenuItem<int>> _buildDayItems() {
    List<DropdownMenuItem<int>> items = [];
    int daysInMonth = DateTime(_selectedYear, _selectedMonth + 1, 0).day;
    for (int day = 1; day <= daysInMonth; day++) {
      items.add(DropdownMenuItem<int>(
        value: day,
        child: Text(day.toString(),style: TextStyle(fontSize: 20),),
      ));
    }
    return items;
  }
}
