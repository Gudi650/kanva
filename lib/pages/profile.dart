import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'logout.dart';
import 'shop/shop_hub.dart';
import '../services/profile_service.dart';
import '../widgets/skeleton.dart';

class AccountActivity extends StatefulWidget {
  const AccountActivity({super.key});

  @override
  State<AccountActivity> createState() => _AccountActivityState();
}

class _AccountActivityState extends State<AccountActivity> {

  Map<String, dynamic> _profile = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final row = await ProfileService().getProfile();
    if (mounted) setState(() { _profile = row; _loading = false; });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KanvaColors.background,
      appBar: const KAppBar(title: 'Kanva'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
              decoration: const BoxDecoration(
                color: KanvaColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 46,
                        backgroundColor: KanvaColors.accent,
                        child: const Icon(Icons.person, size: 48, color: KanvaColors.primary),
                      ),
                      Positioned(
                        bottom: 0, right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: const Icon(Icons.edit, size: 14, color: KanvaColors.primary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (_loading) ...[
                    const SkeletonBar(width: 160, height: 18, color: KanvaColors.cream),
                    const SizedBox(height: 8),
                    const SkeletonBar(width: 120, height: 12, color: KanvaColors.cream),
                  ] else ...[
                    Text('${_profile['full_name'] ?? ''}',
                        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('${_profile['email'] ?? ''}',
                        style: const TextStyle(color: Colors.white70, fontSize: 13)),
                  ],
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      _StatChip(label: 'Orders', value: '6'),
                      SizedBox(width: 24),
                      _StatChip(label: 'Saved', value: '12'),
                      SizedBox(width: 24),
                      _StatChip(label: 'Reviews', value: '4'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Personal Info',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: KanvaColors.textDark)),
                  const SizedBox(height: 12),
                  KCard(
                    padding: EdgeInsets.zero,
                    child: _loading
                        ? Column(children: [
                            for (var i = 0; i < 4; i++) ...[
                              const ListTile(
                                leading: CircleAvatar(radius: 11, backgroundColor: KanvaColors.divider),
                                title: Align(alignment: Alignment.centerLeft, child: SkeletonBar(width: 150, height: 14)),
                              ),
                              if (i < 3) const Divider(height: 1, color: KanvaColors.divider),
                            ],
                          ])
                        : Column(children: [
                      _InfoTile(icon: Icons.person_outline, label: 'Full Name', value: '${_profile['full_name'] ?? ''}'),
                      const Divider(height: 1, color: KanvaColors.divider),
                      _InfoTile(icon: Icons.email_outlined, label: 'Email', value: '${_profile['email'] ?? ''}'),
                      const Divider(height: 1, color: KanvaColors.divider),
                      _InfoTile(icon: Icons.phone_outlined, label: 'Phone', value: '${_profile['phone'] ?? ''}'),
                      const Divider(height: 1, color: KanvaColors.divider),
                      _InfoTile(icon: Icons.location_on_outlined, label: 'Location', value: '${_profile['location'] ?? 'Location Adress'}'),
                    ]),
                  ),

                  const SizedBox(height: 20),
                  const Text('Shop',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: KanvaColors.textDark)),
                  const SizedBox(height: 12),
                  KCard(
                    padding: EdgeInsets.zero,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ShopHub())),
                    child: const ListTile(
                      leading: Icon(Icons.storefront_outlined, color: KanvaColors.primary),
                      title: Text('My shop', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: KanvaColors.textDark)),
                      subtitle: Text('Post products and track sales', style: TextStyle(fontSize: 12, color: KanvaColors.textLight)),
                      trailing: Icon(Icons.chevron_right, color: KanvaColors.textLight, size: 20),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Order History',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: KanvaColors.textDark)),
                  const SizedBox(height: 12),
                  ...[
                    {'apt': 'Linen Shirt', 'date': 'Ordered Jun 12, 2026', 'status': 'Shipped', 'statusColor': KanvaColors.success},
                    {'apt': 'Denim Jacket', 'date': 'Ordered Mar 8, 2026', 'status': 'Delivered', 'statusColor': KanvaColors.primary},
                  ].map((b) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: KCard(
                      child: Row(children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: KanvaColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.checkroom_outlined, color: KanvaColors.primary),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(b['apt'] as String,
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: KanvaColors.textDark)),
                          Text(b['date'] as String, style: const TextStyle(fontSize: 12, color: KanvaColors.textLight)),
                        ])),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                              color: (b['statusColor'] as Color).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(b['status'] as String,
                              style: TextStyle(color: b['statusColor'] as Color, fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                      ]),
                    ),
                  )),

                  const SizedBox(height: 12),
                  KButton(label: 'Save Changes', onTap: () {}),
                  const SizedBox(height: 12),
                  KButton(
                    label: 'Log Out',
                    color: KanvaColors.error,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Logout())),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label, value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Column(children: [
    Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
    Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
  ]);
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;

  const _InfoTile({required this.icon, required this.label, this.value});

  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(icon, color: KanvaColors.primary, size: 22),
    title: Text(label, style: const TextStyle(fontSize: 12, color: KanvaColors.textMid)),
    subtitle: value != null
        ? Text(value!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: KanvaColors.textDark))
        : null,
    trailing: const Icon(Icons.chevron_right, color: KanvaColors.textLight, size: 20),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
  );
}