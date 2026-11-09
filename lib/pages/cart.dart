import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/theme.dart';
import '../widgets/add_item.dart';
import 'checkout.dart';


class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final List<Map<String, dynamic>> _items = [
    {'name': 'Product 1', 'store': 'Kanva', 'price': 19.99, 'qty': 1, 'image': 'assets/images/shirt.jpg'},
    {'name': 'Product 2', 'store': 'Kanva', 'price': 29.99, 'qty': 1, 'image': 'assets/images/shirt.jpg'},
    {'name': 'Product 3', 'store': 'Kanva', 'price': 39.99, 'qty': 2, 'image': 'assets/images/shirt.jpg'},
  ];

  double get _subtotal => _items.fold(0, (sum, i) => sum + (i['price'] as double) * (i['qty'] as int));
  int get _count => _items.fold(0, (sum, i) => sum + (i['qty'] as int));

  String _tsh(double v) => 'Tsh ${v.toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return Scaffold(
      backgroundColor: KanvaColors.background,
      appBar: const KAppBar(title: 'Kanva'),
      body: Stack(
        children: [
          _items.isEmpty ? _empty() : _list(bottom),
          if (_items.isNotEmpty)
            Positioned(
              left: 20,
              right: 20,
              bottom: bottom + 88,
              child: KCard(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text('Items', style: GoogleFonts.inknutAntiqua(fontSize: 14, color: KanvaColors.textMid)),
                      Text('$_count', style: GoogleFonts.inknutAntiqua(fontSize: 16, color: KanvaColors.textDark)),
                    ]),
                    const SizedBox(height: 8),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text('Subtotal', style: GoogleFonts.inknutAntiqua(fontSize: 14, color: KanvaColors.textMid)),
                      Text(_tsh(_subtotal), style: GoogleFonts.inknutAntiqua(fontSize: 16, color: KanvaColors.primary)),
                    ]),
                    const SizedBox(height: 12),
                    KButton(
                      label: 'Checkout',
                      color: KanvaColors.primary,
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (_) => Checkout(items: _count, subtotal: _subtotal),
                      )),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _empty() => Center(
    child: Text('Your cart is empty', style: GoogleFonts.inknutAntiqua(fontSize: 16, color: KanvaColors.textMid)),
  );

  Widget _list(double bottom) => ListView.separated(
    padding: EdgeInsets.fromLTRB(20, 12, 20, bottom + 230),
    itemCount: _items.length,
    separatorBuilder: (_, __) => const SizedBox(height: 12),
    itemBuilder: (_, i) {
      final item = _items[i];
      return KCard(
        padding: const EdgeInsets.all(12),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(item['image'] as String, width: 84, height: 84, fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 84, height: 84, color: KanvaColors.inputBg,
                child: const Icon(Icons.checkroom, color: KanvaColors.primary),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(item['name'] as String, style: GoogleFonts.inknutAntiqua(fontSize: 14, color: KanvaColors.textDark)),
              const SizedBox(height: 4),
              Text(_tsh(item['price'] as double), style: GoogleFonts.inknutAntiqua(fontSize: 13, color: KanvaColors.primary)),
              const SizedBox(height: 8),
              Row(children: [

                GestureDetector(
                  onTap: () => setState(() => _items.removeAt(i)),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: KanvaColors.error.withValues(alpha: 0.12), shape: BoxShape.circle),
                    child: const Icon(Icons.delete_outline, color: KanvaColors.error, size: 16),
                  ),
                ),

                const Spacer(),
                AddItem(
                  count: item['qty'] as int,
                  min: 0,
                  onChanged: (n) => setState(() {
                    if (n < 1) {
                      _items.removeAt(i);
                    } else {
                      item['qty'] = n;
                    }
                  }),
                ),
              ]),
            ]),
          ),
        ]),
      );
    },
  );

}
