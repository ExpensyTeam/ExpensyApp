import 'package:expensy/Data/iconMapping.dart';
import 'package:expensy/Data/transactions.dart';
import 'package:expensy/bloc/expense%20block/expense_event.dart';
import 'package:expensy/bloc/expense%20block/expense_state.dart';
import 'package:expensy/utils/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final List<Transaction> _allTransactions = transactions_data;
  final Map<String, IconData> iconMapping = iconMapping_data;

  ExpenseBloc() : super(ExpenseInitial()) {
    on<LoadExpenses>(_onLoadExpenses);
    on<ToggleView>(_onToggleView);
  }

  List<Transaction> _getExpenseTransactions() {
    return _allTransactions
        .where((transaction) => transaction.amount.startsWith('-'))
        .toList();
  }

  Future<void> _onLoadExpenses(
    LoadExpenses event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(ExpenseLoading());
    try {
      final expenses = _getExpenseTransactions();
      emit(ExpenseLoaded(expenses: expenses, isSpendViewSelected: true));
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  Future<void> _onToggleView(
    ToggleView event,
    Emitter<ExpenseState> emit,
  ) async {
    final currentState = state;
    if (currentState is ExpenseLoaded) {
      emit(ExpenseLoaded(
        expenses: currentState.expenses,
        isSpendViewSelected: event.isSpendView,
      ));
    }
  }
}
