import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MaterialLocalizationTkDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  static final MaterialLocalizationTkDelegate _singleton = MaterialLocalizationTkDelegate();

  static MaterialLocalizationTkDelegate get instance => _singleton;

  @override
  bool isSupported(Locale locale) {
    return locale.countryCode == 'TM' || locale.languageCode == 'tk';
  }

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    return const DefaultMaterialLocalizations();
  }

  @override
  bool shouldReload(LocalizationsDelegate<MaterialLocalizations> old) => false;
}

class CupertinoLocalizationTkDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  static final CupertinoLocalizationTkDelegate _singleton = CupertinoLocalizationTkDelegate();

  static CupertinoLocalizationTkDelegate get instance => _singleton;

  @override
  bool isSupported(Locale locale) {
    return locale.countryCode == 'TM' || locale.languageCode == 'tk';
  }

  @override
  Future<CupertinoLocalizations> load(Locale locale) async {
    return const DefaultCupertinoLocalizations();
  }

  @override
  bool shouldReload(LocalizationsDelegate<CupertinoLocalizations> old) => false;
}
