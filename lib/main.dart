import 'package:flutter/material.dart';
import 'pages/splash_screen.dart';
import 'theme/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/*
void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: kanvaTheme(),
    home: const SplashScreen(),
  ),
);

*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.env['SUPERBASE_URL']!,
    publishableKey: dotenv.env['SUPERBASE_ANON_KEY']!,
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: kanvaTheme(),
      home: const SplashScreen(),
    ),
  );
}
