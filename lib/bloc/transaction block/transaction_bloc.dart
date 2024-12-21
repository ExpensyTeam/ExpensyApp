import 'package:expensy/Data/iconMapping.dart';
import 'package:expensy/Data/transactions.dart';
import 'package:expensy/bloc/transaction%20block/transaction_event.dart';
import 'package:expensy/bloc/transaction%20block/transaction_state.dart';
import 'package:expensy/utils/transaction.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final List<Transaction> _transactions = transactions_data;
  final Map<String, IconData> iconMapping = iconMapping_data;

  TransactionBloc() : super(TransactionInitial()) {
    on<LoadTransactions>(_onLoadTransactions);
    on<AddTransaction>(_onAddTransaction);
    on<UpdateTransaction>(_onUpdateTransaction);
    on<DeleteTransaction>(_onDeleteTransaction);
  }

  Future<void> _onLoadTransactions(
    LoadTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    try {
      emit(TransactionLoaded(_transactions));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }

  Future<void> _onAddTransaction(
    AddTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    final currentState = state;
    if (currentState is TransactionLoaded) {
      try {
        _transactions.add(event.transaction);
        emit(TransactionLoaded(List.from(_transactions)));
      } catch (e) {
        emit(TransactionError(e.toString()));
      }
    }
  }

  Future<void> _onUpdateTransaction(
    UpdateTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    final currentState = state;
    if (currentState is TransactionLoaded) {
      try {
        final index = _transactions.indexWhere(
            (transaction) => transaction.date == event.transaction.date);
        if (index != -1) {
          _transactions[index] = event.transaction;
          emit(TransactionLoaded(List.from(_transactions)));
        }
      } catch (e) {
        emit(TransactionError(e.toString()));
      }
    }
  }

  Future<void> _onDeleteTransaction(
    DeleteTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    final currentState = state;
    if (currentState is TransactionLoaded) {
      try {
        _transactions.remove(event.transaction);
        emit(TransactionLoaded(List.from(_transactions)));
      } catch (e) {
        emit(TransactionError(e.toString()));
      }
    }
  }
}
