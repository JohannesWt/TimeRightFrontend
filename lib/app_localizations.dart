/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Handles app language dynamically with device language
class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Map<String, String> _localizedStrings;

  /// Loads JSON-language-files in directory /lang
  Future<bool> load() async {
    String jsonString =
    await rootBundle.loadString('lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  /// This method will be called from every widget which needs a localized text
  String translate(String key) {
    return _localizedStrings[key];
  }
}

/// LocalizationsDelegate is a factory for a set of localized resources
/// In this case, the localized strings will be gotten in an AppLocalizations object
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    /// All included language codes
    return ['en', 'de'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    /// AppLocalizations class is where the JSON loading actually runs
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
