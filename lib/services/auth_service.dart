import 'package:supabase_flutter/supabase_flutter.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import '../pages/homepage.dart';
import '../pages/signin.dart';

class AuthService {

  //method for user to signup with email and password
  Future<void> signUpWithEmail(String email, String password, BuildContext context) async {
    try{
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
        //data: {'full_name': fullName}
      );

      final User? user = res.user;

      if(context.mounted){

        showDialog(context: context, builder: (context) => AlertDialog(
          title: Text('Sign up successful'),
          content: Text('Welcome ${user?.email}'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('OK')),
          ],
        ));

        if(user != null){

          Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));

        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to sign up')),
          );
        }
      }

    } on PostgrestException catch (e) {
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
    on AuthException catch (e) {
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
    catch (e) {
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }


  //method for user to signin with email and password
  Future<void> signInWithEmail(String email, String password, BuildContext context) async {
    try{
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final User? user = res.user;

      if(context.mounted){
        showDialog(context: context, builder: (context) => AlertDialog(
          title: Text('Sign in successful'),
          content: Text('Welcome ${user?.email}'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('OK')),
          ],
        ));
        if(user != null){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to sign in')),
          );
        }
      }
    }
    on PostgrestException catch (e) {
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
    on AuthException catch (e) {
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
    catch (e) {
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  //method for user to logout
  Future<void> signOut(BuildContext context) async {
    try{
      await supabase.auth.signOut();
      
      if(context.mounted){
        showDialog(context: context, builder: (context) => AlertDialog(
          title: Text('Logged out'),
          content: Text('You have been logged out'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('OK')),
          ],
        ));
        Navigator.push(context, MaterialPageRoute(builder: (context) => Signin()));
      }
    }
    on PostgrestException catch (e) {
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
    on AuthException catch (e) {
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
    catch (e) {
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }
  

}
