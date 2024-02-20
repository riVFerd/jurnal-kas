abstract class Category {
  final String id;
  final String iconPath;
  final String name;

  const Category({
    required this.id,
    required this.name,
    required this.iconPath,
  });

  Map<String, dynamic> toJson();
}
