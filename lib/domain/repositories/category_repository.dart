import '../entities/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategoryList();

  Future<Category> getCategory(String id);

  Future<Category> createCategory(Category category);

  Future<Category> updateCategory(Category category);

  Future<void> deleteCategory(String id);
}
