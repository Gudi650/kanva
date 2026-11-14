import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class ShopHub extends StatelessWidget {
  const ShopHub({super.key});

  static const _orders = [
    {'item': 'Linen Shirt', 'buyer': 'Amina K.', 'amount': 'TSh 45,000', 'status': 'New', 'color': KanvaColors.warning},
    {'item': 'Denim Jacket', 'buyer': 'John M.', 'amount': 'TSh 85,000', 'status': 'Shipped', 'color': KanvaColors.success},
    {'item': 'Canvas Bag', 'buyer': 'Neema S.', 'amount': 'TSh 28,000', 'status': 'Delivered', 'color': KanvaColors.primary},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KanvaColors.background,
      appBar: const KAppBar(title: 'My Shop'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
              decoration: const BoxDecoration(
                color: KanvaColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 36,
                    backgroundColor: KanvaColors.accent,
                    child: Icon(Icons.storefront, size: 36, color: KanvaColors.primary),
                  ),
                  const SizedBox(height: 12),
                  const Text('Kanva Studio',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text('Dar es Salaam',
                      style: TextStyle(color: Colors.white70, fontSize: 13)),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _Stat(label: 'Orders', value: '18'),
                      SizedBox(width: 28),
                      _Stat(label: 'Revenue', value: '1.2M'),
                      SizedBox(width: 28),
                      _Stat(label: 'Products', value: '9'),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: KButton(
                          label: 'Post',
                          icon: Icons.add,
                          color: KanvaColors.primary,
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: KButton(
                          label: 'Edit',
                          icon: Icons.edit_outlined,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text('Recent orders',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: KanvaColors.textDark)),
                  const SizedBox(height: 12),
                  ..._orders.map((o) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: KCard(
                          onTap: () {},
                          child: Row(children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: KanvaColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.receipt_long_outlined, color: KanvaColors.primary),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(o['item'] as String,
                                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: KanvaColors.textDark)),
                                Text('${o['buyer']} · ${o['amount']}',
                                    style: const TextStyle(fontSize: 12, color: KanvaColors.textLight)),
                              ]),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: (o['color'] as Color).withOpacity(0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(o['status'] as String,
                                  style: TextStyle(color: o['color'] as Color, fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ]),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label, value;
  const _Stat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Column(children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ]);
}
