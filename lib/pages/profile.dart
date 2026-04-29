import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Profile Page', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, letterSpacing: 2.0, fontFamily: 'Inknut Antiqua', color: Color.fromRGBO(85, 101, 175, 1.0))),
        ),
      ),
    );
  }
}