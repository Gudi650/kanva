class ApiService {
  static Future<bool> sendContactMessage({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return true;
  }
}
