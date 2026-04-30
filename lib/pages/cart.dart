import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Cart Page', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, letterSpacing: 2.0, fontFamily: 'Inknut Antiqua', color: Color.fromRGBO(85, 101, 175, 1.0))),
        ),
      ),
    );
  }
}