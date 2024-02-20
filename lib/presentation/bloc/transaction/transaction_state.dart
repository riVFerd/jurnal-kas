part of 'transaction_cubit.dart';

sealed class TransactionState extends Equatable {
  const TransactionState();
}

class TransactionInitial extends TransactionState {
  @override
  List<Object> get props => [];
}

class TransactionLoaded extends TransactionState {
  final List<Transaction> transactionList;

  const TransactionLoaded(this.transactionList);

  @override
  List<Object> get props => [transactionList];
}
