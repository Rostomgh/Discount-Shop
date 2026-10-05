part of 'discounts_cubit.dart';

@freezed
sealed class DiscountsState with _$DiscountsState {
  const factory DiscountsState.initial() = DiscountsInitial;
  const factory DiscountsState.loading() = DiscountsLoading;
  const factory DiscountsState.loaded({
    required List<DiscountModel> discounts,
  }) = DiscountsLoaded;
  const factory DiscountsState.error() = DiscountsError;
}
