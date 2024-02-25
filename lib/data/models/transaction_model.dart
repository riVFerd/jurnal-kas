import 'package:pretest/common/datetime_extentions.dart';

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
    required super.userId,
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
      'userId': userId,
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
      userId: json['userId'],
    );
  }
}

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

  List<Transaction> get sortedByIncome {
    return where((transaction) => transaction.type == TransactionType.income).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  List<Transaction> get sortedByExpense {
    return where((transaction) => transaction.type == TransactionType.expense).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  /// Return list of transaction grouped by month and year
  /// Note:
  /// - The list must be sorted by date
  /// - Property [amount] is the main concern of this method
  /// - Never ever used [id] returned from this method
  /// - [name] is the month of grouped transaction in string, use it properly
  /// - [categoryId] is just the first category id of the grouped transaction
  List<Transaction> groupedByMonthYear() {
    final groupedTransaction = <Transaction>[];
    double amount = 0;
    DateTime date = DateTime.now();
    Transaction? lastTransaction;
    for (final transaction in this) {
      if (lastTransaction == null) {
        amount += transaction.amount;
        date = transaction.date;
        lastTransaction = transaction;
      } else {
        if (lastTransaction.date.isSameMonthYear(transaction.date)) {
          amount += transaction.amount;
        } else {
          groupedTransaction.add(
            TransactionModel(
              id: '',
              name: date.monthInString,
              amount: amount,
              date: date,
              type: TransactionType.income,
              categoryId: first.categoryId,
              dompetId: first.dompetId,
              userId: first.userId,
            ),
          );
          amount = transaction.amount;
          date = transaction.date;
        }
      }
    }
    if (isNotEmpty) {
      groupedTransaction.add(
        TransactionModel(
          id: '',
          name: date.monthInString,
          amount: amount,
          date: date,
          type: TransactionType.income,
          categoryId: first.categoryId,
          dompetId: first.dompetId,
          userId: first.userId,
        ),
      );
    }
    return groupedTransaction;
  }
}
