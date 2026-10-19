import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'settings.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KanvaColors.background,
      appBar: const KAppBar(title: 'Kanva'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          KCard(
            padding: EdgeInsets.zero,
            child: ListTile(
              leading: const Icon(Icons.settings_outlined, color: KanvaColors.primary),
              title: const Text('Settings',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: KanvaColors.textDark)),
              trailing: const Icon(Icons.chevron_right, color: KanvaColors.textLight),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsActivity()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
