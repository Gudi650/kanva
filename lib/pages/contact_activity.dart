import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/theme.dart';
import '../services/api_service.dart';

class ContactActivity extends StatefulWidget {
  const ContactActivity({super.key});

  @override
  State<ContactActivity> createState() => _ContactActivityState();
}

class _ContactActivityState extends State<ContactActivity> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();
  bool _isLoading = false;

  void _showCallConfirmation(BuildContext context, String phoneNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'Call Help Center?',
            style: TextStyle(fontWeight: FontWeight.bold, color: KanvaColors.textDark),
          ),
          content: Text(
            'Are you sure you want to call Kanva Help Center at $phoneNumber?',
            style: const TextStyle(color: KanvaColors.textMid),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: KanvaColors.textLight)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: KanvaColors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Navigator.pop(context);
                _makeCall(phoneNumber);
              },
              child: const Text('Call Now', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _makeCall(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber.replaceAll(' ', ''));
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      _showErrorSnackBar('Could not open dialer for $phoneNumber');
    }
  }

  Future<void> _openWhatsApp(String phoneNumber) async {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[+\s]'), '');
    final Uri url = Uri.parse("https://wa.me/$cleanNumber?text=Hello%20Kanva%20Support,%20I%20need%20assistance.");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      _showErrorSnackBar('Could not launch WhatsApp.');
    }
  }

  Future<void> _sendEmail(String emailAddress) async {
    final Uri url = Uri(
      scheme: 'mailto',
      path: emailAddress,
      queryParameters: {'subject': 'Kanva Help Request'},
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      _showErrorSnackBar('Could not open default mail client.');
    }
  }

  Future<void> _submitContactForm() async {
    final name = _nameCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final subject = _subjectCtrl.text.trim();
    final message = _msgCtrl.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      _showErrorSnackBar('Please fill in your Name, Email, and Message.');
      return;
    }

    setState(() => _isLoading = true);

    final success = await ApiService.sendContactMessage(
      name: name,
      email: email,
      subject: subject.isNotEmpty ? subject : 'General Inquiry',
      message: message,
    );

    if (mounted) {
      setState(() => _isLoading = false);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Message sent successfully! We'll reply within 24 hours."),
            backgroundColor: KanvaColors.success,
          ),
        );

        _nameCtrl.clear();
        _emailCtrl.clear();
        _subjectCtrl.clear();
        _msgCtrl.clear();
      } else {
        _showErrorSnackBar('Failed to send message. Please try again later.');
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: KanvaColors.error),
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _subjectCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KanvaColors.background,
      appBar: AppBar(
        backgroundColor: KanvaColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Kanva Support', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
            decoration: const BoxDecoration(
              color: KanvaColors.primary,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
            ),
            child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Contact Us', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text("We're here to help, always", style: TextStyle(color: Colors.white70, fontSize: 13)),
              SizedBox(height: 18),
              Row(children: [
                _HeaderChip(icon: Icons.access_time, label: 'Mon–Fri\n8am–6pm'),
                SizedBox(width: 10),
                _HeaderChip(icon: Icons.reply_all_outlined, label: 'Reply in\n< 24hrs'),
                SizedBox(width: 10),
                _HeaderChip(icon: Icons.support_agent_outlined, label: 'Live Chat\nAvailable'),
              ]),
            ]),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Reach Us Directly',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: KanvaColors.textDark)),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(
                  child: _DirectContact(
                    icon: Icons.phone_outlined,
                    label: 'Call Us',
                    value: '+255 800 526 826',
                    color: KanvaColors.success,
                    onTap: () => _showCallConfirmation(context, '+255 625 543 209'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DirectContact(
                    icon: Icons.chat_outlined,
                    label: 'WhatsApp',
                    value: '+255 712 526 826',
                    color: const Color(0xFF25D366),
                    onTap: () => _openWhatsApp('+255 712 526 826'),
                  ),
                ),
              ]),
              const SizedBox(height: 10),
              Row(children: [
                Expanded(
                  child: _DirectContact(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: 'support@kanva.co.tz',
                    color: KanvaColors.primary,
                    onTap: () => _sendEmail('support@kanva.co.tz'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DirectContact(
                    icon: Icons.location_on_outlined,
                    label: 'Office',
                    value: 'Dar es Salaam',
                    color: KanvaColors.error,
                    onTap: () {},
                  ),
                ),
              ]),

              const SizedBox(height: 24),
              const Text('Send a Message',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: KanvaColors.textDark)),
              const SizedBox(height: 16),

              const KFormLabel('Your Name'),
              TextField(controller: _nameCtrl, decoration: const InputDecoration(prefixIcon: Icon(Icons.person_outline), hintText: 'Full name')),
              const SizedBox(height: 14),
              const KFormLabel('Email Address'),
              TextField(controller: _emailCtrl, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(prefixIcon: Icon(Icons.email_outlined), hintText: 'example@gmail.com')),
              const SizedBox(height: 14),
              const KFormLabel('Subject'),
              TextField(controller: _subjectCtrl, decoration: const InputDecoration(prefixIcon: Icon(Icons.subject_outlined), hintText: 'What is this about?')),
              const SizedBox(height: 14),
              const KFormLabel('Message'),
              TextField(controller: _msgCtrl, maxLines: 5, decoration: const InputDecoration(hintText: 'Type your message here...')),
              const SizedBox(height: 24),
              _isLoading
                ? const Center(child: CircularProgressIndicator(color: KanvaColors.primary))
                  : KButton(
                    label: 'Send Message',
                    icon: Icons.send_outlined,
                    onTap: _submitContactForm,
                  ),

              const SizedBox(height: 32),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _HeaderChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _HeaderChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        Icon(icon, color: Colors.white, size: 16),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, height: 1.4)),
      ]),
    ),
  );
}

class _DirectContact extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final Color color;
  final VoidCallback onTap;
  const _DirectContact({required this.icon, required this.label, required this.value, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: KCard(child: Row(children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: color, size: 18),
      ),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(fontSize: 11, color: KanvaColors.textLight)),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: KanvaColors.textDark), overflow: TextOverflow.ellipsis),
      ])),
    ])),
  );
}
