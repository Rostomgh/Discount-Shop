import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/home_repository.dart';
import '../model/product_model.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

/// The partner's discounted products.
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repository) : super(const HomeState.initial());

  final HomeRepository _repository;

  Future<void> loadProducts() async {
    emit(const HomeState.loading());
    try {
      emit(HomeState.loaded(products: await _repository.getProducts()));
    } catch (e) {
      debugPrint('Loading products failed: $e');
      emit(const HomeState.error());
    }
  }

  void selectCategory(String? category) {
    if (state case HomeLoaded(:final products)) {
      emit(HomeState.loaded(products: products, category: category));
    }
  }

  /// Puts [product] first and clears the filter so it's visible.
  void addProduct(ProductModel product) {
    final products = switch (state) {
      HomeLoaded(:final products) => products,
      _ => const <ProductModel>[],
    };
    emit(HomeState.loaded(products: [product, ...products]));
  }
}
