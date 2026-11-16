import 'package:supabase_flutter/supabase_flutter.dart';
import '../main.dart';
import 'user_id.dart';

class CartService {

    //method to get the cart items of the logged in user
    Future <List<Map<String, dynamic>>> getCartItems () async{

        //get the id of the logged in user
        String loggedInUserId = UserId.getLoggedInUserId();

        //check if the user is logged in and has an ID
        if (loggedInUserId.isEmpty) {
          throw Exception('User is not logged in');
        }

        try {

          final cartItems = await supabase.from('cart_item').select('*').eq('user_id', loggedInUserId);
          if (cartItems.isNotEmpty) {
            return List<Map<String, dynamic>>.from(cartItems);
          }

          return [];

        } on PostgrestException catch (e) {
          throw Exception(e.message.toString());
        } catch (e) {
          throw Exception(e.toString());
        }
          
    }

    //method to add items in the cart
    Future <List<Map<String, dynamic>>> addCartItems(List<Map<String, dynamic>> cartItems) async{

      //get the id of the logged in user
      String loggedInUserId = UserId.getLoggedInUserId();

      //check if the user is logged in and has an ID
      if (loggedInUserId.isEmpty) {
        throw Exception('User is not logged in');
      }

      try {
        //add the cart items to the cart of the logged in user
        final newCartItems = await supabase.from('cart_item').insert(cartItems).eq('user_id', loggedInUserId);
        if (newCartItems.isNotEmpty) {
          return List<Map<String, dynamic>>.from(newCartItems);
        }
      } on PostgrestException catch (e) {
        throw Exception(e.message.toString());
      } catch (e) {
        throw Exception(e.toString());
      }
      return [];
  }




}
