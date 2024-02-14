import 'package:flutter/material.dart';
import 'package:arnuvapp/config/locale/Languages/english.dart';
import 'package:arnuvapp/config/locale/Languages/spanish.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  final Map<String, AppIdioma> localizedValues = {
    'en': AppIdioma("English", english()),
    'es': AppIdioma("Español", spanish()),
  };

  String translate(String key) {
    return localizedValues[locale.languageCode]!.values[key] ?? key;
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
}

class AppIdioma {
  final String name;
  final Map<String, String> values;
  AppIdioma(this.name, this.values);
}