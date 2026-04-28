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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [

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

        Container(
            height: 200,
            width: 382,
            margin: const EdgeInsets.only(left: 12.0, right: 12.0),

            decoration: BoxDecoration(
              color: Color.fromRGBO(227, 227, 227, 1),
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                image: AssetImage('assets/images/screens.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            //child: Text("Explore Fashionable Collection.", style: TextStyle(fontSize: 16.0, letterSpacing: 2.0, fontFamily: 'Inknut Antiqua', color: Colors.white), textAlign: TextAlign.center,),
        ),

        SizedBox(height: 10.0),

        //the scrollable category section is here
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              
              Container(
                height: 40,
                width: 100,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(85, 101, 175, 1.0),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Text('All Items', style: TextStyle(color: Colors.white, fontSize: 14.0, letterSpacing: 2.0, fontFamily: 'Inknut Antiqua')),
                ),
              ),

              Container(
                height: 40,
                width: 120,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(85, 101, 175, 1.0),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Text('Latest Arrival', style: TextStyle(color: Colors.white, fontSize: 14.0, letterSpacing: 2.0, fontFamily: 'Inknut Antiqua')),
                ),
              ),

              Container(
                height: 40,
                width: 100,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(85, 101, 175, 1.0),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Text('Men', style: TextStyle(color: Colors.white, fontSize: 14.0, letterSpacing: 2.0, fontFamily: 'Inknut Antiqua')),
                ),
              ),

              Container(
                height: 40,
                width: 100,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(85, 101, 175, 1.0),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Text('Women', style: TextStyle(color: Colors.white, fontSize: 14.0, letterSpacing: 2.0, fontFamily: 'Inknut Antiqua')),
                ),
              ),

              Container(
                height: 40,
                width: 100,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(85, 101, 175, 1.0),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Text('Kids', style: TextStyle(color: Colors.white, fontSize: 14.0, letterSpacing: 2.0, fontFamily: 'Inknut Antiqua')),
                ),
              ),

              Container(
                height: 40,
                width: 100,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(85, 101, 175, 1.0),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Text('Accessories', style: TextStyle(color: Colors.white, fontSize: 14.0, letterSpacing: 2.0, fontFamily: 'Inknut Antiqua')),
                ),
              ),
            ],
          ),
        ),
          

        
        
      ]),
        ),
      ),
      bottomNavigationBar: const Navigation(),
    );
  }
}
