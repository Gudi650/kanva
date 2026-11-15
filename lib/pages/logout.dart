import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/theme.dart';
import '../services/auth_service.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KanvaColors.background,
      appBar: const KAppBar(title: 'Log out'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
        child: KCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72, height: 72,
                decoration: const BoxDecoration(color: KanvaColors.cream, shape: BoxShape.circle),
                child: const Icon(Icons.logout, color: KanvaColors.primary, size: 32),
              ),
              const SizedBox(height: 16),
              Text('Leave Kanva?', style: GoogleFonts.inknutAntiqua(fontSize: 20, color: KanvaColors.textDark)),
              const SizedBox(height: 8),
              Text(
                'You can sign in again anytime.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inknutAntiqua(fontSize: 13, color: KanvaColors.textMid),
              ),
              const SizedBox(height: 20),
              KButton(
                label: 'Log out',
                color: KanvaColors.error,
                onTap: () => AuthService().signOut(context),
              ),
              const SizedBox(height: 12),
              KButton(label: 'Stay', onTap: () => Navigator.pop(context)),
            ],
          ),
        ),
      ),
    );
  }
}
