import '../main.dart';

//class to get the user id of the logged in user
class UserId {

  //method to get the user id of the logged in user
  static String getLoggedInUserId() => supabase.auth.currentUser?.id ?? '';

}