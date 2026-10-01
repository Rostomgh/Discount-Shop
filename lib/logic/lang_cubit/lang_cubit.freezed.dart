// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lang_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LangState {

 Locale get locale;
/// Create a copy of LangState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LangStateCopyWith<LangState> get copyWith => _$LangStateCopyWithImpl<LangState>(this as LangState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LangState&&(identical(other.locale, locale) || other.locale == locale));
}


@override
int get hashCode => Object.hash(runtimeType,locale);

@override
String toString() {
  return 'LangState(locale: $locale)';
}


}

/// @nodoc
abstract mixin class $LangStateCopyWith<$Res>  {
  factory $LangStateCopyWith(LangState value, $Res Function(LangState) _then) = _$LangStateCopyWithImpl;
@useResult
$Res call({
 Locale locale
});




}
/// @nodoc
class _$LangStateCopyWithImpl<$Res>
    implements $LangStateCopyWith<$Res> {
  _$LangStateCopyWithImpl(this._self, this._then);

  final LangState _self;
  final $Res Function(LangState) _then;

/// Create a copy of LangState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? locale = null,}) {
  return _then(_self.copyWith(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as Locale,
  ));
}

}


/// Adds pattern-matching-related methods to [LangState].
extension LangStatePatterns on LangState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _SelectLocale value)?  selectLocale,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _SelectLocale() when selectLocale != null:
return selectLocale(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _SelectLocale value)  selectLocale,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _SelectLocale():
return selectLocale(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _SelectLocale value)?  selectLocale,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _SelectLocale() when selectLocale != null:
return selectLocale(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Locale locale)?  initial,TResult Function( Locale locale)?  selectLocale,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.locale);case _SelectLocale() when selectLocale != null:
return selectLocale(_that.locale);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Locale locale)  initial,required TResult Function( Locale locale)  selectLocale,}) {final _that = this;
switch (_that) {
case _Initial():
return initial(_that.locale);case _SelectLocale():
return selectLocale(_that.locale);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Locale locale)?  initial,TResult? Function( Locale locale)?  selectLocale,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.locale);case _SelectLocale() when selectLocale != null:
return selectLocale(_that.locale);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements LangState {
  const _Initial(this.locale);
  

@override final  Locale locale;

/// Create a copy of LangState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialCopyWith<_Initial> get copyWith => __$InitialCopyWithImpl<_Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial&&(identical(other.locale, locale) || other.locale == locale));
}


@override
int get hashCode => Object.hash(runtimeType,locale);

@override
String toString() {
  return 'LangState.initial(locale: $locale)';
}


}

/// @nodoc
abstract mixin class _$InitialCopyWith<$Res> implements $LangStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) _then) = __$InitialCopyWithImpl;
@override @useResult
$Res call({
 Locale locale
});




}
/// @nodoc
class __$InitialCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(this._self, this._then);

  final _Initial _self;
  final $Res Function(_Initial) _then;

/// Create a copy of LangState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? locale = null,}) {
  return _then(_Initial(
null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as Locale,
  ));
}


}

/// @nodoc


class _SelectLocale implements LangState {
  const _SelectLocale(this.locale);
  

@override final  Locale locale;

/// Create a copy of LangState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectLocaleCopyWith<_SelectLocale> get copyWith => __$SelectLocaleCopyWithImpl<_SelectLocale>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectLocale&&(identical(other.locale, locale) || other.locale == locale));
}


@override
int get hashCode => Object.hash(runtimeType,locale);

@override
String toString() {
  return 'LangState.selectLocale(locale: $locale)';
}


}

/// @nodoc
abstract mixin class _$SelectLocaleCopyWith<$Res> implements $LangStateCopyWith<$Res> {
  factory _$SelectLocaleCopyWith(_SelectLocale value, $Res Function(_SelectLocale) _then) = __$SelectLocaleCopyWithImpl;
@override @useResult
$Res call({
 Locale locale
});




}
/// @nodoc
class __$SelectLocaleCopyWithImpl<$Res>
    implements _$SelectLocaleCopyWith<$Res> {
  __$SelectLocaleCopyWithImpl(this._self, this._then);

  final _SelectLocale _self;
  final $Res Function(_SelectLocale) _then;

/// Create a copy of LangState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? locale = null,}) {
  return _then(_SelectLocale(
null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as Locale,
  ));
}


}

// dart format on
