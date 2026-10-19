import 'package:flutter/material.dart';
import '../theme/theme.dart';

class ContactActivity extends StatelessWidget {
  const ContactActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KanvaColors.background,
      appBar: const KAppBar(title: 'Kanva'),
      body: const Center(
        child: Text('Contact Us',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: KanvaColors.textDark)),
      ),
    );
  }
}
