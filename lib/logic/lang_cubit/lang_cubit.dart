import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../shared/utils/persist_data.dart';

part 'lang_state.dart';
part 'lang_cubit.freezed.dart';

class LangCubit extends Cubit<LangState> {
  LangCubit() : super(const LangState.initial(Locale('en')));
  Locale get locale => _local;
  Locale _local = const Locale('en');

  Future<void> onInit() async {
    final storedLocale = await PersistData.readData("locale") ?? "en";

    _local = Locale(storedLocale);
    emit(LangState.selectLocale(locale));
  }

  void changeLang(Locale locale) {
    PersistData.writeData("locale", locale.languageCode.toLowerCase());
    _local = locale;
    emit(LangState.selectLocale(this.locale));
  }
}
