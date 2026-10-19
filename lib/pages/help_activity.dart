import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'contact_activity.dart';

class HelpActivity extends StatefulWidget {
  const HelpActivity({super.key});

  @override
  State<HelpActivity> createState() => _HelpActivityState();
}

class _HelpActivityState extends State<HelpActivity> {
  final _searchCtrl = TextEditingController();
  int? _expanded;

  final _faqs = [
    {'q': 'How do I order clothes?', 'a': 'Browse styles, tap an item you like, choose your size and colour, then tap "Add to Cart". When you\'re ready, go to checkout, confirm your delivery address and payment method, and place your order.'},
    {'q': 'Can I cancel an order?', 'a': 'Orders can be cancelled within 24 hours for a full refund, as long as they have not shipped. After that, cancellation depends on the item status. Check the order details before requesting a cancel.'},
    {'q': 'What payment methods are accepted?', 'a': 'We accept M-Pesa, Tigopesa, Airtel Money, Visa/Mastercard debit and credit cards, and bank transfers.'},
    {'q': 'How is delivery handled?', 'a': 'After you place an order, we pack your items and send them to your delivery address. You will get tracking updates by email and SMS until the package arrives.'},
    {'q': 'How do I contact the seller?', 'a': 'After a confirmed order, a "Message Seller" button appears on your order details page. You can also reach support through Live Chat or Contact Support.'},
    {'q': 'What if the item doesn\'t match the listing?', 'a': 'Report the issue within 48 hours of delivery through our Complaints section. We will investigate and arrange a refund, exchange, or replacement if verified.'},
    {'q': 'Is my personal data secure?', 'a': 'Yes. We use SSL encryption and PCI-DSS compliant payment gateways. We never share your data with third parties for marketing purposes.'},
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _faqs
        .where((f) => f['q']!.toLowerCase().contains(_searchCtrl.text.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: KanvaColors.background,
      appBar: const KAppBar(title: 'Kanva'),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
            decoration: const BoxDecoration(
              color: KanvaColors.primary,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Help Center', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text('Find answers or contact our team', style: TextStyle(color: Colors.white70, fontSize: 13)),
              const SizedBox(height: 14),
              TextField(
                controller: _searchCtrl,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  fillColor: Colors.white, filled: true,
                  hintText: 'Search for help...',
                  prefixIcon: const Icon(Icons.search, color: KanvaColors.textLight),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ]),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              _QuickLink(icon: Icons.receipt_long_outlined, label: 'My Orders', onTap: () {}),
              const SizedBox(width: 10),
              _QuickLink(icon: Icons.local_shipping_outlined, label: 'Delivery', onTap: () {}),
              const SizedBox(width: 10),
              _QuickLink(icon: Icons.undo_outlined, label: 'Cancellations', onTap: () {}),
              const SizedBox(width: 10),
              _QuickLink(icon: Icons.chat_bubble_outline, label: 'Live Chat', onTap: () {}),
            ]),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const Text('Frequently Asked Questions',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: KanvaColors.textDark)),
                const SizedBox(height: 12),
                ...filtered.asMap().entries.map((e) {
                  final i = e.key;
                  final faq = e.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: KCard(padding: EdgeInsets.zero, child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      title: Text(faq['q']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: KanvaColors.textDark)),
                      trailing: Icon(_expanded == i ? Icons.remove_circle_outline : Icons.add_circle_outline, color: KanvaColors.primary),
                      onExpansionChanged: (v) => setState(() => _expanded = v ? i : null),
                      children: [Text(faq['a']!, style: const TextStyle(fontSize: 13, color: KanvaColors.textMid, height: 1.5))],
                    )),
                  );
                }),
                const SizedBox(height: 8),
                KCard(child: Column(children: [
                  const Text('Still need help?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: KanvaColors.textDark)),
                  const SizedBox(height: 8),
                  const Text('Our team is available Mon–Fri, 8am–6pm EAT',
                      textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: KanvaColors.textLight)),
                  const SizedBox(height: 16),
                  KButton(
                    label: 'Contact Support',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ContactActivity()),
                    ),
                  ),
                ])),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickLink extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _QuickLink({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) => Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: KCard(padding: const EdgeInsets.symmetric(vertical: 12), child: Column(children: [
        Icon(icon, color: KanvaColors.primary, size: 22),
        const SizedBox(height: 4),
        Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, color: KanvaColors.textMid, fontWeight: FontWeight.w500)),
      ])),
    ),
  );
}
