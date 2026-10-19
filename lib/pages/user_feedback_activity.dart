import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../services/api_service.dart';

class UserFeedbackActivity extends StatefulWidget {
  const UserFeedbackActivity({super.key});

  @override
  State<UserFeedbackActivity> createState() => _UserFeedbackActivityState();
}

class _UserFeedbackActivityState extends State<UserFeedbackActivity> {
  int _rating = 0;
  String _category = 'General';
  final _msgCtrl = TextEditingController();
  bool _submitted = false;
  bool _loading = false;

  final _categories = ['General', 'App Experience', 'Booking Process', 'Property Quality', 'Support'];

  Future<void> _handleSubmit() async {
    if (_rating <= 0 || _msgCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a rating and write a message'),
          backgroundColor: KanvaColors.error,
        ),
      );
      return;
    }

    setState(() => _loading = true);

    final result = await ApiService.submitFeedback(
      rating: _rating,
      category: _category,
      message: _msgCtrl.text.trim(),
    );

    if (mounted) {
      setState(() => _loading = false);

      if (result['success'] == true) {
        setState(() => _submitted = true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message']),
            backgroundColor: KanvaColors.error,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _msgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KanvaColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: KanvaColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Kanva Feedback',
          style: TextStyle(color: KanvaColors.textDark, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: _submitted ? _success() : _form(),
    );
  }

  Widget _success() => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: KanvaColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_circle_outline, color: KanvaColors.primary, size: 64),
          ),
          const SizedBox(height: 24),
          const Text('Thank You!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: KanvaColors.textDark)),
          const SizedBox(height: 10),
          const Text('Your feedback helps us improve Kanva for everyone.',
              textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: KanvaColors.textLight)),
          const SizedBox(height: 32),
          KButton(label: 'Back to Home', onTap: () => Navigator.pop(context)),
        ],
      ),
    ),
  );

  Widget _form() => SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Share your Feedback', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: KanvaColors.textDark)),
        const SizedBox(height: 6),
        const Text("We'd love to hear what you think", style: TextStyle(fontSize: 14, color: KanvaColors.textLight)),
        const SizedBox(height: 24),

        KCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('How was your experience?',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: KanvaColors.textDark)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) {
              final star = i + 1;
              return GestureDetector(
                onTap: () => setState(() => _rating = star),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(
                    _rating >= star ? Icons.star : Icons.star_border,
                    color: _rating >= star ? KanvaColors.starYellow : KanvaColors.textLight,
                    size: 40,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              ['Tap a star to rate', 'Poor', 'Fair', 'Good', 'Very Good', 'Excellent!'][_rating],
              style: TextStyle(
                  fontSize: 13,
                  color: _rating == 0 ? KanvaColors.textLight : KanvaColors.primary,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ])),

        const SizedBox(height: 16),
        const KFormLabel('Category'),
        SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) {
              final c = _categories[i];
              final sel = _category == c;
              return GestureDetector(
                onTap: () => setState(() => _category = c),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: sel ? KanvaColors.primary : KanvaColors.inputBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(c,
                      style: TextStyle(color: sel ? Colors.white : KanvaColors.textMid, fontSize: 13, fontWeight: FontWeight.w500)),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 16),
        const KFormLabel('Your Message'),
        TextField(
          controller: _msgCtrl,
          maxLines: 5,
          decoration: const InputDecoration(hintText: 'Tell us about your experience...'),
        ),

        const SizedBox(height: 14),
        KCard(child: Row(children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: KanvaColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.image_outlined, color: KanvaColors.primary, size: 22),
          ),
          const SizedBox(width: 14),
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Attach a Screenshot', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: KanvaColors.textDark)),
            Text('Optional – helps us understand better', style: TextStyle(fontSize: 12, color: KanvaColors.textLight)),
          ])),
          const Icon(Icons.add_circle_outline, color: KanvaColors.primary),
        ])),

        const SizedBox(height: 28),
        if (_loading)
          const Center(child: CircularProgressIndicator(color: KanvaColors.primary))
        else
          KButton(
            label: 'Submit Feedback',
            onTap: _handleSubmit,
          ),
        const SizedBox(height: 32),
      ],
    ),
  );
}
