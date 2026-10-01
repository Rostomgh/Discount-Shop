import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:discount_shop/logic/lang_cubit/lang_cubit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => FlutterSecureStorage.setMockInitialValues({}));

  test('defaults to English when nothing is saved', () async {
    final cubit = LangCubit();
    await cubit.onInit();

    expect(cubit.state.locale, const Locale('en'));
  });

  test('changeLang emits the new locale and remembers it', () async {
    final cubit = LangCubit();
    cubit.changeLang(const Locale('ar'));

    expect(cubit.state.locale, const Locale('ar'));

    final restored = LangCubit();
    await restored.onInit();
    expect(restored.state.locale, const Locale('ar'));
  });
}
