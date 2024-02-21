import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/transaction.dart';
import '../../../domain/repositories/transaction_repository.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final TransactionRepository _transactionRepository;
  TransactionCubit(this._transactionRepository) : super(TransactionInitial());

  void getTransactionList() async {
    final transactionList = await _transactionRepository.getTransactionList();
    emit(TransactionLoaded(transactionList));
  }

  void createTransaction(Transaction transaction) async {
    await _transactionRepository.createTransaction(transaction);
    getTransactionList();
  }
}
