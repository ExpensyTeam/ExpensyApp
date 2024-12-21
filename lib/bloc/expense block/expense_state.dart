import 'package:expensy/utils/transaction.dart';

abstract class ExpenseState {
  const ExpenseState();
}

class ExpenseInitial extends ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<Transaction> expenses;
  final bool isSpendViewSelected;

  const ExpenseLoaded({
    required this.expenses,
    required this.isSpendViewSelected,
  });
}

class ExpenseError extends ExpenseState {
  final String message;

  const ExpenseError(this.message);
}
