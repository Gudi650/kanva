import 'package:flutter/material.dart';
import 'pages/splash_screen.dart';
import 'theme/theme.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: kanvaTheme(),
    home: const SplashScreen(),
  ),
);
