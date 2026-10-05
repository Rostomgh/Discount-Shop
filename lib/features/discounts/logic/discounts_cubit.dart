import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/discount_model.dart';
import '../model/discounts_repository.dart';

part 'discounts_state.dart';
part 'discounts_cubit.freezed.dart';

/// The discounts the partner gives to members.
class DiscountsCubit extends Cubit<DiscountsState> {
  DiscountsCubit(this._repository) : super(const DiscountsState.initial());

  final DiscountsRepository _repository;

  /// The percentages the partner can choose from.
  static const percents = [5, 10, 15, 20, 25, 30, 40, 50];

  Future<void> load() async {
    emit(const DiscountsState.loading());
    try {
      emit(DiscountsState.loaded(discounts: await _repository.getDiscounts()));
    } catch (e) {
      debugPrint('Loading discounts failed: $e');
      emit(const DiscountsState.error());
    }
  }

  /// Puts [discount] first. Loads the others first if they aren't yet, so
  /// they don't get lost.
  Future<void> add(DiscountModel discount) async {
    if (state is! DiscountsLoaded) await load();
    final discounts = switch (state) {
      DiscountsLoaded(:final discounts) => discounts,
      _ => const <DiscountModel>[],
    };
    emit(DiscountsState.loaded(discounts: [discount, ...discounts]));
  }

  void setActive(String id, bool active) {
    if (state case DiscountsLoaded(:final discounts)) {
      emit(
        DiscountsState.loaded(
          discounts: [
            for (final d in discounts)
              d.id == id ? d.copyWith(active: active) : d,
          ],
        ),
      );
    }
  }

  void delete(String id) {
    if (state case DiscountsLoaded(:final discounts)) {
      emit(
        DiscountsState.loaded(
          discounts: discounts.where((d) => d.id != id).toList(),
        ),
      );
    }
  }

  /// Forgets the discounts, e.g. on log out.
  void reset() => emit(const DiscountsState.initial());
}
