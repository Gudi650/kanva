import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 0, 36, 10),
      child: SizedBox(
        height: 80.0,
        width: 360.0,
        child: Container(
          margin: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(227, 227, 227, 1),
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 48,
                width: 102,
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  //shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(40.0),
                  color: Color.fromRGBO(85, 101, 175, 1.0),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.home, color: Colors.white),
                      SizedBox(width: 4),
                      Text('Home', style: TextStyle(color: Colors.white, fontSize: 16.0, letterSpacing: 2.0, fontFamily: 'Inknut Antiqua')),
                    ],
                  ),
                ),
              ),
      
              Container(
                height: 44,
                width: 44,
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(Icons.catching_pokemon, color: Colors.black),
              ),
      
              Container(
                height: 44,
                width: 44,
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(Icons.shopping_cart, color: Colors.black),
              ),
      
              Container(
                height: 44,
                width: 44,
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(Icons.more_horiz, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
