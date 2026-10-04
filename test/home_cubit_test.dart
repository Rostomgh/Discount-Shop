import 'package:discount_shop/core/extensions/price.dart';
import 'package:discount_shop/features/home/logic/home_cubit.dart';
import 'package:discount_shop/features/home/model/home_repository.dart';
import 'package:discount_shop/features/home/model/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

const _newProduct = ProductModel(
  id: 'new',
  name: 'Écharpe',
  category: 'Accessoires',
  price: 2000,
  discount: 20,
);

void main() {
  test('loadProducts shows loading, then the fake products', () async {
    final cubit = HomeCubit(HomeRepository());

    final states = expectLater(
      cubit.stream,
      emitsInOrder([
        isA<HomeLoading>(),
        isA<HomeLoaded>().having((s) => s.products, 'products', isNotEmpty),
      ]),
    );
    await cubit.loadProducts();
    await states;
  });

  test('selectCategory keeps the products and sets the filter', () async {
    final cubit = HomeCubit(HomeRepository());
    await cubit.loadProducts();

    cubit.selectCategory('Bijoux');

    final state = cubit.state as HomeLoaded;
    expect(state.category, 'Bijoux');
    expect(state.products, hasLength(7));
  });

  test('addProduct puts the product first and clears the filter', () async {
    final cubit = HomeCubit(HomeRepository());
    await cubit.loadProducts();
    cubit.selectCategory('Bijoux');

    cubit.addProduct(_newProduct);

    final state = cubit.state as HomeLoaded;
    expect(state.products.first.id, 'new');
    expect(state.products, hasLength(8));
    expect(state.category, isNull);
  });

  test('discountedPrice applies the discount', () {
    expect(_newProduct.discountedPrice, 1600);
  });

  test('asPrice groups thousands', () {
    // Drop the direction marks and use normal spaces to compare.
    String plain(String s) => s
        .replaceAll(String.fromCharCode(0x2066), '')
        .replaceAll(String.fromCharCode(0x2069), '')
        .replaceAll(String.fromCharCode(0xA0), ' ');
    expect(plain(3150.4.asPrice), '3 150');
    expect(plain(650.asPrice), '650');
    expect(plain(1234567.asPrice), '1 234 567');
  });
}
