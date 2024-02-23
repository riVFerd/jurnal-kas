import 'package:pretest/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.username,
    required super.email,
    super.avatar,
    super.gender,
    super.nik,
    super.phone,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'avatar': avatar,
      'gender': gender != null
          ? gender == Gender.male
              ? 'male'
              : 'female'
          : null,
      'nik': nik,
      'phone': phone,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      avatar: json['avatar'],
      gender: json['gender'] != null
          ? json['gender'] == 'male'
              ? Gender.male
              : Gender.female
          : null,
      nik: json['nik'],
      phone: json['phone'],
    );
  }
}
