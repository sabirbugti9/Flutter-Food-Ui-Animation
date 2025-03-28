import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_ui_transition/home/home.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ProviderScope(child: FoodUI()));
}

class FoodUI extends StatelessWidget {
  const FoodUI({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Advance Animations',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff45C37B),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
