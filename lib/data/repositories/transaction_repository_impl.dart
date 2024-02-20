import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/repositories/transaction_repository.dart';
import '../models/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  @override
  Future<TransactionModel> createTransaction(transaction) {
    final document = FirebaseFirestore.instance.collection('transaction').doc();
    final transactionModel = TransactionModel(
      id: document.id,
      name: transaction.name,
      amount: transaction.amount,
      categoryId: transaction.categoryId,
      date: transaction.date,
      description: transaction.description,
      dompetId: transaction.dompetId,
      type: transaction.type,
    );
    document.set(transactionModel.toJson());
    return Future.value(transactionModel);
  }

  @override
  Future<void> deleteTransaction(String id) {
    return FirebaseFirestore.instance.collection('transaction').doc(id).delete();
  }

  @override
  Future<TransactionModel> getTransaction(String id) {
    return FirebaseFirestore.instance.collection('transaction').doc(id).get().then(
          (value) => TransactionModel.fromJson(value.data()!),
        );
  }

  @override
  Future<List<TransactionModel>> getTransactionList() {
    return FirebaseFirestore.instance.collection('transaction').get().then(
          (value) =>
              value.docs.map((e) => TransactionModel.fromJson(e.data())).toList(growable: false),
        );
  }

  @override
  Future<TransactionModel> updateTransaction(transaction) {
    final document = FirebaseFirestore.instance.collection('transaction').doc(transaction.id);
    final transactionModel = TransactionModel(
      id: transaction.id,
      name: transaction.name,
      amount: transaction.amount,
      categoryId: transaction.categoryId,
      date: transaction.date,
      description: transaction.description,
      dompetId: transaction.dompetId,
      type: transaction.type,
    );
    document.set(transactionModel.toJson());
    return Future.value(transactionModel);
  }
}
