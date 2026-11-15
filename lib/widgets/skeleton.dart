import 'package:flutter/material.dart';
import '../theme/theme.dart';

class SkeletonChips extends StatelessWidget {
  const SkeletonChips({super.key});

  @override
  Widget build(BuildContext context) {
    return _Pulse(
      builder: (fade) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            5,
            (_) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              child: _box(fade, 88, 36, 20),
            ),
          ),
        ),
      ),
    );
  }
}

class SkeletonCards extends StatelessWidget {
  const SkeletonCards({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 276,
      child: _Pulse(
        builder: (fade) => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (_, _) => Container(
            width: 200,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: KanvaColors.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _box(fade, double.infinity, 150, 12),
                const SizedBox(height: 12),
                _box(fade, 120, 16, 8),
                const SizedBox(height: 8),
                _box(fade, 80, 12, 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _box(Animation<double> fade, double width, double height, double radius, [Color color = KanvaColors.divider]) {
  return FadeTransition(
    opacity: fade,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
    ),
  );
}

class SkeletonBar extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  const SkeletonBar({super.key, required this.width, this.height = 14, this.color = KanvaColors.divider});

  @override
  Widget build(BuildContext context) {
    return _Pulse(builder: (fade) => _box(fade, width, height, 8, color));
  }
}

class _Pulse extends StatefulWidget {
  final Widget Function(Animation<double> fade) builder;
  const _Pulse({required this.builder});

  @override
  State<_Pulse> createState() => _PulseState();
}

class _PulseState extends State<_Pulse> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _fade = Tween(begin: 0.4, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_fade);
  }
}
