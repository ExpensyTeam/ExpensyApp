import 'package:expensy/Data/iconMapping.dart';
import 'package:expensy/Data/transactions.dart';
import 'package:expensy/bloc/income%20block/income_event.dart';
import 'package:expensy/bloc/income%20block/income_state.dart';
import 'package:expensy/utils/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncomeBloc extends Bloc<IncomeEvent, IncomeState> {
  final List<Transaction> _allTransactions = transactions_data;
  final Map<String, IconData> iconMapping = iconMapping_data;

  IncomeBloc() : super(IncomeInitial()) {
    on<LoadIncomes>(_onLoadIncomes);
    on<ToggleView>(_onToggleView);
  }

  List<Transaction> _getIncomeTransactions() {
    return _allTransactions
        .where((transaction) => transaction.amount.startsWith('+'))
        .toList();
  }

  Future<void> _onLoadIncomes(
    LoadIncomes event,
    Emitter<IncomeState> emit,
  ) async {
    emit(IncomeLoading());
    try {
      final incomes = _getIncomeTransactions();
      emit(IncomeLoaded(incomes: incomes, isSpendViewSelected: true));
    } catch (e) {
      emit(IncomeError(e.toString()));
    }
  }

  Future<void> _onToggleView(
    ToggleView event,
    Emitter<IncomeState> emit,
  ) async {
    final currentState = state;
    if (currentState is IncomeLoaded) {
      emit(IncomeLoaded(
        incomes: currentState.incomes,
        isSpendViewSelected: event.isSpendView,
      ));
    }
  }
}
