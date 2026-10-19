import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'privacy_policy_activity.dart';
import 'help_activity.dart';
import 'contact_activity.dart';
import 'complains_activity.dart';
import 'user_feedback_activity.dart';

class SettingsActivity extends StatefulWidget {
  const SettingsActivity({super.key});

  @override
  State<SettingsActivity> createState() => _SettingsActivityState();
}

class _SettingsActivityState extends State<SettingsActivity> {
  bool _notifications = true;
  bool _emailUpdates = false;
  bool _darkMode = false;
  bool _biometrics = true;
  String _currency = 'TZS';
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KanvaColors.background,
      appBar: const KAppBar(title: 'Kanva'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: KanvaColors.textDark,
            ),
          ),
          const SizedBox(height: 20),

          _SectionLabel('Notifications'),
          KCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _ToggleTile(
                  icon: Icons.notifications_outlined,
                  title: 'Push Notifications',
                  subtitle: 'Booking updates & alerts',
                  value: _notifications,
                  onChanged: (v) => setState(() => _notifications = v),
                ),
                const Divider(height: 1, color: KanvaColors.divider),
                _ToggleTile(
                  icon: Icons.email_outlined,
                  title: 'Email Updates',
                  subtitle: 'Newsletters & promotions',
                  value: _emailUpdates,
                  onChanged: (v) => setState(() => _emailUpdates = v),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          _SectionLabel('Appearance'),
          KCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _ToggleTile(
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark Mode',
                  subtitle: 'Switch to dark theme',
                  value: _darkMode,
                  onChanged: (v) => setState(() => _darkMode = v),
                ),
                const Divider(height: 1, color: KanvaColors.divider),
                _SelectTile(
                  icon: Icons.language_outlined,
                  title: 'Language',
                  value: _language,
                  options: const ['English', 'Swahili', 'French'],
                  onSelected: (v) => setState(() => _language = v),
                ),
                const Divider(height: 1, color: KanvaColors.divider),
                _SelectTile(
                  icon: Icons.attach_money_outlined,
                  title: 'Currency',
                  value: _currency,
                  options: const ['TZS', 'USD', 'KES', 'EUR'],
                  onSelected: (v) => setState(() => _currency = v),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          _SectionLabel('Security'),
          KCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _ToggleTile(
                  icon: Icons.fingerprint,
                  title: 'Biometric Login',
                  subtitle: 'Fingerprint or Face ID',
                  value: _biometrics,
                  onChanged: (v) => setState(() => _biometrics = v),
                ),
                const Divider(height: 1, color: KanvaColors.divider),
                _NavTile(
                  icon: Icons.lock_outline,
                  title: 'Change Password',
                  onTap: () {},
                ),
                const Divider(height: 1, color: KanvaColors.divider),
                _NavTile(
                  icon: Icons.devices_outlined,
                  title: 'Manage Devices',
                  onTap: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          _SectionLabel('Support'),
          KCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _NavTile(
                  icon: Icons.help_outline,
                  title: 'Help Center',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HelpActivity()),
                  ),
                ),
                const Divider(height: 1, color: KanvaColors.divider),
                _NavTile(
                  icon: Icons.contact_support_outlined,
                  title: 'Contact Us',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ContactActivity()),
                  ),
                ),
                const Divider(height: 1, color: KanvaColors.divider),
                _NavTile(
                  icon: Icons.report_problem_outlined,
                  title: 'Complaints',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ComplainsActivity(),
                    ),
                  ),
                ),
                const Divider(height: 1, color: KanvaColors.divider),
                _NavTile(
                  icon: Icons.star_outline,
                  title: 'Give Feedback',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const UserFeedbackActivity(),
                    ),
                  ),
                ),
                const Divider(height: 1, color: KanvaColors.divider),
                _NavTile(
                  icon: Icons.shield_outlined,
                  title: 'Privacy Policy',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PrivacyPolicyActivity(),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String title;
  const _SectionLabel(this.title);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8, left: 4),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: KanvaColors.primary,
        letterSpacing: 0.8,
      ),
    ),
  );
}

class _ToggleTile extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _ToggleTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => SwitchListTile(
    secondary: Icon(icon, color: KanvaColors.primary, size: 22),
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: KanvaColors.textDark,
      ),
    ),
    subtitle: Text(
      subtitle,
      style: const TextStyle(fontSize: 12, color: KanvaColors.textLight),
    ),
    value: value,
    onChanged: onChanged,
    activeThumbColor: KanvaColors.primary,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
  );
}

class _NavTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  const _NavTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(icon, color: KanvaColors.primary, size: 22),
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: KanvaColors.textDark,
      ),
    ),
    subtitle: subtitle != null
        ? Text(
            subtitle!,
            style: const TextStyle(fontSize: 12, color: KanvaColors.textLight),
          )
        : null,
    trailing: const Icon(Icons.chevron_right, color: KanvaColors.textLight),
    onTap: onTap,
  );
}

class _SelectTile extends StatelessWidget {
  final IconData icon;
  final String title, value;
  final List<String> options;
  final ValueChanged<String> onSelected;
  const _SelectTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.options,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(icon, color: KanvaColors.primary, size: 22),
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: KanvaColors.textDark,
      ),
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 13, color: KanvaColors.primary),
        ),
        const Icon(Icons.chevron_right, color: KanvaColors.textLight),
      ],
    ),
    onTap: () => showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(height: 16),
          Center(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: KanvaColors.textDark,
              ),
            ),
          ),
          const SizedBox(height: 8),
          ...options.map(
            (o) => ListTile(
              title: Text(o),
              trailing: o == value
                  ? const Icon(Icons.check, color: KanvaColors.primary)
                  : null,
              onTap: () {
                onSelected(o);
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );
}
