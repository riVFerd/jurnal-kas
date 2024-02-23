abstract class User {
  final String id;
  final String username;
  final String email;
  final Gender? gender;
  final String? avatar;
  final String? phone;
  final String? nik;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.gender,
    this.avatar,
    this.phone,
    this.nik,
  });

  Map<String, dynamic> toJson();
}

enum Gender {
  male,
  female,
}
