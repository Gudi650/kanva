/*import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Profile Page', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, letterSpacing: 2.0, fontFamily: 'Inknut Antiqua', color: Color.fromRGBO(85, 101, 175, 1.0))),
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import '../theme/theme.dart';

class AccountActivity extends StatelessWidget {
  const AccountActivity({super.key});

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
                  const Text('Godluck Mwambe',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text('godluck@example.com',
                      style: TextStyle(color: Colors.white70, fontSize: 13)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      _StatChip(label: 'Bookings', value: '6'),
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
                    child: Column(children: [
                      _InfoTile(icon: Icons.person_outline, label: 'Full Name', value: 'Godluck Mwambe'),
                      const Divider(height: 1, color: KanvaColors.divider),
                      _InfoTile(icon: Icons.email_outlined, label: 'Email', value: 'godluck@example.com'),
                      const Divider(height: 1, color: KanvaColors.divider),
                      _InfoTile(icon: Icons.phone_outlined, label: 'Phone', value: '+255 712 345 678'),
                      const Divider(height: 1, color: KanvaColors.divider),
                      _InfoTile(icon: Icons.location_on_outlined, label: 'Location', value: 'Dar es Salaam, Tanzania'),
                    ]),
                  ),

                  const SizedBox(height: 20),
                  const Text('Booking History',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: KanvaColors.textDark)),
                  const SizedBox(height: 12),
                  ...[
                    {'apt': 'Skyline Residences', 'date': 'Jun 1 – Jun 30, 2025', 'status': 'Active', 'statusColor': KanvaColors.success},
                    {'apt': 'Garden Apartments', 'date': 'Mar 1 – May 31, 2025', 'status': 'Completed', 'statusColor': KanvaColors.primary},
                  ].map((b) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: KCard(
                      child: Row(children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: KanvaColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.apartment_outlined, color: KanvaColors.primary),
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
                  KButton(label: 'Log Out', outline: true, onTap: () {}),
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