abstract class Transaction {
  final String id;
  final String name;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final String categoryId;
  final String dompetId;

  const Transaction({
    required this.id,
    required this.name,
    required this.amount,
    required this.date,
    required this.type,
    required this.categoryId,
    required this.dompetId,
  });

  Map<String, dynamic> toJson();
}

enum TransactionType { income, expense }
