import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel({
    required super.id,
    required super.name,
    required super.iconPath,
    required super.description,
    required super.userId,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'iconPath': iconPath,
      'name': name,
      'description': description,
      'userId': userId,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      iconPath: json['iconPath'],
      name: json['name'],
      description: json['description'],
      userId: json['userId'],
    );
  }
}
