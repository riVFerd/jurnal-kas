import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel({
    required super.id,
    required super.name,
    required super.iconPath,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'iconPath': iconPath,
      'name': name,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      iconPath: json['iconPath'],
      name: json['name'],
    );
  }
}
