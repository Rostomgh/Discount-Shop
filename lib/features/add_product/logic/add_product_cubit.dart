import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_product_state.dart';
part 'add_product_cubit.freezed.dart';

/// The photo, discount and tags of the product being added. The text fields
/// live in the screen's form.
class AddProductCubit extends Cubit<AddProductState> {
  /// [imagePath] is set when the photo was picked from the gallery before.
  AddProductCubit({String? imagePath})
    : super(AddProductState(imagePath: imagePath));

  static const discounts = [10, 20, 30, 40, 50];

  /// Translation keys of the suggested tags.
  static const quickTags = ['tag_new', 'tag_best_seller', 'tag_limited'];

  void setImage(String path) => emit(state.copyWith(imagePath: path));

  /// Back to the live camera.
  void clearImage() => emit(state.copyWith(imagePath: null));

  void toggleFlash() => emit(state.copyWith(flashOn: !state.flashOn));

  void selectDiscount(int discount) => emit(state.copyWith(discount: discount));

  void toggleTag(String tag) {
    final tags = {...state.tags};
    if (!tags.remove(tag)) tags.add(tag);
    emit(state.copyWith(tags: tags));
  }
}
