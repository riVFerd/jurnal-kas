import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pretest/domain/entities/category.dart';
import 'package:pretest/domain/repositories/category_repository.dart';

import '../models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  @override
  Future<CategoryModel> createCategory(Category category) {
    final document = FirebaseFirestore.instance.collection('category').doc();
    final categoryModel = CategoryModel(
      id: document.id,
      iconPath: category.iconPath,
      name: category.name,
    );
    document.set(categoryModel.toJson());
    return Future.value(categoryModel);
  }

  @override
  Future<void> deleteCategory(String id) {
    return FirebaseFirestore.instance.collection('category').doc(id).delete();
  }

  @override
  Future<CategoryModel> getCategory(String id) {
    return FirebaseFirestore.instance.collection('category').doc(id).get().then(
          (value) => CategoryModel.fromJson(value.data()!),
        );
  }

  @override
  Future<List<CategoryModel>> getCategoryList() {
    return FirebaseFirestore.instance.collection('category').get().then(
          (value) =>
              value.docs.map((e) => CategoryModel.fromJson(e.data())).toList(growable: false),
        );
  }

  @override
  Future<CategoryModel> updateCategory(Category category) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }
}
