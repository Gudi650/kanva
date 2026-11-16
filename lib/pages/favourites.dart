import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../services/favourite_service.dart';
import '../widgets/skeleton.dart';
import 'product_details.dart';

class FavouritesStore {
  static final items = <Map<String, String>>[];

  static bool has(Map<String, String> p) => items.any((e) => e['name'] == p['name']);

  static void toggle(Map<String, String> p) {
    if (has(p)) {
      items.removeWhere((e) => e['name'] == p['name']);
    } else {
      items.add(p);
    }
  }
}

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  final _service = FavouriteService();
  List<Map<String, dynamic>> _items = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final rows = await _service.getLoggedInUserFavourites();
      if (mounted) setState(() { _items = rows; _loading = false; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KanvaColors.background,
      appBar: const KAppBar(title: 'Favourites'),
      body: _loading
          ? ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                SkeletonBar(width: double.infinity, height: 72),
                SizedBox(height: 12),
                SkeletonBar(width: double.infinity, height: 72),
                SizedBox(height: 12),
                SkeletonBar(width: double.infinity, height: 72),
              ],
            )
          : _items.isEmpty
          ? const Center(child: Text('No favourites yet', style: TextStyle(color: KanvaColors.textLight)))
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: _items.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (_, i) {
                final row = _items[i];
                final product = (row['products'] as Map?) ?? {};
                final name = '${product['name'] ?? ''}';
                final price = '${product['price'] ?? ''}';
                final shop = (product['shops'] as Map?)?['name']?.toString() ?? '';
                final id = '${row['product_id']}';
                return KCard(
                  padding: const EdgeInsets.all(12),
                  child: Row(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset('assets/images/shirt.jpg', width: 64, height: 64, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetails(product: {
                          'name': name,
                          'price': price,
                          'image': 'assets/images/shirt.jpg',
                          'id': id,
                        }))),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(name, style: const TextStyle(fontWeight: FontWeight.w600, color: KanvaColors.textDark)),
                          const SizedBox(height: 4),
                          Text(shop, style: const TextStyle(fontSize: 12, color: KanvaColors.textLight)),
                          const SizedBox(height: 4),
                          Text(price, style: const TextStyle(color: KanvaColors.primary, fontWeight: FontWeight.bold)),
                        ]),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await _service.removeFromFavourites(id);
                        await _load();
                      },
                      icon: const Icon(Icons.favorite, color: KanvaColors.pinkFav),
                    ),
                  ]),
                );
              },
            ),
    );
  }
}
