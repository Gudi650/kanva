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
                                        .select('*,products(name)')
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

    //check if the product exists
    final product = await supabase.from('products').select('id').eq('id', productId);
    if (product.isEmpty) {
      throw Exception('Product not found');
    }

    //check if the product is already in the favourites of the logged in user
    final favourites = await getLoggedInUserFavourites();
    if (favourites.any((element) => element['product_id'] == productId)) {
      throw Exception('Product is already in the favourites');
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

    //check if the product is in the favourites of the logged in user
    final favourites = await getLoggedInUserFavourites();
    if (favourites.isEmpty) {
      throw Exception('Product is not in the favourites');
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
