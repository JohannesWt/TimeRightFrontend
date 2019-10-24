/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:time_right/core/constants/app_constants.dart';
import 'package:time_right/provider_setup.dart';
import 'package:time_right/ui/router.dart';
import 'package:time_right/ui/shared/colors.dart';
import 'package:time_right/ui/views/login_view.dart';

import 'app_localizations.dart';

/// Method is executed first when starting the app.
void main() => runApp(MyApp());

/// Class is the starting point of the app and gets created first.
/// Every global setting like locales, styles and start route is set here.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        /// All supported locales are listed here
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('de', 'DE'),
        ],

        /// These delegates make sure that the localization data for the proper
        /// language is loaded
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          /// Check if current locale is included in supported locales
          /// Translations do not work for IOS => check if locale is null
          if (locale != null) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
          }
          return supportedLocales.first;
        },
        title: 'TimeRight',
        theme: ThemeData(
          primaryColor: gray4,
          appBarTheme: AppBarTheme(
            color: Colors.transparent,
            elevation: 0,
            textTheme: TextTheme(title: TextStyle(fontSize: 32, color: gray4, fontFamily: 'Porsche_Next',)),
            actionsIconTheme: IconThemeData(color: gray4),
            iconTheme: IconThemeData(color: gray4),
          ),
          fontFamily: 'Porsche_Next',
          textTheme: TextTheme(
            title: TextStyle(fontSize: 22),
            body1: TextStyle(fontSize: 16),
            button: TextStyle(fontSize: 18)
          )
        ),
        debugShowCheckedModeBanner: false,
        home: LoginView(),
        initialRoute: RoutePaths.loginView,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}