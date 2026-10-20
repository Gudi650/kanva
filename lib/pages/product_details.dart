import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'cart.dart';

class ProductDetails extends StatefulWidget {
  final Map<String, String> product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String _size = 'M';
  int _qty = 1;
  bool _liked = false;
  final _sizes = const ['S', 'M', 'L', 'XL'];

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    return Scaffold(
      backgroundColor: KanvaColors.background,
      appBar: KAppBar(
        title: 'Kanva',
        actions: [
          IconButton(
            onPressed: () => setState(() => _liked = !_liked),
            icon: Icon(_liked ? Icons.favorite : Icons.favorite_border,
                color: _liked ? KanvaColors.pinkFav : KanvaColors.primary),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              p['image'] ?? 'assets/images/shirt.jpg',
              height: 280,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 280,
                color: KanvaColors.inputBg,
                child: const Icon(Icons.checkroom, size: 64, color: KanvaColors.primary),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(p['name'] ?? 'Item',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: KanvaColors.textDark)),
          const SizedBox(height: 4),
          Text(p['store'] ?? 'Kanva',
              style: const TextStyle(fontSize: 13, color: KanvaColors.textLight)),
          const SizedBox(height: 8),
          Text(p['price'] ?? '',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: KanvaColors.primary)),
          const SizedBox(height: 16),
          const Text('Cotton everyday wear. Soft fabric, regular fit.',
              style: TextStyle(fontSize: 13, color: KanvaColors.textMid, height: 1.5)),
          const SizedBox(height: 20),
          const Text('Size', style: TextStyle(fontWeight: FontWeight.w600, color: KanvaColors.textDark)),
          const SizedBox(height: 10),
          Row(
            children: _sizes.map((s) {
              final sel = _size == s;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => setState(() => _size = s),
                  child: Container(
                    width: 44, height: 44, alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: sel ? KanvaColors.primary : KanvaColors.inputBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(s, style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: sel ? Colors.white : KanvaColors.textMid,
                    )),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          const Text('Quantity', style: TextStyle(fontWeight: FontWeight.w600, color: KanvaColors.textDark)),
          const SizedBox(height: 10),
          Row(children: [
            _qtyBtn(Icons.remove, () { if (_qty > 1) setState(() => _qty--); }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('$_qty', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: KanvaColors.textDark)),
            ),
            _qtyBtn(Icons.add, () => setState(() => _qty++)),
          ]),
          const SizedBox(height: 28),
          KButton(
            label: 'Add to Cart',
            icon: Icons.shopping_cart_outlined,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${p['name']} · $_size · x$_qty added'),
                  backgroundColor: KanvaColors.success,
                  action: SnackBarAction(
                    label: 'View',
                    textColor: Colors.white,
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Cart())),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: KanvaColors.inputBg, borderRadius: BorderRadius.circular(10)),
      child: Icon(icon, size: 18, color: KanvaColors.primary),
    ),
  );
}
