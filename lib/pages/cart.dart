import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/theme.dart';
import '../services/cart_service.dart';
import '../widgets/add_item.dart';
import '../widgets/skeleton.dart';
import 'checkout.dart';


class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final _service = CartService();
  List<Map<String, dynamic>> _items = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final rows = await _service.getCartItems();
      if (mounted) setState(() { _items = rows; _loading = false; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  Map _product(Map row) => (row['products'] as Map?) ?? {};
  double _price(Map row) => double.tryParse('${_product(row)['price']}') ?? 0;
  int _qty(Map row) => int.tryParse('${row['qty']}') ?? 1;

  double get _subtotal => _items.fold(0, (sum, i) => sum + _price(i) * _qty(i));
  int get _count => _items.fold(0, (sum, i) => sum + _qty(i));

  String _tsh(double v) => 'Tsh ${v.toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return Scaffold(
      backgroundColor: KanvaColors.background,
      appBar: const KAppBar(title: 'Kanva'),
      body: _loading
          ? ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                SkeletonBar(width: double.infinity, height: 96),
                SizedBox(height: 12),
                SkeletonBar(width: double.infinity, height: 96),
                SizedBox(height: 12),
                SkeletonBar(width: double.infinity, height: 96),
              ],
            )
          : Stack(
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
    separatorBuilder: (_, _) => const SizedBox(height: 12),
    itemBuilder: (_, i) {
      final item = _items[i];
      final product = _product(item);
      final id = '${item['product_id']}';
      return KCard(
        padding: const EdgeInsets.all(12),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset('assets/images/shirt.jpg', width: 84, height: 84, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('${product['name'] ?? ''}', style: GoogleFonts.inknutAntiqua(fontSize: 14, color: KanvaColors.textDark)),
              const SizedBox(height: 4),
              Text(_tsh(_price(item)), style: GoogleFonts.inknutAntiqua(fontSize: 13, color: KanvaColors.primary)),
              const SizedBox(height: 8),
              Row(children: [

                GestureDetector(
                  onTap: () async {
                    await _service.removeCartItem(id);
                    await _load();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: KanvaColors.error.withValues(alpha: 0.12), shape: BoxShape.circle),
                    child: const Icon(Icons.delete_outline, color: KanvaColors.error, size: 16),
                  ),
                ),

                const Spacer(),
                AddItem(
                  count: _qty(item),
                  min: 0,
                  onChanged: (n) async {
                    await _service.setQty(id, n);
                    await _load();
                  },
                ),
              ]),
            ]),
          ),
        ]),
      );
    },
  );

}
