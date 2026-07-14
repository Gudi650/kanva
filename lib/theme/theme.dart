import 'package:flutter/material.dart';

class KanvaColors {
  static const Color primary = Color(0xFF5B6BBF);
  static const Color primaryLight = Color(0xFF7B8ED4);
  static const Color primaryDark = Color(0xFF3D4D9E);
  static const Color accent = Color(0xFFF5EFB8);
  static const Color background = Color(0xFFF0F0F8);
  static const Color pinkFav = Color(0xFFE91E8C);
  static const Color textDark = Color(0xFF1A1A2E);
  static const Color textMid = Color(0xFF4A4A6A);
  static const Color textLight = Color(0xFF9090B0);
  static const Color inputBg = Color(0xFFE8E8F4);
  static const Color divider = Color(0xFFD8D8EE);
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA726);
  static const Color starYellow = Color(0xFFFFC107);
}

ThemeData kanvaTheme() {
  return ThemeData(
    scaffoldBackgroundColor: KanvaColors.background,
    primaryColor: KanvaColors.primary,
    colorScheme: const ColorScheme.light(
      primary: KanvaColors.primary,
      secondary: KanvaColors.accent,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: KanvaColors.background,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: KanvaColors.primary),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: KanvaColors.inputBg,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: KanvaColors.primary, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: const TextStyle(color: KanvaColors.textLight, fontSize: 14),
      prefixIconColor: KanvaColors.textMid,
      suffixIconColor: KanvaColors.textMid,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: KanvaColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 0,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
  );
}

// ─── Shared Widgets ──────────────────────────────────────────────────────────

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final List<Widget>? actions;

  const KAppBar({super.key, this.title = 'Kanva', this.showBack = true, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: KanvaColors.background,
      elevation: 0,
      centerTitle: true,
      leading: showBack
          ? GestureDetector(
              onTap: () => Navigator.maybePop(context),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: KanvaColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back_ios_new, size: 16, color: KanvaColors.primary),
                ),
              ),
            )
          : null,
      title: Text(title,
          style: const TextStyle(
              color: KanvaColors.primary, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class KButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool outline;
  final IconData? icon;
  final Color? color;

  const KButton({super.key, required this.label, this.onTap, this.outline = false, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    final bg = color ?? KanvaColors.primary;
    if (outline) {
      return SizedBox(
        width: double.infinity,
        height: 50,
        child: OutlinedButton(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
            foregroundColor: bg,
            side: BorderSide(color: bg, width: 1.5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[Icon(icon, size: 18), const SizedBox(width: 8)],
              Text(label),
            ],
          ),
        ),
      );
    }
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 0,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[Icon(icon, size: 18), const SizedBox(width: 8)],
            Text(label),
          ],
        ),
      ),
    );
  }
}

class KCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double radius;
  final VoidCallback? onTap;

  const KCard({super.key, required this.child, this.padding, this.radius = 16, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            boxShadow: [
              BoxShadow(
                  color: KanvaColors.primary.withOpacity(0.07),
                  blurRadius: 12,
                  offset: const Offset(0, 4))
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

class KFormLabel extends StatelessWidget {
  final String text;
  const KFormLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: KanvaColors.textMid)),
      );
}

class KSectionHeader extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onAction;

  const KSectionHeader(this.title, {super.key, this.action, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: KanvaColors.textDark)),
        if (action != null)
          GestureDetector(
            onTap: onAction,
            child: Text(action!,
                style: const TextStyle(color: KanvaColors.primary, fontSize: 13, fontWeight: FontWeight.w500)),
          ),
      ],
    );
  }
}

//BottomNavigation bar
class KBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const KBottomNav({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    
    final items = [
      (Icons.home_outlined, Icons.home, 'Home'),
      (Icons.search_outlined, Icons.search, 'Search'),
      (Icons.favorite_outline, Icons.favorite, 'Saved'),
      (Icons.more_horiz, Icons.more_horiz, 'More'),
    ];

    return Container(
      height: 72,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        color: KanvaColors.inputBg,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [BoxShadow(color: KanvaColors.primary.withOpacity(0.08), blurRadius: 16, offset: const Offset(0, 4))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.asMap().entries.map((e) {
          final i = e.key;
          final item = e.value;
          final selected = currentIndex == i;
          return GestureDetector(
            onTap: () => onTap(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: selected ? KanvaColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(selected ? item.$2 : item.$1,
                      color: selected ? Colors.white : KanvaColors.textLight, size: 22),
                  if (selected) ...[
                    const SizedBox(width: 6),
                    Text(item.$3,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                  ],
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// Social sign-in button
class KSocialBtn extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const KSocialBtn({super.key, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
            border: Border.all(color: KanvaColors.divider),
            borderRadius: BorderRadius.circular(14),
            color: Colors.white),
        child: Center(
          child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 20)),
        ),
      ),
    );
  }
}

// Divider with text
class KDividerText extends StatelessWidget {
  final String text;
  const KDividerText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: KanvaColors.divider)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(text, style: const TextStyle(color: KanvaColors.textLight, fontSize: 12)),
        ),
        const Expanded(child: Divider(color: KanvaColors.divider)),
      ],
    );
  }
}

// Error banner
class KErrorBanner extends StatelessWidget {
  final String message;
  const KErrorBanner(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: KanvaColors.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: KanvaColors.error.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: KanvaColors.error, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(message, style: const TextStyle(color: KanvaColors.error, fontSize: 13))),
        ],
      ),
    );
  }
}