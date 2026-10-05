// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discounts_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DiscountsState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DiscountsState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscountsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DiscountsState()';
}


}

/// @nodoc
class $DiscountsStateCopyWith<$Res>  {
$DiscountsStateCopyWith(DiscountsState _, $Res Function(DiscountsState) __);
}


/// Adds pattern-matching-related methods to [DiscountsState].
extension DiscountsStatePatterns on DiscountsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DiscountsInitial value)?  initial,TResult Function( DiscountsLoading value)?  loading,TResult Function( DiscountsLoaded value)?  loaded,TResult Function( DiscountsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DiscountsInitial() when initial != null:
return initial(_that);case DiscountsLoading() when loading != null:
return loading(_that);case DiscountsLoaded() when loaded != null:
return loaded(_that);case DiscountsError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DiscountsInitial value)  initial,required TResult Function( DiscountsLoading value)  loading,required TResult Function( DiscountsLoaded value)  loaded,required TResult Function( DiscountsError value)  error,}){
final _that = this;
switch (_that) {
case DiscountsInitial():
return initial(_that);case DiscountsLoading():
return loading(_that);case DiscountsLoaded():
return loaded(_that);case DiscountsError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DiscountsInitial value)?  initial,TResult? Function( DiscountsLoading value)?  loading,TResult? Function( DiscountsLoaded value)?  loaded,TResult? Function( DiscountsError value)?  error,}){
final _that = this;
switch (_that) {
case DiscountsInitial() when initial != null:
return initial(_that);case DiscountsLoading() when loading != null:
return loading(_that);case DiscountsLoaded() when loaded != null:
return loaded(_that);case DiscountsError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<DiscountModel> discounts)?  loaded,TResult Function()?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DiscountsInitial() when initial != null:
return initial();case DiscountsLoading() when loading != null:
return loading();case DiscountsLoaded() when loaded != null:
return loaded(_that.discounts);case DiscountsError() when error != null:
return error();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<DiscountModel> discounts)  loaded,required TResult Function()  error,}) {final _that = this;
switch (_that) {
case DiscountsInitial():
return initial();case DiscountsLoading():
return loading();case DiscountsLoaded():
return loaded(_that.discounts);case DiscountsError():
return error();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<DiscountModel> discounts)?  loaded,TResult? Function()?  error,}) {final _that = this;
switch (_that) {
case DiscountsInitial() when initial != null:
return initial();case DiscountsLoading() when loading != null:
return loading();case DiscountsLoaded() when loaded != null:
return loaded(_that.discounts);case DiscountsError() when error != null:
return error();case _:
  return null;

}
}

}

/// @nodoc


class DiscountsInitial with DiagnosticableTreeMixin implements DiscountsState {
  const DiscountsInitial();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DiscountsState.initial'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscountsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DiscountsState.initial()';
}


}




/// @nodoc


class DiscountsLoading with DiagnosticableTreeMixin implements DiscountsState {
  const DiscountsLoading();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DiscountsState.loading'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscountsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DiscountsState.loading()';
}


}




/// @nodoc


class DiscountsLoaded with DiagnosticableTreeMixin implements DiscountsState {
  const DiscountsLoaded({required final  List<DiscountModel> discounts}): _discounts = discounts;
  

 final  List<DiscountModel> _discounts;
 List<DiscountModel> get discounts {
  if (_discounts is EqualUnmodifiableListView) return _discounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_discounts);
}


/// Create a copy of DiscountsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscountsLoadedCopyWith<DiscountsLoaded> get copyWith => _$DiscountsLoadedCopyWithImpl<DiscountsLoaded>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DiscountsState.loaded'))
    ..add(DiagnosticsProperty('discounts', discounts));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscountsLoaded&&const DeepCollectionEquality().equals(other._discounts, _discounts));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_discounts));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DiscountsState.loaded(discounts: $discounts)';
}


}

/// @nodoc
abstract mixin class $DiscountsLoadedCopyWith<$Res> implements $DiscountsStateCopyWith<$Res> {
  factory $DiscountsLoadedCopyWith(DiscountsLoaded value, $Res Function(DiscountsLoaded) _then) = _$DiscountsLoadedCopyWithImpl;
@useResult
$Res call({
 List<DiscountModel> discounts
});




}
/// @nodoc
class _$DiscountsLoadedCopyWithImpl<$Res>
    implements $DiscountsLoadedCopyWith<$Res> {
  _$DiscountsLoadedCopyWithImpl(this._self, this._then);

  final DiscountsLoaded _self;
  final $Res Function(DiscountsLoaded) _then;

/// Create a copy of DiscountsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? discounts = null,}) {
  return _then(DiscountsLoaded(
discounts: null == discounts ? _self._discounts : discounts // ignore: cast_nullable_to_non_nullable
as List<DiscountModel>,
  ));
}


}

/// @nodoc


class DiscountsError with DiagnosticableTreeMixin implements DiscountsState {
  const DiscountsError();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DiscountsState.error'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscountsError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DiscountsState.error()';
}


}




// dart format on
