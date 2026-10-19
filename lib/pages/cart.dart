import 'package:flutter/material.dart';
import '../theme/theme.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final List<Map<String, dynamic>> _items = [
    {'name': 'Product 1', 'store': 'Kanva', 'price': 19999.0, 'qty': 1, 'image': 'assets/images/shirt.jpg'},
    {'name': 'Product 2', 'store': 'Kanva', 'price': 29999.0, 'qty': 1, 'image': 'assets/images/shirt.jpg'},
    {'name': 'Product 3', 'store': 'Kanva', 'price': 39999.0, 'qty': 2, 'image': 'assets/images/shirt.jpg'},
  ];

  double get _subtotal =>
      _items.fold(0, (sum, i) => sum + (i['price'] as double) * (i['qty'] as int));

  String _tzs(double v) => 'TZS ${v.toStringAsFixed(0)}';

  void _checkout() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Checkout coming soon'),
        backgroundColor: KanvaColors.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KanvaColors.background,
      appBar: const KAppBar(title: 'Kanva'),
      body: _items.isEmpty ? _empty() : _list(),
      bottomNavigationBar: _items.isEmpty ? null : _bottomBar(),
    );
  }

  Widget _empty() => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: KanvaColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.shopping_cart_outlined, color: KanvaColors.primary, size: 48),
        ),
        const SizedBox(height: 20),
        const Text('Your cart is empty',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: KanvaColors.textDark)),
        const SizedBox(height: 8),
        const Text('Browse items and add them here.',
            textAlign: TextAlign.center, style: TextStyle(color: KanvaColors.textLight, fontSize: 13)),
      ]),
    ),
  );

  Widget _list() => ListView.separated(
    padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
    itemCount: _items.length,
    separatorBuilder: (_, __) => const SizedBox(height: 12),
    itemBuilder: (_, i) {
      final item = _items[i];
      return KCard(
        padding: const EdgeInsets.all(12),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(item['image'] as String, width: 72, height: 72, fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 72, height: 72, color: KanvaColors.inputBg,
                child: const Icon(Icons.checkroom, color: KanvaColors.primary),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(item['name'] as String,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: KanvaColors.textDark)),
              const SizedBox(height: 2),
              Text(item['store'] as String,
                  style: const TextStyle(fontSize: 12, color: KanvaColors.textLight)),
              const SizedBox(height: 6),
              Text(_tzs(item['price'] as double),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: KanvaColors.primary)),
            ]),
          ),
          Column(children: [
            GestureDetector(
              onTap: () => setState(() => _items.removeAt(i)),
              child: const Icon(Icons.delete_outline, color: KanvaColors.error, size: 20),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: KanvaColors.inputBg,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(children: [
                _qtyBtn(Icons.remove, () {
                  setState(() {
                    if (item['qty'] > 1) {
                      item['qty']--;
                    } else {
                      _items.removeAt(i);
                    }
                  });
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text('${item['qty']}',
                      style: const TextStyle(fontWeight: FontWeight.w600, color: KanvaColors.textDark)),
                ),
                _qtyBtn(Icons.add, () => setState(() => item['qty']++)),
              ]),
            ),
          ]),
        ]),
      );
    },
  );

  Widget _qtyBtn(IconData icon, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(6),
      child: Icon(icon, size: 16, color: KanvaColors.primary),
    ),
  );

  Widget _bottomBar() => Container(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      boxShadow: [BoxShadow(color: Color(0x14000000), blurRadius: 16, offset: Offset(0, -4))],
    ),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text('Subtotal', style: TextStyle(fontSize: 14, color: KanvaColors.textMid)),
        Text(_tzs(_subtotal),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: KanvaColors.textDark)),
      ]),
      const SizedBox(height: 14),
      KButton(label: 'Checkout', icon: Icons.lock_outline, onTap: _checkout),
    ]),
  );
}
