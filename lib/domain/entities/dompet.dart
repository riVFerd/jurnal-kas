import 'package:equatable/equatable.dart';

abstract class Dompet extends Equatable {
  final String id;
  final String iconPath;
  final String name;
  final double saldo;

  const Dompet({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.saldo,
  });

  Map<String, dynamic> toJson();

  @override
  List<Object> get props => [id, name, iconPath, saldo];

  static String icons(DompetIcon icon) {
    switch (icon) {
      case DompetIcon.wallet:
        return 'assets/icons/wallet.png';
      case DompetIcon.shopeePay:
        return 'assets/icons/shopee_pay.png';
      case DompetIcon.bca:
        return 'assets/icons/bca.png';
      case DompetIcon.mandiri:
        return 'assets/icons/mandiri.png';
      default:
        return 'assets/icons/wallet.png';
    }
  }
}

enum DompetIcon {
  wallet,
  shopeePay,
  bca,
  mandiri,
}
