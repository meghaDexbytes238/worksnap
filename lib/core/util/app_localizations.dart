import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  late Locale? locale;
  AppLocalizations(locale);

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  late Map<String, String> _localizedStrings;
  Future<bool> loadNew({Locale? localeTemp}) async {
    locale = localeTemp;
    if (locale != null) {
      // Load the language JSON file from the "lang" folder
      String jsonString = await rootBundle
          .loadString('assets/lang/${locale!.languageCode}.json');
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      _localizedStrings = jsonMap.map((key, value) {
        return MapEntry(key, value.toString());
      });
    }

    return true;
  }

  // This method will be called from every widget which needs a localized text
  String? translate(String key, {Map<String, String>? localizedStrings}) {
//    if (localizedStrings != null && localizedStrings.length > 0) {
//      return localizedStrings[key];
//    }
    return _localizedStrings[key];
  }
}

// LocalizationsDelegate is a factory for a set of localized resources
// In this case, the localized strings will be gotten in an AppLocalizations object
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['en', 'ko'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale? locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    AppLocalizations localizations = AppLocalizations(locale);

    await localizations.loadNew(localeTemp: locale);
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

class InitVar {
  bool isLoggedIn;
  Locale? mLocale;
  bool isTutorialSeen;
  bool isOneTimeProfileSetUpDone;

  InitVar({
    required this.isLoggedIn,
    required this.mLocale,
    required this.isTutorialSeen,
    required this.isOneTimeProfileSetUpDone,
  });
}
