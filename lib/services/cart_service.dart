import 'package:supabase_flutter/supabase_flutter.dart';
import '../main.dart';
import 'user_id.dart';

class CartService {

  String get _userId {
    final id = UserId.getLoggedInUserId();
    if (id.isEmpty) throw Exception('User is not logged in');
    return id;
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    try {
      final rows = await supabase
          .from('cart_items')
          .select('*,products(*,shops(name))')
          .eq('user_id', _userId);
      return List<Map<String, dynamic>>.from(rows);
    } on PostgrestException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> setQty(String productId, int qty) async {
    //check if the quantity is less than 1
    if (qty < 1) {
      await removeCartItem(productId);
      return;
    }
    try {
      await supabase.from('cart_items').upsert({
        'user_id': _userId,
        'product_id': productId,
        'qty': qty,
      }, onConflict: 'user_id,product_id');
    } on PostgrestException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> removeCartItem(String productId) async {
    try {
      await supabase.from('cart_items').delete().eq('user_id', _userId).eq('product_id', productId);
    } on PostgrestException catch (e) {
      throw Exception(e.message);
    }
  }
}
