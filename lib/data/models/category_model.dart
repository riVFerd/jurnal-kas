import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel({
    required super.id,
    required super.name,
    required super.iconPath,
    required super.description,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'iconPath': iconPath,
      'name': name,
      'description': description,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      iconPath: json['iconPath'],
      name: json['name'],
      description: json['description'],
    );
  }
}
