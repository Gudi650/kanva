import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/theme.dart';
import '../widgets/add_item.dart';
import '../services/favourite_service.dart';

class ProductDetails extends StatefulWidget {
  final Map<String, String> product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String _size = 'M';
  int _qty = 1;
  int _color = 0;
  bool _more = false;
  final _favs = FavouriteService();
  bool _liked = false;
  final _sizes = const ['S', 'M', 'L', 'XL'];
  final _colors = const [
    KanvaColors.cream,
    KanvaColors.primary,
    Colors.black,
    Color(0xFFE53935),
  ];

  @override
  void initState() {
    super.initState();
    _loadLiked();
  }

  Future<void> _loadLiked() async {
    try {
      final rows = await _favs.getLoggedInUserFavourites();
      final id = widget.product['id'] ?? '';
      if (mounted) setState(() => _liked = rows.any((e) => '${e['product_id']}' == id));
    } catch (_) {}
  }

  Future<void> _toggleFav() async {
    final id = widget.product['id'] ?? '';
    if (id.isEmpty) return;
    if (_liked) {
      await _favs.removeFromFavourites(id);
    } else {
      await _favs.addToFavourites(id);
    }
    if (mounted) setState(() => _liked = !_liked);
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final top = MediaQuery.paddingOf(context).top;
    return Scaffold(
      backgroundColor: KanvaColors.background,
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.paddingOf(context).bottom + 90,
            ),
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.6,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      p['image'] ?? 'assets/images/shirt.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: KanvaColors.inputBg,
                        child: const Icon(
                          Icons.checkroom,
                          size: 64,
                          color: KanvaColors.primary,
                        ),
                      ),
                    ),
                    Positioned(
                      top: top + 8,
                      left: 16,
                      child: _circle(
                        Icons.arrow_back_ios_new,
                        () => Navigator.maybePop(context),
                      ),
                    ),
                    Positioned(
                      top: top + 8,
                      right: 16,
                      child: _circle(
                        _liked ? Icons.favorite : Icons.favorite_border,
                        _toggleFav,
                        iconColor: _liked
                            ? KanvaColors.pinkFav
                            : KanvaColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -32),
                child: Container(
                  decoration: const BoxDecoration(
                    color: KanvaColors.background,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              p['name'] ?? 'Item',
                              style: GoogleFonts.inknutAntiqua(
                                fontSize: 20,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: KanvaColors.cream,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'In stock',
                              style: GoogleFonts.inknutAntiqua(fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: KanvaColors.primary,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '4.8 (126)',
                            style: GoogleFonts.inknutAntiqua(
                              fontSize: 12,
                              color: KanvaColors.textMid,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Tsh 59.99',
                            style: GoogleFonts.inknutAntiqua(
                              fontSize: 12,
                              color: KanvaColors.textLight,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            p['price'] ?? '',
                            style: GoogleFonts.inknutAntiqua(
                              fontSize: 16,
                              color: KanvaColors.primary,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: KanvaColors.cream,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '-20%',
                              style: GoogleFonts.inknutAntiqua(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Text(
                            'Size',
                            style: GoogleFonts.inknutAntiqua(fontSize: 14),
                          ),
                          const SizedBox(width: 10),
                          ..._sizes.map((s) {
                            final sel = _size == s;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: GestureDetector(
                                onTap: () => setState(() => _size = s),
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: sel
                                      ? KanvaColors.primary
                                      : KanvaColors.cream,
                                  child: Text(
                                    s,
                                    style: GoogleFonts.inknutAntiqua(
                                      fontSize: 11,
                                      color: sel
                                          ? KanvaColors.cream
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text(
                            'Color',
                            style: GoogleFonts.inknutAntiqua(fontSize: 14),
                          ),
                          const SizedBox(width: 10),
                          ...List.generate(
                            _colors.length,
                            (i) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: GestureDetector(
                                onTap: () => setState(() => _color = i),
                                child: CircleAvatar(
                                  radius: _color == i ? 14 : 12,
                                  backgroundColor: _colors[i],
                                  child: _color == i
                                      ? Icon(
                                          Icons.check,
                                          size: 14,
                                          color: i == 0
                                              ? KanvaColors.primary
                                              : Colors.white,
                                        )
                                      : null,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          AddItem(
                            count: _qty,
                            width: 148,
                            onChanged: (n) => setState(() => _qty = n),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'About',
                        style: GoogleFonts.inknutAntiqua(fontSize: 14),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Cotton everyday wear. Soft fabric, regular fit. Machine wash cold. Made for everyday wear in Dar es Salaam.',
                        maxLines: _more ? null : 2,
                        overflow: _more
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                        style: GoogleFonts.inknutAntiqua(
                          fontSize: 13,
                          color: KanvaColors.textMid,
                          height: 1.5,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _more = !_more),
                        child: Text(
                          _more ? 'Show less' : 'Read more',
                          style: GoogleFonts.inknutAntiqua(
                            fontSize: 12,
                            color: KanvaColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: MediaQuery.paddingOf(context).bottom + 12,
            child: Row(
              children: [
                Expanded(
                  child: _action(
                    'Add to Cart',
                    KanvaColors.inputBg,
                    Colors.black,
                    () {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _action(
                    'Buy Now',
                    KanvaColors.primary,
                    KanvaColors.cream,
                    () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circle(
    IconData icon,
    VoidCallback onTap, {
    Color iconColor = KanvaColors.primary,
  }) => GestureDetector(
    onTap: onTap,
    child: Container(
      height: 44,
      width: 44,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: KanvaColors.cream,
      ),
      child: Icon(icon, size: 18, color: iconColor),
    ),
  );

  Widget _action(String label, Color bg, Color fg, VoidCallback onTap) =>
      SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: bg,
            foregroundColor: fg,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60),
            ),
          ),
          child: Text(
            label,
            style: GoogleFonts.inknutAntiqua(
              fontSize: 14,
              color: fg,
              letterSpacing: 0.5,
            ),
          ),
        ),
      );

}
