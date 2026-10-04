part of 'home_cubit.dart';

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState.initial() = HomeInitial;
  const factory HomeState.loading() = HomeLoading;

  /// [category] filters the list; null shows every product.
  const factory HomeState.loaded({
    required List<ProductModel> products,
    String? category,
  }) = HomeLoaded;
  const factory HomeState.error() = HomeError;
}
