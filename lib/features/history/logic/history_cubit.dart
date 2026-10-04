import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/history_repository.dart';
import '../model/transaction_model.dart';

part 'history_state.dart';
part 'history_cubit.freezed.dart';

/// The partner's transaction history.
class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit(this._repository) : super(const HistoryState.initial());

  final HistoryRepository _repository;

  Future<void> loadTransactions() async {
    emit(const HistoryState.loading());
    try {
      emit(
        HistoryState.loaded(transactions: await _repository.getTransactions()),
      );
    } catch (e) {
      debugPrint('Loading transactions failed: $e');
      emit(const HistoryState.error());
    }
  }

  void search(String query) {
    if (state case HistoryLoaded loaded) emit(loaded.copyWith(query: query));
  }

  /// Removes the transaction and returns where it was, for [restore].
  /// Returns -1 if it isn't in the list.
  int delete(String id) {
    if (state case HistoryLoaded loaded) {
      final index = loaded.transactions.indexWhere((t) => t.id == id);
      if (index >= 0) {
        emit(
          loaded.copyWith(
            transactions: [...loaded.transactions]..removeAt(index),
          ),
        );
      }
      return index;
    }
    return -1;
  }

  /// Puts back a transaction removed with [delete] ("Undo").
  void restore(TransactionModel transaction, int index) {
    if (state case HistoryLoaded loaded) {
      final transactions = [...loaded.transactions];
      transactions.insert(index.clamp(0, transactions.length), transaction);
      emit(loaded.copyWith(transactions: transactions));
    }
  }

  void deleteAll() {
    if (state case HistoryLoaded loaded) {
      emit(loaded.copyWith(transactions: const []));
    }
  }
}
