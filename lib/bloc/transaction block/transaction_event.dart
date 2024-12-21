import 'package:expensy/utils/transaction.dart';

abstract class TransactionEvent {
  const TransactionEvent();
}

class LoadTransactions extends TransactionEvent {}

class AddTransaction extends TransactionEvent {
  final Transaction transaction;

  const AddTransaction(this.transaction);
}

class UpdateTransaction extends TransactionEvent {
  final Transaction transaction;

  const UpdateTransaction(this.transaction);
}

class DeleteTransaction extends TransactionEvent {
  final Transaction transaction;

  const DeleteTransaction(this.transaction);
}
