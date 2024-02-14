import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color.fromARGB(255, 218, 34, 255),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.overpass()
        .copyWith( fontSize: 40, fontWeight: FontWeight.bold ),
      titleMedium: GoogleFonts.openSans()
        .copyWith( fontSize: 30, fontWeight: FontWeight.w500 ),
      titleSmall: GoogleFonts.openSans()
        .copyWith( fontSize: 20 , fontWeight: FontWeight.w400),
      bodyMedium: GoogleFonts.openSans()
        .copyWith( fontWeight: FontWeight.w400)
    ),
    scaffoldBackgroundColor: Colors.white70,
    // colorScheme: const ColorScheme( 
    //   brightness: Brightness.light, 
    //   primary: Color.fromARGB(255, 218, 34, 255), 
    //   onPrimary: Color.fromARGB(255, 235, 133, 255), 
    //   secondary: Color.fromARGB(255, 34, 189, 255), 
    //   onSecondary: Color.fromARGB(255, 108, 208, 251), 
    //   error: Color.fromARGB(255, 255, 22, 22), 
    //   onError: Color.fromARGB(255, 255, 106, 106), 
    //   background: Color.fromARGB(255, 185, 34, 255), 
    //   onBackground: Color.fromARGB(255, 199, 90, 249), 
    //   surface: Color.fromARGB(255, 27, 255, 118), 
    //   onSurface: Color.fromARGB(255, 99, 251, 160)
    // ),
    ///* Buttons
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStatePropertyAll(
          GoogleFonts.montserratAlternates()
            .copyWith(fontWeight: FontWeight.w700)
          )
      )
    ),

    ///* AppBar
    appBarTheme: AppBarTheme(
      color: const Color.fromARGB(255, 153, 0, 183),
      titleTextStyle: GoogleFonts.openSans()
        .copyWith( fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white ),
      elevation: 0.0,
    ),

    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white, modalBackgroundColor: Colors.white ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color.fromARGB(255, 108, 34, 255),
    )

  );

}