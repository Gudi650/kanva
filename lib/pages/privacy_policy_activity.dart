import 'package:flutter/material.dart';
import '../theme/theme.dart';

class PrivacyPolicyActivity extends StatelessWidget {
  const PrivacyPolicyActivity({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: Row(children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.shield_outlined, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Privacy Policy', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Last updated: June 2025', style: TextStyle(color: Colors.white70, fontSize: 12)),
              ])),
            ]),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                _PolicySection(title: '1. Information We Collect',
                    content: 'We collect your name, email, phone number, and location data when you register or book an apartment. Usage and device data help us improve your experience.'),
                _PolicySection(title: '2. How We Use Your Information',
                    content: 'Your data is used to process bookings, send notifications about your reservations, personalize apartment recommendations, and improve our services. We never sell your data.'),
                _PolicySection(title: '3. Data Sharing',
                    content: 'We share data only with property owners to confirm bookings, and with payment processors to handle transactions securely. All partners must maintain data confidentiality.'),
                _PolicySection(title: '4. Location Data',
                    content: 'Location access helps us show nearby apartments and accurate maps. You can disable this in device settings at any time without affecting core functionality.'),
                _PolicySection(title: '5. Data Security',
                    content: 'We use industry-standard TLS/SSL encryption for all data in transit. Payment data is handled through PCI-DSS compliant gateways. We do not store full card details.'),
                _PolicySection(title: '6. Your Rights',
                    content: 'You may access, correct, or delete your data at any time through Account Settings. You may also withdraw consent for marketing at any time.'),
                _PolicySection(title: '7. Cookies',
                    content: 'We use cookies to remember preferences and keep you signed in. Analytics cookies help us understand usage patterns. You can opt out through your device settings.'),
                _PolicySection(title: '8. Changes to Policy',
                    content: 'We will notify you of significant policy changes via app notification or email. Continued use after changes constitutes acceptance of the updated policy.'),
                _PolicySection(title: '9. Contact Us',
                    content: 'For privacy questions, contact privacy@kanva.co.tz or call +255 800 KANVA. Our Data Protection Officer is available Mon–Fri 8am–5pm EAT.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PolicySection extends StatelessWidget {
  final String title, content;
  const _PolicySection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: KCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: KanvaColors.primary)),
      const SizedBox(height: 8),
      Text(content, style: const TextStyle(fontSize: 13, color: KanvaColors.textMid, height: 1.6)),
    ])),
  );
}
