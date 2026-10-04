part of 'history_cubit.dart';

@freezed
sealed class HistoryState with _$HistoryState {
  const factory HistoryState.initial() = HistoryInitial;
  const factory HistoryState.loading() = HistoryLoading;

  /// [query] is the search text; the list shows the transactions matching it.
  const factory HistoryState.loaded({
    required List<TransactionModel> transactions,
    @Default('') String query,
  }) = HistoryLoaded;
  const factory HistoryState.error() = HistoryError;
}
