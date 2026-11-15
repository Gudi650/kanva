import '../main.dart';

class ProfileService {

  //method for user to get their profile
  Future<Map<String, dynamic>> getProfile() async {
    final user = supabase.auth.currentUser;
    if (user == null) return {};
    final row = await supabase.from('profiles').select().eq('id', user.id).maybeSingle();
    return {
      'full_name': row?['full_name'] ?? '',
      'phone': row?['phone'] ?? '',
      'location': row?['location'] ?? '',
      'email': user.email ?? '',
    };
  }
  
}
