import '../main.dart';

class CategoriesService {

  //method to get all categories
  Future <List<Map<String, dynamic>>> getAllCategories () async {
    //wrap the query in a try-catch block
    try {
      final categories = await supabase.from('categories').select('name');
      if (categories.isNotEmpty) {
        return List<Map<String, dynamic>>.from(categories);
      }
      return [];
    } catch (error) {
      print(error);
      return [];
    }
  }

}