import 'package:pretest/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    super.nickname = 'User Nick Name',
    super.bio = 'User Bio',
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
      'nickname': nickname,
      'bio': bio,
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
      nickname: json['nickname'],
      bio: json['bio'],
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

  @override
  UserModel copyWith({
    String? id,
    String? nickname,
    String? bio,
    String? username,
    String? email,
    String? avatar,
    Gender? gender,
    String? nik,
    String? phone,
  }) {
    return UserModel(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      bio: bio ?? this.bio,
      username: username ?? this.username,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      gender: gender ?? this.gender,
      nik: nik ?? this.nik,
      phone: phone ?? this.phone,
    );
  }
}
