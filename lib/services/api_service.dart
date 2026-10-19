class ApiService {
  static final List<Map<String, dynamic>> _complaints = [];
  static int _ticketSeq = 1;

  static Future<bool> sendContactMessage({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return true;
  }

  static Future<Map<String, dynamic>> submitComplaint({
    required String type,
    String? bookingReference,
    required String description,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final ticketNumber = '#KNV-${_ticketSeq.toString().padLeft(5, '0')}';
    _ticketSeq++;
    _complaints.insert(0, {
      'ticket_number': ticketNumber,
      'type': type,
      'booking_reference': bookingReference,
      'description': description,
      'status': 'Pending',
      'created_at': DateTime.now().toIso8601String(),
    });
    return {
      'success': true,
      'ticket_number': ticketNumber,
      'message': 'Complaint submitted.',
    };
  }

  static Future<List<Map<String, dynamic>>> getComplaints() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List<Map<String, dynamic>>.from(_complaints);
  }
}
