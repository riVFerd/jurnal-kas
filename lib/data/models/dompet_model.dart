import 'package:pretest/domain/entities/dompet.dart';

class DompetModel extends Dompet {
  DompetModel({
    required super.id,
    required super.name,
    required super.iconPath,
    required super.saldo,
    required super.userId,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'iconPath': iconPath,
      'name': name,
      'saldo': saldo,
      'userId': userId,
    };
  }

  factory DompetModel.fromJson(Map<String, dynamic> json) {
    return DompetModel(
      id: json['id'],
      iconPath: json['iconPath'],
      name: json['name'],
      saldo: double.parse(json['saldo'].toString()),
      userId: json['userId'],
    );
  }
}
