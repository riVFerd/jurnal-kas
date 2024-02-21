import '../../domain/entities/transaction.dart';

class TransactionModel extends Transaction {
  TransactionModel({
    required super.id,
    required super.name,
    required super.categoryId,
    required super.dompetId,
    required super.amount,
    required super.date,
    required super.type,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'dompetId': dompetId,
      'amount': amount,
      'date': date.toIso8601String(),
      'type': type == TransactionType.income ? 'income' : 'expense',
    };
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      name: json['name'],
      categoryId: json['categoryId'],
      dompetId: json['dompetId'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      type: json['type'] == 'income' ? TransactionType.income : TransactionType.expense,
    );
  }
}
