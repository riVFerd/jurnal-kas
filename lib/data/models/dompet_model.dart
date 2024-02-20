import 'package:pretest/domain/entities/dompet.dart';

class DompetModel extends Dompet {
  DompetModel({
    required super.id,
    required super.name,
    required super.iconPath,
    required super.saldo,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'iconPath': iconPath,
      'name': name,
      'saldo': saldo,
    };
  }

  factory DompetModel.fromJson(Map<String, dynamic> json) {
    return DompetModel(
      id: json['id'],
      iconPath: json['iconPath'],
      name: json['name'],
      saldo: json['saldo'],
    );
  }
}
