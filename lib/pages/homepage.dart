import 'package:flutter/material.dart';
import '../widgets/navigationBar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 48,
              width: 48,
              margin: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(85, 101, 175, 1.0),
              ),
              child: const Icon(Icons.account_circle, color: Colors.white),
            ),
            Text('Kanva', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, letterSpacing: 2.0, fontFamily: 'Inknut Antiqua', color: Color.fromRGBO(85, 101, 175, 1.0))),
            Container(
              height: 48,
              width: 48,
              margin: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(85, 101, 175, 1.0),
              ),
              child: const Icon(Icons.notification_add, color: Colors.white),
            ),
          ],
        ),

        SizedBox(height: 4.0),

        Container(
          height: 60,
          margin: const EdgeInsets.all(12.0),
          child: TextField(
              decoration: InputDecoration(
                labelText: "Search ",
                labelStyle: TextStyle(color: Colors.grey[600], fontSize: 16.0, letterSpacing: 2.0, fontFamily: 'Inknut Antiqua'),
                //hintText: "Type something...",
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 8),
                  child: Icon(Icons.search),
                ),
                filled:true,
                fillColor: Color.fromRGBO(227, 227, 227, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: BorderSide.none,
                ),
              ),
          ),
        ),

        

        SizedBox(height: 10.0),
        
        
      ])),
      bottomNavigationBar: const Navigation(),
    );
  }
}
