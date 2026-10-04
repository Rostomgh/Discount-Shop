part of 'add_product_cubit.dart';

@freezed
sealed class AddProductState with _$AddProductState {
  const factory AddProductState({
    /// The photo taken or picked; null while the live camera shows.
    String? imagePath,
    @Default(false) bool flashOn,

    /// Discount in percent; null until the partner picks one.
    int? discount,

    /// Translation keys of the selected quick tags.
    @Default(<String>{}) Set<String> tags,
  }) = _AddProductState;
}
