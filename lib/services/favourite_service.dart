import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';
import 'user_id.dart';

class FavouriteService {

  

  //method to read the favourites of the logged in user
  Future<List<Map<String, dynamic>>> getLoggedInUserFavourites () async{
    
    //check if the user is logged in and has an ID
    if (UserId.getLoggedInUserId().isEmpty) {
      throw Exception('User is not logged in');
    }

    try {
      //get the favourites of the logged in user
      final favourites = await supabase.from('favourites')
                                        .select('*,products(*,shops(name))')
                                        .eq('user_id', UserId.getLoggedInUserId());
      if (favourites.isNotEmpty) {
        return List<Map<String, dynamic>>.from(favourites);
      }
      return [];
    } on PostgrestException catch (error) {
        print(error);
        throw Exception(error.message.toString());
    }
    catch (error) {
      print(error);
      throw Exception(error.toString());
    }

  }

  //method to add a product to the favourites
  Future<void> addToFavourites(String productId) async{
    //check if the user is logged in and has an ID
    if (UserId.getLoggedInUserId().isEmpty) {
      throw Exception('User is not logged in');
    }

    try {
      //add the product to the favourites of the logged in user
      await supabase.from('favourites').insert({
        'product_id': productId,
        'user_id': UserId.getLoggedInUserId(),
      });
    } on PostgrestException catch (error) {
      throw Exception(error.message.toString());
    } catch (error) {
      throw Exception(error.toString());
    }
  }
  

  //method to remove a product from the favourites
  Future<void> removeFromFavourites(String productId) async{
    //check if the user is logged in and has an ID
    if (UserId.getLoggedInUserId().isEmpty) {
      throw Exception('User is not logged in');
    }

    try {
      //remove the product from the favourites of the logged in user
      await supabase.from('favourites').delete().eq('product_id', productId).eq('user_id', UserId.getLoggedInUserId());
    } on PostgrestException catch (error) {
      throw Exception(error.message.toString());
    } catch (error) {
      throw Exception(error.toString());
    }
  }
  
  
}
