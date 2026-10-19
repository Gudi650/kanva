import 'package:flutter/material.dart';
import '../theme/theme.dart';

class ComplainsActivity extends StatelessWidget {
  const ComplainsActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KanvaColors.background,
      appBar: const KAppBar(title: 'Kanva'),
      body: const Center(
        child: Text('Complaints',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: KanvaColors.textDark)),
      ),
    );
  }
}
