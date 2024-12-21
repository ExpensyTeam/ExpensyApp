import 'package:expensy/utils/transaction.dart';

abstract class TransactionState {
  const TransactionState();
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;

  const TransactionLoaded(this.transactions);
}

class TransactionError extends TransactionState {
  final String message;

  const TransactionError(this.message);
}
