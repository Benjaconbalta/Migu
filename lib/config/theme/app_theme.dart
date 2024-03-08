import 'package:flutter/material.dart';
const colorSeed = Colors.white;
const scaffoldBackgroundColor = Color(0xFFF8F7F7);

class AppTheme {

  ThemeData getTheme() => ThemeData(
    ///* General
    useMaterial3: true,
    colorSchemeSeed: colorSeed,

      textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),
      titleMedium:  TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
      titleSmall: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)
    ),

    ///* Scaffold Background Color
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    filledButtonTheme: const FilledButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStatePropertyAll(
         TextStyle(fontWeight: FontWeight.w700)
      )
    ),
 ),
    appBarTheme: const AppBarTheme(
      color: scaffoldBackgroundColor,
      titleTextStyle: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black)    
    )
  );
}