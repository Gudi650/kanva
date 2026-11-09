import 'package:flutter/material.dart';
import 'package:untitled1/pages/categories.dart';
import 'package:untitled1/pages/homepage.dart';
import 'package:untitled1/pages/cart.dart';
import 'package:untitled1/pages/more.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> navItems = [
    {'icon': Icons.home, 'label': 'Home', 'page': const Homepage()},
    {
      'icon': Icons.grid_view,
      'label': 'Categories',
      'page': const Categories(),
    },
    {'icon': Icons.shopping_cart, 'label': 'Cart', 'page': const Cart()},
    {'icon': Icons.more_horiz, 'label': 'More', 'page': const More()},
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: selectedIndex == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) setState(() => selectedIndex = 0);
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(228, 235, 255, 1),
        body: Stack(
          children: [
            IndexedStack(
              index: selectedIndex,
              children: [for (final item in navItems) item['page'] as Widget],
            ),
            Positioned(
              left: 36,
              right: 36,
              bottom: MediaQuery.paddingOf(context).bottom + 12,
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(245, 245, 245, 1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...navItems.map((item) {
                      final i = navItems.indexOf(item);
                      final selected = selectedIndex == i;
                      return GestureDetector(
                        onTap: () => setState(() => selectedIndex = i),
                        child: Container(
                          height: selected ? 48 : 44,
                          width: selected ? (i == 1 ? 136 : 102) : 44,
                          margin: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            shape: selected
                                ? BoxShape.rectangle
                                : BoxShape.circle,
                            borderRadius: selected
                                ? BorderRadius.circular(40.0)
                                : null,
                            color: selected
                                ? const Color.fromRGBO(85, 101, 175, 1.0)
                                : Colors.white,
                          ),
                          child: !selected
                              ? Icon(item['icon'], color: Colors.black)
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(item['icon'], color: Colors.white),
                                    const SizedBox(width: 4),
                                    Text(
                                      item['label'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        letterSpacing: 2.0,
                                        fontFamily: 'Inknut Antiqua',
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
