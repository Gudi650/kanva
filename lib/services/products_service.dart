import '../main.dart';

class ProductsService {

  //metho to get all products
  Future <List<Map<String, dynamic>>> getAllProducts () async {
    //wrap the query in a try-catch block
    try {
      final products = await supabase.from('products').select('*,categories(name),shops(name)');
      if (products.isNotEmpty) {
        return List<Map<String, dynamic>>.from(products);
      }
      return [];
    } catch (error) {
      print(error);
      return [];
    }
  }

  //method to get products by category
  Future <List<Map<String, dynamic>>> getProductsByCategory (String category) async {
    //wrap the query in a try-catch block
    try {
      final products = await supabase
          .from('products')
          .select('*,categories!inner(name),shops(name)')
          .eq('categories.name', category);
      if (products.isNotEmpty) {
        return List<Map<String, dynamic>>.from(products);
      }
      return [];
    } catch (error) {
      print(error);
      return []; 
    }
  }
}