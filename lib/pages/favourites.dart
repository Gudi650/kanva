import 'package:flutter/material.dart';
import '../theme/theme.dart';
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
  @override
  Widget build(BuildContext context) {
    final items = FavouritesStore.items;
    return Scaffold(
      backgroundColor: KanvaColors.background,
      appBar: const KAppBar(title: 'Favourites'),
      body: items.isEmpty
          ? const Center(child: Text('No favourites yet', style: TextStyle(color: KanvaColors.textLight)))
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) {
                final p = items[i];
                return KCard(
                  padding: const EdgeInsets.all(12),
                  child: Row(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(p['image'] ?? '', width: 64, height: 64, fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 64, height: 64, color: KanvaColors.inputBg,
                          child: const Icon(Icons.checkroom, color: KanvaColors.primary),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetails(product: p))),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(p['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.w600, color: KanvaColors.textDark)),
                          const SizedBox(height: 4),
                          Text(p['price'] ?? '', style: const TextStyle(color: KanvaColors.primary, fontWeight: FontWeight.bold)),
                        ]),
                      ),
                    ),
                    IconButton(
                      onPressed: () => setState(() => FavouritesStore.toggle(p)),
                      icon: const Icon(Icons.favorite, color: KanvaColors.pinkFav),
                    ),
                  ]),
                );
              },
            ),
    );
  }
}
