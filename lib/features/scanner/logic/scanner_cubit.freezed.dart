// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scanner_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScannerState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScannerState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ScannerState()';
}


}

/// @nodoc
class $ScannerStateCopyWith<$Res>  {
$ScannerStateCopyWith(ScannerState _, $Res Function(ScannerState) __);
}


/// Adds pattern-matching-related methods to [ScannerState].
extension ScannerStatePatterns on ScannerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ScannerScanning value)?  scanning,TResult Function( ScannerFound value)?  found,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ScannerScanning() when scanning != null:
return scanning(_that);case ScannerFound() when found != null:
return found(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ScannerScanning value)  scanning,required TResult Function( ScannerFound value)  found,}){
final _that = this;
switch (_that) {
case ScannerScanning():
return scanning(_that);case ScannerFound():
return found(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ScannerScanning value)?  scanning,TResult? Function( ScannerFound value)?  found,}){
final _that = this;
switch (_that) {
case ScannerScanning() when scanning != null:
return scanning(_that);case ScannerFound() when found != null:
return found(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  scanning,TResult Function( String code,  bool scanned)?  found,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ScannerScanning() when scanning != null:
return scanning();case ScannerFound() when found != null:
return found(_that.code,_that.scanned);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  scanning,required TResult Function( String code,  bool scanned)  found,}) {final _that = this;
switch (_that) {
case ScannerScanning():
return scanning();case ScannerFound():
return found(_that.code,_that.scanned);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  scanning,TResult? Function( String code,  bool scanned)?  found,}) {final _that = this;
switch (_that) {
case ScannerScanning() when scanning != null:
return scanning();case ScannerFound() when found != null:
return found(_that.code,_that.scanned);case _:
  return null;

}
}

}

/// @nodoc


class ScannerScanning implements ScannerState {
  const ScannerScanning();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScannerScanning);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ScannerState.scanning()';
}


}




/// @nodoc


class ScannerFound implements ScannerState {
  const ScannerFound({required this.code, this.scanned = true});
  

 final  String code;
@JsonKey() final  bool scanned;

/// Create a copy of ScannerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScannerFoundCopyWith<ScannerFound> get copyWith => _$ScannerFoundCopyWithImpl<ScannerFound>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScannerFound&&(identical(other.code, code) || other.code == code)&&(identical(other.scanned, scanned) || other.scanned == scanned));
}


@override
int get hashCode => Object.hash(runtimeType,code,scanned);

@override
String toString() {
  return 'ScannerState.found(code: $code, scanned: $scanned)';
}


}

/// @nodoc
abstract mixin class $ScannerFoundCopyWith<$Res> implements $ScannerStateCopyWith<$Res> {
  factory $ScannerFoundCopyWith(ScannerFound value, $Res Function(ScannerFound) _then) = _$ScannerFoundCopyWithImpl;
@useResult
$Res call({
 String code, bool scanned
});




}
/// @nodoc
class _$ScannerFoundCopyWithImpl<$Res>
    implements $ScannerFoundCopyWith<$Res> {
  _$ScannerFoundCopyWithImpl(this._self, this._then);

  final ScannerFound _self;
  final $Res Function(ScannerFound) _then;

/// Create a copy of ScannerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? code = null,Object? scanned = null,}) {
  return _then(ScannerFound(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,scanned: null == scanned ? _self.scanned : scanned // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
