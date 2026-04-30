import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/widgets/three_dot_loader.dart';
import 'package:untitled1/pages/signin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Signin()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(85, 101, 175, 1.0),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              
              //big circular graphics
              Container(
                width: 240,
                height: 240,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(255, 251, 205, 1.0),
                ),
              ),

              const SizedBox(height: 20.0),

              Text(
                'Kanva',
                style: GoogleFonts.inknutAntiqua(
                  fontSize: 60.0,
                  fontWeight: FontWeight.w300,
                  color: const Color.fromRGBO(255, 251, 205, 1),
                  letterSpacing: 2.0,
                ),
              ),

              const SizedBox(height: 20.0),

              Text(
                'design . deliver . wear',
                style: GoogleFonts.inknutAntiqua(
                  fontSize: 18.0,
                  color: Color.fromRGBO(255, 251, 205, 1),
                  letterSpacing: 4.0,
                ),
              ),

              const SizedBox(height: 16),
              const ThreeDotLoader(),

              const Spacer(),

              Padding(
                padding: EdgeInsets.only(bottom: 40.0),
                child: Text(
                  'Made for creators',
                  style: GoogleFonts.inknutAntiqua(
                    fontSize: 16.0,
                    color: Color.fromRGBO(255, 251, 205, 1),
                    letterSpacing: 1.0,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}