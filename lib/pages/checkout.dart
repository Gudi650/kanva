import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/theme.dart';

class Checkout extends StatelessWidget {
  final int items;
  final double subtotal;

  const Checkout({super.key, required this.items, required this.subtotal});

  String _tsh(double v) => 'Tsh ${v.toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return Scaffold(
      backgroundColor: KanvaColors.background,
      appBar: const KAppBar(title: 'Checkout'),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20, 16, 20, bottom + 24),
        children: [
          _card('Delivery', Icons.location_on_outlined, 'Home', 'Dar es Salaam, Tanzania'),
          const SizedBox(height: 12),
          _card('Payment', Icons.payments_outlined, 'Cash on delivery', 'Pay when it arrives'),
          const SizedBox(height: 12),
          KCard(
            child: Column(
              children: [
                _row('Items', '$items'),
                const SizedBox(height: 8),
                _row('Delivery', 'Free'),
                const SizedBox(height: 8),
                _row('Total', _tsh(subtotal), valueColor: KanvaColors.primary),
                const SizedBox(height: 16),
                KButton(label: 'Place order', color: KanvaColors.primary, onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _card(String title, IconData icon, String line, String sub) => KCard(
    child: Row(children: [
      Container(
        width: 44, height: 44,
        decoration: const BoxDecoration(color: KanvaColors.cream, shape: BoxShape.circle),
        child: Icon(icon, color: KanvaColors.primary, size: 20),
      ),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: GoogleFonts.inknutAntiqua(fontSize: 12, color: KanvaColors.textLight)),
        Text(line, style: GoogleFonts.inknutAntiqua(fontSize: 14, color: KanvaColors.textDark)),
        Text(sub, style: GoogleFonts.inknutAntiqua(fontSize: 12, color: KanvaColors.textMid)),
      ])),
      const Icon(Icons.chevron_right, color: KanvaColors.textLight),
    ]),
  );

  Widget _row(String label, String value, {Color? valueColor}) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: GoogleFonts.inknutAntiqua(fontSize: 14, color: KanvaColors.textMid)),
      Text(value, style: GoogleFonts.inknutAntiqua(fontSize: 16, color: valueColor ?? KanvaColors.textDark)),
    ],
  );
}
