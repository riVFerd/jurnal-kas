abstract class Category {
  final String id;
  final String iconPath;
  final String name;
  final String description;
  final String userId;

  const Category({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.description,
    required this.userId,
  });

  Map<String, dynamic> toJson();

  static String icons(CategoryIcon icon) {
    switch (icon) {
      case CategoryIcon.hadiah:
        return 'assets/icons/categories/hadiah.png';
      case CategoryIcon.harian:
        return 'assets/icons/categories/harian.png';
      case CategoryIcon.hiburan:
        return 'assets/icons/categories/hiburan.png';
      case CategoryIcon.jajanan:
        return 'assets/icons/categories/jajanan.png';
      case CategoryIcon.komunikasi:
        return 'assets/icons/categories/komunikasi.png';
      case CategoryIcon.laluLintas:
        return 'assets/icons/categories/lalu-lintas.png';
      case CategoryIcon.makanan:
        return 'assets/icons/categories/makanan.png';
      case CategoryIcon.pendidikan:
        return 'assets/icons/categories/pendidikan.png';
      case CategoryIcon.rumah:
        return 'assets/icons/categories/rumah.png';
      case CategoryIcon.gaji:
        return 'assets/icons/categories/gaji.png';
    }
  }
}

enum CategoryIcon {
  hadiah,
  harian,
  hiburan,
  jajanan,
  komunikasi,
  laluLintas,
  makanan,
  pendidikan,
  rumah,
  gaji,
}
