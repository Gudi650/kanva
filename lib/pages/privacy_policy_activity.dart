import 'package:flutter/material.dart';
import '../theme/theme.dart';

class PrivacyPolicyActivity extends StatelessWidget {
  const PrivacyPolicyActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KanvaColors.background,
      appBar: const KAppBar(title: 'Kanva'),
      body: const Center(
        child: Text('Privacy Policy',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: KanvaColors.textDark)),
      ),
    );
  }
}
