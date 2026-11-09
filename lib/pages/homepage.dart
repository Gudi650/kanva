import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/products.dart';
import 'package:untitled1/pages/profile.dart';
import 'package:untitled1/pages/categories.dart';
import 'favourites.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //list of the scrollable categories
  final List<String> categories = [
    'All Items',
    'Latest',
    'Men',
    'Women',
    'Kids',
    'Accessories',
  ];

  //selected category index
  int selectedCategoryIndex = 0;
  String selectedCategory = 'All Items';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(228, 235, 255, 1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(
                12,
                MediaQuery.paddingOf(context).top + 8,
                12,
                20,
              ),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(85, 101, 175, 1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //account activity button
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AccountActivity(),
                          ),
                        ),
                        child: Container(
                          height: 48,
                          width: 48,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(255, 251, 205, 1),
                          ),
                          child: const Icon(
                            Icons.account_circle,
                            color: Color.fromRGBO(85, 101, 175, 1),
                          ),
                        ),
                      ),

                      Text(
                        'Kanva',
                        style: GoogleFonts.inknutAntiqua(
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 2,
                          color: const Color.fromRGBO(255, 251, 205, 1),
                        ),
                      ),

                      //favourites button
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const Favourites()),
                        ),
                        child: Container(
                          height: 48,
                          width: 48,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(255, 251, 205, 1),
                          ),
                          child: const Icon(
                            Icons.favorite,
                            color: Color.fromRGBO(85, 101, 175, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  //search bar
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: GoogleFonts.inknutAntiqua(
                        color: Colors.grey[600],
                        fontSize: 16,
                        letterSpacing: 2,
                      ),
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: const Color.fromRGBO(245, 245, 245, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),

            SizedBox(height: 10.0),

            /*

            SizedBox(height: 10.0),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/screens.jpg',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        color: const Color.fromRGBO(85, 101, 175, 0.45),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'New collection',
                              style: GoogleFonts.inknutAntiqua(
                                color: const Color.fromRGBO(255, 251, 205, 1),
                                fontSize: 14,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'design . deliver . wear',
                              style: GoogleFonts.inknutAntiqua(
                                color: const Color.fromRGBO(255, 251, 205, 1),
                                fontSize: 18,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            */

            const SizedBox(height: 12),

/*
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  for (final label in [
                    'Free delivery',
                    'Easy returns',
                    'Made to wear',
                  ])
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 251, 205, 1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          label,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inknutAntiqua(
                            fontSize: 10,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            */

            const SizedBox(height: 8),

            //the scrollable category section is here
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...categories.map(
                    (category) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategoryIndex = categories.indexOf(category);
                          selectedCategory = category;
                        });

                        //print('$selectedCategoryIndex');
                      },
                      child: Container(
                        height: 36,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 8,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color:
                              selectedCategoryIndex ==
                                  categories.indexOf(category)
                              ? const Color.fromRGBO(85, 101, 175, 1.0)
                              : const Color.fromRGBO(255, 251, 205, 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            category,
                            style: GoogleFonts.inknutAntiqua(
                              color:
                                  selectedCategoryIndex ==
                                      categories.indexOf(category)
                                  ? const Color.fromRGBO(255, 251, 205, 1)
                                  : Colors.black,
                              fontSize: 14,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.0),

            //the name being displayed
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '$selectedCategory Collections',
                      style: GoogleFonts.inknutAntiqua(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Categories()),
                    ),
                    child: Text(
                      'See all',
                      style: GoogleFonts.inknutAntiqua(
                        fontSize: 13,
                        letterSpacing: 1,
                        color: const Color.fromRGBO(85, 101, 175, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.0),

            //cards for the products
            const Products(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
