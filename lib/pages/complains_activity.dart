import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../services/api_service.dart';

class ComplainsActivity extends StatefulWidget {
  const ComplainsActivity({super.key});

  @override
  State<ComplainsActivity> createState() => _ComplainsActivityState();
}

class _ComplainsActivityState extends State<ComplainsActivity> with SingleTickerProviderStateMixin {
  late TabController _tab;
  final GlobalKey<_MyTabState> _myTabKey = GlobalKey<_MyTabState>();

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);

    _tab.addListener(() {
      if (_tab.index == 1) {
        _myTabKey.currentState?.loadComplaints();
      }
    });
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KanvaColors.background,
      appBar: AppBar(
        backgroundColor: KanvaColors.background,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: KanvaColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 16, color: KanvaColors.primary),
            ),
          ),
        ),
        title: const Text(
          'Kanva',
          style: TextStyle(color: KanvaColors.primary, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        bottom: TabBar(
          controller: _tab,
          labelColor: KanvaColors.primary,
          unselectedLabelColor: KanvaColors.textLight,
          indicatorColor: KanvaColors.primary,
          indicatorWeight: 3,
          tabs: const [Tab(text: 'Submit Complaint'), Tab(text: 'My Complaints')],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          _SubmitTab(onSuccess: () => _tab.animateTo(1)),
          _MyTab(key: _myTabKey),
        ],
      ),
    );
  }
}

class _SubmitTab extends StatefulWidget {
  final VoidCallback onSuccess;
  const _SubmitTab({required this.onSuccess});

  @override
  State<_SubmitTab> createState() => _SubmitTabState();
}

class _SubmitTabState extends State<_SubmitTab> {
  String _type = 'Booking Issue';
  final _descCtrl = TextEditingController();
  final _refCtrl = TextEditingController();
  bool _submitted = false;
  bool _isLoading = false;
  String _ticketNumber = '';

  final _types = ['Booking Issue', 'Wrong Listing', 'Property Condition', 'Payment Problem', 'Host Behaviour', 'Other'];

  Future<void> _submitComplaint() async {
    final desc = _descCtrl.text.trim();
    if (desc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please describe the issue in detail'), backgroundColor: KanvaColors.primary),
      );
      return;
    }

    setState(() => _isLoading = true);

    final response = await ApiService.submitComplaint(
      type: _type,
      bookingReference: _refCtrl.text.trim().isEmpty ? null : _refCtrl.text.trim(),
      description: desc,
    );

    if (mounted) {
      setState(() => _isLoading = false);
      if (response['success'] == true) {
        setState(() {
          _ticketNumber = response['ticket_number'];
          _submitted = true;
          _descCtrl.clear();
          _refCtrl.clear();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message']), backgroundColor: KanvaColors.primary),
        );
      }
    }
  }

  @override
  void dispose() {
    _descCtrl.dispose();
    _refCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_submitted) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: KanvaColors.success.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: const Icon(Icons.check_circle, color: KanvaColors.success, size: 64),
            ),
            const SizedBox(height: 20),
            const Text('Complaint Submitted', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: KanvaColors.textDark)),
            const SizedBox(height: 10),
            const Text('Our team will review within 24–48 hours.',
                textAlign: TextAlign.center, style: TextStyle(color: KanvaColors.textLight, fontSize: 13)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: KanvaColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
              child: Text(_ticketNumber, style: const TextStyle(color: KanvaColors.primary, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 28),
            KButton(
              label: 'View My Complaints',
              onTap: () {
                setState(() => _submitted = false);
                widget.onSuccess();
              },
            ),
          ]),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('What went wrong?', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: KanvaColors.textMid)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8, runSpacing: 8,
          children: _types.map((t) {
            final sel = _type == t;
            return GestureDetector(
              onTap: () => setState(() => _type = t),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: sel ? KanvaColors.primary : KanvaColors.inputBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(t, style: TextStyle(color: sel ? Colors.white : KanvaColors.textMid, fontSize: 13)),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 18),
        const KFormLabel('Booking Reference (Optional)'),
        TextField(controller: _refCtrl, decoration: const InputDecoration(prefixIcon: Icon(Icons.receipt_outlined), hintText: '#KNV-00000')),

        const SizedBox(height: 14),
        const KFormLabel('Describe the Issue'),
        TextField(controller: _descCtrl, maxLines: 5, decoration: const InputDecoration(hintText: 'Please describe your complaint in detail...')),

        const SizedBox(height: 14),
        KCard(child: Row(children: [
          Container(padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: KanvaColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.attach_file, color: KanvaColors.primary)),
          const SizedBox(width: 14),
          const Expanded(child: Text('Attach Photo / Video Evidence',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: KanvaColors.textDark))),
          const Icon(Icons.add_circle_outline, color: KanvaColors.primary),
        ])),

        const SizedBox(height: 24),
        if (_isLoading)
          const Center(child: CircularProgressIndicator(color: KanvaColors.primary))
        else
          KButton(
            label: 'Submit Complaint',
            onTap: _submitComplaint,
          ),
        const SizedBox(height: 32),
      ]),
    );
  }
}

class _MyTab extends StatefulWidget {
  const _MyTab({super.key});

  @override
  State<_MyTab> createState() => _MyTabState();
}

class _MyTabState extends State<_MyTab> {
  List<Map<String, dynamic>> _complaints = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadComplaints();
  }

  Future<void> loadComplaints() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    final data = await ApiService.getComplaints();

    if (mounted) {
      setState(() {
        _complaints = data;
        _isLoading = false;
      });
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'resolved':
        return Colors.green;
      case 'in review':
      case 'review':
        return Colors.orange;
      case 'closed':
        return Colors.grey;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: KanvaColors.primary));
    }

    if (_complaints.isEmpty) {
      return const Center(
        child: Text(
          'No complaints filed yet.',
          style: TextStyle(color: KanvaColors.textLight, fontSize: 14),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: loadComplaints,
      color: KanvaColors.primary,
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: _complaints.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) {
          final c = _complaints[i];
          final ticketNumber = c['ticket_number']?.toString() ?? '#KNV-XXXXX';
          final type = c['type']?.toString() ?? 'Issue';
          final status = c['status']?.toString() ?? 'Pending';

          String displayDate = 'Recently';
          if (c['created_at'] != null) {
            try {
              final dateTime = DateTime.parse(c['created_at'].toString());
              displayDate = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
            } catch (_) {}
          }

          final statusColor = _getStatusColor(status);

          return KCard(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: KanvaColors.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.report_problem_outlined, color: KanvaColors.primary, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(type, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: KanvaColors.textDark)),
                      const SizedBox(height: 3),
                      Text('$ticketNumber · $displayDate', style: const TextStyle(fontSize: 12, color: KanvaColors.textLight)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status.toUpperCase(),
                    style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
