import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pretest/domain/entities/transaction.dart';

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
      dompetId: transaction.dompetId,
      type: transaction.type,
      userId: transaction.userId,
    );
    document.set(transactionModel.toJson());

    // add or subtract the amount to the wallet
    final walletDocument =
        FirebaseFirestore.instance.collection('dompet').doc(transaction.dompetId);
    walletDocument.get().then((value) {
      final wallet = value.data();
      if (transaction.type == TransactionType.income) {
        walletDocument.update({'saldo': wallet!['saldo'] + transaction.amount});
      } else {
        walletDocument.update({'saldo': wallet!['saldo'] - transaction.amount});
      }
    });
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
    final user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection('transaction')
        .where('userId', isEqualTo: user?.uid)
        .orderBy('date', descending: true)
        .get()
        .then(
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
      dompetId: transaction.dompetId,
      type: transaction.type,
      userId: transaction.userId,
    );
    document.set(transactionModel.toJson());
    return Future.value(transactionModel);
  }
}
