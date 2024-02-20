import '../entities/transaction.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> getTransactionList();

  Future<Transaction> getTransaction(String id);

  Future<Transaction> createTransaction(Transaction transaction);

  Future<Transaction> updateTransaction(Transaction transaction);

  Future<void> deleteTransaction(String id);
}
