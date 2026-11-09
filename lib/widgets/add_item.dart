import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/theme.dart';

class AddItem extends StatelessWidget {
  final int count;
  final ValueChanged<int> onChanged;
  final int min;
  final double width;

  const AddItem({
    super.key,
    required this.count,
    required this.onChanged,
    this.min = 1,
    this.width = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(color: KanvaColors.cream, borderRadius: BorderRadius.circular(40)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _btn(Icons.remove, () { if (count > min) onChanged(count - 1); }),
          Text('$count', style: GoogleFonts.inknutAntiqua(fontSize: 14)),
          _btn(Icons.add, () => onChanged(count + 1)),
        ],
      ),
    );
  }

  Widget _btn(IconData icon, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(color: KanvaColors.primary, shape: BoxShape.circle),
      child: Icon(icon, size: 14, color: KanvaColors.cream),
    ),
  );
}
