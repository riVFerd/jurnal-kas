abstract class User {
  final String id;
  final String nickname;
  final String bio;
  final String username;
  final String email;
  final Gender? gender;
  final String? avatar;
  final String? phone;
  final String? nik;

  User({
    required this.id,
    required this.nickname,
    required this.bio,
    required this.username,
    required this.email,
    this.gender,
    this.avatar,
    this.phone,
    this.nik,
  });

  Map<String, dynamic> toJson();

  User copyWith({
    String? id,
    String? nickname,
    String? bio,
    String? username,
    String? email,
    String? avatar,
    String? phone,
    String? nik,
    Gender? gender,
  });

  String get genderString {
    if (gender == null) {
      return 'null';
    } else {
      return gender == Gender.male ? 'Pria' : 'Wanita';
    }
  }
}

enum Gender {
  male,
  female,
}
