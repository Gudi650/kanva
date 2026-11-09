import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'product_details.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  static const _cats = [
    {'name': 'All Items', 'icon': Icons.apps_outlined, 'count': '48 items'},
    {
      'name': 'Latest',
      'icon': Icons.auto_awesome_outlined,
      'count': '12 items',
    },
    {'name': 'Men', 'icon': Icons.man_outlined, 'count': '18 items'},
    {'name': 'Women', 'icon': Icons.woman_outlined, 'count': '16 items'},
    {'name': 'Kids', 'icon': Icons.child_care_outlined, 'count': '8 items'},
    {'name': 'Accessories', 'icon': Icons.watch_outlined, 'count': '10 items'},
  ];

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
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _cats.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 14,
              mainAxisSpacing: 16,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (_, i) {
              final c = _cats[i];
              final image = i.isEven ? 'assets/images/shirt.jpg' : 'assets/images/screens.jpg';
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => _CategoryItems(name: c['name'] as String)),
                ),
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: ClipOval(
                        child: Image.asset(image, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      c['name'] as String,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: KanvaColors.textDark),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CategoryItems extends StatelessWidget {
  final String name;
  const _CategoryItems({required this.name});

  static const _items = [
    {
      'name': 'Product 1',
      'price': 'Tsh 19.99',
      'store': 'Kanva',
      'image': 'assets/images/shirt.jpg',
    },
    {
      'name': 'Product 2',
      'price': 'Tsh 29.99',
      'store': 'Kanva',
      'image': 'assets/images/shirt.jpg',
    },
    {
      'name': 'Product 3',
      'price': 'Tsh 39.99',
      'store': 'Kanva',
      'image': 'assets/images/shirt.jpg',
    },
    {
      'name': 'Product 4',
      'price': 'Tsh 49.99',
      'store': 'Kanva',
      'image': 'assets/images/shirt.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KanvaColors.background,
      appBar: const KAppBar(title: 'Kanva'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 110),
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: KanvaColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          ..._items.map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: KCard(
                padding: const EdgeInsets.all(12),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ProductDetails(product: p)),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        p['image']!,
                        width: 72,
                        height: 72,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 72,
                          height: 72,
                          color: KanvaColors.inputBg,
                          child: const Icon(
                            Icons.checkroom,
                            color: KanvaColors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p['name']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: KanvaColors.textDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            p['store']!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: KanvaColors.textLight,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            p['price']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: KanvaColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: KanvaColors.textLight,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
