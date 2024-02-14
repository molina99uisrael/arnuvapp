import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';



class Environment {

  static const String nombreApp = "Paseadores Caninos";
  static const String idiomaDefault = "es";
  static final Iterable<Locale> idiomasSoportados = [
    const Locale('en', 'US'),
    const Locale('es', 'ES'),
  ];
  static final lenguajes = ['en', 'es'];
  
  static initEnvironment() async {
    await dotenv.load(fileName: '.env');
  }

  // static String apiUrl = dotenv.env['API_URL'] ?? 'No está configurado el API_URL';
  // static String apiUrl = 'http://localhost:8080';
  static String apiUrl = 'http://192.168.100.31:8080';

}

class AppIdioma {
  final String name;
  final Map<String, String> values;
  AppIdioma(this.name, this.values);
}
