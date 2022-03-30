import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanner_app/config/colors.dart';
import 'package:scanner_app/config/theme.dart';
import 'package:scanner_app/screens/login.dart';
import 'package:scanner_app/screens/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Scanner',
      theme: ThemeData(
          textTheme: GoogleFonts.openSansTextTheme(KTextTheme.textTheme),
          primaryColor: KColors.primaryColor,
          inputDecorationTheme: KInputDecorationTheme.inputDecorationTheme),
      home: const SplashScreen(),
    );
  }
}
