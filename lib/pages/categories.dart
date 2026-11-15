import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/theme.dart';
import 'favourites.dart';
import 'product_details.dart';
import '../services/categories_service.dart';
import '../widgets/skeleton.dart';
import '../services/products_service.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

//initialise the category object of the class CategoriesService
final CategoriesService categoryService = CategoriesService();
late Future<List<Map<String, dynamic>>> category;


  @override
  void initState() {
    super.initState();
    category = categoryService.getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KanvaColors.background,
      appBar: const KAppBar(title: 'Kanva'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 110),
        children: [
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: KanvaColors.textDark,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Browse by style',
            style: TextStyle(fontSize: 13, color: KanvaColors.textLight),
          ),
          const SizedBox(height: 20),

          FutureBuilder<List<Map<String, dynamic>>>(
            future: category,
            builder: (context, snapshot) {
              //keep the skeleton cards while the categories are loading
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SkeletonCards();
              }

              final list = snapshot.data ?? [];

              //if the list is empty, show a message
              if (list.isEmpty) {
                return const Center(child: Text('No categories found'));
              }

              //if the list is not empty, show the categories
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final item = list[index].map((key, value) => MapEntry(key, '${value ?? ''}'));
                  return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => _CategoryItems(name: item['name'] ?? 'Category Name')),
                ),
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: ClipOval(
                        child: Image.asset(item['image'] ?? 'assets/images/shirt.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['name'] ?? 'Category Name',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: KanvaColors.textDark),
                    ),
                  ],
                ),
              );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CategoryItems extends StatefulWidget {

  final String name;
  const _CategoryItems({required this.name});
  @override
  State<_CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<_CategoryItems> {

  final ProductsService productsService = ProductsService();
  late Future<List<Map<String, dynamic>>> products;

  @override
  void initState() {
    super.initState();
    products = productsService.getProductsByCategory(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KanvaColors.background,
      appBar: const KAppBar(title: 'Kanva'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 110),
        
        children: [
          Text(
            widget.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: KanvaColors.textDark,
            ),
          ),

          const SizedBox(height: 16),

          FutureBuilder<List<Map<String, dynamic>>>(
            future: products,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SkeletonCards();
              }
              final list = snapshot.data ?? [];
              if (list.isEmpty) return const Center(child: Text('No products found'));
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.68,
                ),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final p = list[index];
                  final item = p.map((key, value) => MapEntry(key, '${value ?? ''}'));
                      final shop = (p['shops'] as Map?)?['name']?.toString() ?? '';
                      return GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetails(product: item))),
                        child: Container(
                          width: 190,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(85, 101, 175, 1.0),
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                            border: Border.all(color: Colors.black, width: 0.1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                  child: Image.asset(item['image'] ?? 'assets/images/shirt.jpg', height: 150, width: double.infinity, fit: BoxFit.cover),
                                ),
                                Positioned(
                                  top: 6, right: 6,
                                  child: GestureDetector(
                                    onTap: () => setState(() => FavouritesStore.toggle(item)),
                                    child: Container(
                                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.pinkAccent),
                                      padding: const EdgeInsets.all(7),
                                      child: Icon(FavouritesStore.has(item) ? Icons.favorite : Icons.favorite_border, color: Colors.white, size: 20),
                                    ),
                                  ),
                                ),
                              ]),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(12, 6, 12, 2),
                                child: Text(item['name'] ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.inknutAntiqua(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Row(children: [
                                  Expanded(child: Text(shop, style: GoogleFonts.inknutAntiqua(fontSize: 16, color: Colors.white), overflow: TextOverflow.ellipsis)),
                                  const Icon(Icons.store, color: Colors.white, size: 24),
                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
                                child: Row(children: [
                                  Expanded(child: Text(item['price'] ?? '', style: GoogleFonts.inknutAntiqua(fontSize: 12, color: Colors.white), overflow: TextOverflow.ellipsis)),
                                  const Icon(Icons.local_offer, color: Colors.white, size: 16),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}