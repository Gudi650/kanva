import 'package:flutter/material.dart';
import '../theme/theme.dart';
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
              return Column(
                children: [
                  for (final p in list)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: KCard(
                        padding: const EdgeInsets.all(12),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ProductDetails(
                            product: p.map((key, value) => MapEntry(key, '${value ?? ''}')),
                          )),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset('assets/images/shirt.jpg', width: 72, height: 72, fit: BoxFit.cover),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${p['name'] ?? ''}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: KanvaColors.textDark)),
                                  const SizedBox(height: 4),
                                  Text((p['shops'] as Map?)?['name']?.toString() ?? '', style: const TextStyle(fontSize: 12, color: KanvaColors.textLight)),
                                  const SizedBox(height: 6),
                                  Text('${p['price'] ?? ''}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: KanvaColors.primary)),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right, color: KanvaColors.textLight),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}