abstract class Dompet {
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
}
