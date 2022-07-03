import 'package:arz_online/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('fa', ''), // Farsi
        ],
        theme: ThemeData(
          fontFamily: 'dana',
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontFamily: 'dana',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            headline2: TextStyle(
              fontFamily: 'dana',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            bodyText1: TextStyle(
              fontFamily: 'dana',
              fontSize: 13,
              fontWeight: FontWeight.w300,
              height: 2.5,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen());
  }
}
