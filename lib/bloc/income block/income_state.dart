import 'package:expensy/utils/transaction.dart';

abstract class IncomeState {
  const IncomeState();
}

class IncomeInitial extends IncomeState {}

class IncomeLoading extends IncomeState {}

class IncomeLoaded extends IncomeState {
  final List<Transaction> incomes;
  final bool isSpendViewSelected;

  const IncomeLoaded({
    required this.incomes,
    required this.isSpendViewSelected,
  });
}

class IncomeError extends IncomeState {
  final String message;

  const IncomeError(this.message);
}
