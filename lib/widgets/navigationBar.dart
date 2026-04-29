import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  //selected index
  int selectedIndex = 0;

  //list of icons to be displayed in the navigation bar with their names as well
  final List<Map<String, dynamic>> navItems = [
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.grid_view, 'label': 'Categories'},
    {'icon': Icons.shopping_cart, 'label': 'Cart'},
    {'icon': Icons.more_horiz, 'label': 'More'},
  ];
  


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

              /*
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
              */

              //map through the list of icons and display them in the navigation bar
              ...navItems.map((item) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = navItems.indexOf(item);
                    });
                  },
                  child: Container(
                    height: selectedIndex == navItems.indexOf(item) ? 48 : 44,
                    width: selectedIndex == navItems.indexOf(item) ? (selectedIndex == 1 ? 136 : 102): 44,
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(

                      shape: selectedIndex == navItems.indexOf(item) ? BoxShape.rectangle : BoxShape.circle,

                      borderRadius: selectedIndex == navItems.indexOf(item) ?  BorderRadius.circular(40.0) : null,

                      color: selectedIndex == navItems.indexOf(item) ? Color.fromRGBO(85, 101, 175, 1.0) : Colors.white,

                    ),
                    child: selectedIndex != navItems.indexOf(item) ? 
                      Icon(item['icon'], color: Colors.black) : 
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(item['icon'], color: Colors.white),
                            SizedBox(width: 4),
                            Text(item['label'], style: TextStyle(color: Colors.white, fontSize: 16.0, letterSpacing: 2.0, fontFamily: 'Inknut Antiqua')),
                          ],
                        ),
                  ),
                );
              }),

            ],
          ),
        ),
      ),
    );
  }
}
