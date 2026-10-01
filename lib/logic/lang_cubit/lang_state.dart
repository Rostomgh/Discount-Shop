part of 'lang_cubit.dart';

@freezed
sealed class LangState with _$LangState {
  const factory LangState.initial(Locale locale) = _Initial;
  const factory LangState.selectLocale(Locale locale) = _SelectLocale;
}
