import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const VIPShopperApp());
}

class VIPShopperApp extends StatelessWidget {
  const VIPShopperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VIP Shopper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // VIP Luxury Theme - Gold & Black
        primarySwatch: Colors.amber,
        primaryColor: const Color(0xFFFFD700), // Gold
        scaffoldBackgroundColor: const Color(0xFF0A0A0A), // Deep Black
        cardColor: const Color(0xFF1A1A1A), // Dark Gray
        
        // Text Theme with Google Fonts
        textTheme: GoogleFonts.playfairDisplayTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
        ),
        
        // AppBar Theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF000000),
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFFFFD700)),
          titleTextStyle: TextStyle(
            color: Color(0xFFFFD700),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        // Elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFD700),
            foregroundColor: const Color(0xFF000000),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
        ),
        
        // Input Decoration Theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1A1A1A),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF333333)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF333333)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFFFD700), width: 2),
          ),
          labelStyle: const TextStyle(color: Color(0xFFFFD700)),
          hintStyle: const TextStyle(color: Color(0xFF666666)),
        ),
        
        // Card Theme
        cardTheme: const CardThemeData(
          color: Color(0xFF1A1A1A),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}