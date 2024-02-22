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

extension TransactionsExtension on List<Transaction> {
  double get totalAmount {
    return fold(0.0, (previousValue, element) {
      if (element.type == TransactionType.income) {
        return previousValue + element.amount;
      } else {
        return previousValue - element.amount;
      }
    });
  }

  double get totalIncome {
    return fold(0.0, (previousValue, element) {
      if (element.type == TransactionType.income) {
        return previousValue + element.amount;
      } else {
        return previousValue;
      }
    });
  }

  double get totalExpense {
    return fold(0.0, (previousValue, element) {
      if (element.type == TransactionType.expense) {
        return previousValue + element.amount;
      } else {
        return previousValue;
      }
    });
  }
}
