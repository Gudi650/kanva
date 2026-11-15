import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/services/products_service.dart';
import '../pages/product_details.dart';
import '../pages/favourites.dart';
import 'skeleton.dart';

class Products extends StatefulWidget {
  final String category;
  const Products({super.key, this.category = 'All Items'});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  //object initialisation of the products service
  final ProductsService productsService = ProductsService();
  late Future <List<Map<String, dynamic>>> products;

  @override
  void initState() {
    super.initState();
    products = productsService.getAllProducts();
  }

  String _categoryOf(Map<String, dynamic> row) =>
      (row['categories'] as Map?)?['name']?.toString() ?? '';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: products,
      builder: (context, snapshot) {

        //keep the skeleton cards while the products are loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SkeletonCards();
        }

        final list = snapshot.data ?? [];

        if (widget.category != 'All Items') {
          final filtered = list.where((row) => _categoryOf(row) == widget.category).toList();
          return SizedBox(height: 276, width: double.infinity, child: _cards(filtered));
        }
        final names = <String>[];
        //get the unique categories
        for (final row in list) {
          final name = _categoryOf(row);
          if (name.isNotEmpty && !names.contains(name)) names.add(name);
        }

        return Column(
          children: [
            for (final name in names) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(name, style: GoogleFonts.inknutAntiqua(fontSize: 18, letterSpacing: 1)),
                ),
              ),
              SizedBox(height: 276, child: _cards(list.where((row) => _categoryOf(row) == name).toList())),
            ],
          ],
        );
      },
    );
  }

  Widget _cards(List<Map<String, dynamic>> list) => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index].map((key, value) => MapEntry(key, '${value ?? ''}'));
          final shop = (list[index]['shops'] as Map?)?['name']?.toString() ?? 'Product Store';
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetails(product: item),
                ),
              );
            },
            child: Container(
              width: 190,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(85, 101, 175, 1.0),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(0.0),
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                border: Border.all(color: Colors.black, width: 0.1),
                /*boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],*/
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        child: Image.asset(
                          item['image'] ?? 'assets/images/shirt.jpg',
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 6,
                        right: 6,
                        child: GestureDetector(
                          onTap: () => setState(
                            () => FavouritesStore.toggle(item),
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.pinkAccent,
                            ),
                            padding: const EdgeInsets.all(7.0),
                            child: Icon(
                              FavouritesStore.has(item)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.white,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      top: 8.0,
                      bottom: 8.0,
                    ),
                    child: Text(
                      item['name'] ?? 'Product Name',
                      style: GoogleFonts.inknutAntiqua(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            shop,
                            style: GoogleFonts.inknutAntiqua(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Icon(Icons.store, color: Colors.white, size: 24.0),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item['price'] ?? 'Product Price',
                            style: GoogleFonts.inknutAntiqua(
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Icon(
                            Icons.local_offer,
                            color: Colors.white,
                            size: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            );
          },
        );
}
