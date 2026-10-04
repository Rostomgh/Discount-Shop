// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_product_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddProductState {

/// The photo taken or picked; null while the live camera shows.
 String? get imagePath; bool get flashOn;/// Discount in percent; null until the partner picks one.
 int? get discount;/// Translation keys of the selected quick tags.
 Set<String> get tags;
/// Create a copy of AddProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddProductStateCopyWith<AddProductState> get copyWith => _$AddProductStateCopyWithImpl<AddProductState>(this as AddProductState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddProductState&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.flashOn, flashOn) || other.flashOn == flashOn)&&(identical(other.discount, discount) || other.discount == discount)&&const DeepCollectionEquality().equals(other.tags, tags));
}


@override
int get hashCode => Object.hash(runtimeType,imagePath,flashOn,discount,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'AddProductState(imagePath: $imagePath, flashOn: $flashOn, discount: $discount, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $AddProductStateCopyWith<$Res>  {
  factory $AddProductStateCopyWith(AddProductState value, $Res Function(AddProductState) _then) = _$AddProductStateCopyWithImpl;
@useResult
$Res call({
 String? imagePath, bool flashOn, int? discount, Set<String> tags
});




}
/// @nodoc
class _$AddProductStateCopyWithImpl<$Res>
    implements $AddProductStateCopyWith<$Res> {
  _$AddProductStateCopyWithImpl(this._self, this._then);

  final AddProductState _self;
  final $Res Function(AddProductState) _then;

/// Create a copy of AddProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imagePath = freezed,Object? flashOn = null,Object? discount = freezed,Object? tags = null,}) {
  return _then(_self.copyWith(
imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,flashOn: null == flashOn ? _self.flashOn : flashOn // ignore: cast_nullable_to_non_nullable
as bool,discount: freezed == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as int?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [AddProductState].
extension AddProductStatePatterns on AddProductState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddProductState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddProductState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddProductState value)  $default,){
final _that = this;
switch (_that) {
case _AddProductState():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddProductState value)?  $default,){
final _that = this;
switch (_that) {
case _AddProductState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? imagePath,  bool flashOn,  int? discount,  Set<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddProductState() when $default != null:
return $default(_that.imagePath,_that.flashOn,_that.discount,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? imagePath,  bool flashOn,  int? discount,  Set<String> tags)  $default,) {final _that = this;
switch (_that) {
case _AddProductState():
return $default(_that.imagePath,_that.flashOn,_that.discount,_that.tags);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? imagePath,  bool flashOn,  int? discount,  Set<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _AddProductState() when $default != null:
return $default(_that.imagePath,_that.flashOn,_that.discount,_that.tags);case _:
  return null;

}
}

}

/// @nodoc


class _AddProductState implements AddProductState {
  const _AddProductState({this.imagePath, this.flashOn = false, this.discount, final  Set<String> tags = const <String>{}}): _tags = tags;
  

/// The photo taken or picked; null while the live camera shows.
@override final  String? imagePath;
@override@JsonKey() final  bool flashOn;
/// Discount in percent; null until the partner picks one.
@override final  int? discount;
/// Translation keys of the selected quick tags.
 final  Set<String> _tags;
/// Translation keys of the selected quick tags.
@override@JsonKey() Set<String> get tags {
  if (_tags is EqualUnmodifiableSetView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_tags);
}


/// Create a copy of AddProductState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddProductStateCopyWith<_AddProductState> get copyWith => __$AddProductStateCopyWithImpl<_AddProductState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddProductState&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.flashOn, flashOn) || other.flashOn == flashOn)&&(identical(other.discount, discount) || other.discount == discount)&&const DeepCollectionEquality().equals(other._tags, _tags));
}


@override
int get hashCode => Object.hash(runtimeType,imagePath,flashOn,discount,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'AddProductState(imagePath: $imagePath, flashOn: $flashOn, discount: $discount, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$AddProductStateCopyWith<$Res> implements $AddProductStateCopyWith<$Res> {
  factory _$AddProductStateCopyWith(_AddProductState value, $Res Function(_AddProductState) _then) = __$AddProductStateCopyWithImpl;
@override @useResult
$Res call({
 String? imagePath, bool flashOn, int? discount, Set<String> tags
});




}
/// @nodoc
class __$AddProductStateCopyWithImpl<$Res>
    implements _$AddProductStateCopyWith<$Res> {
  __$AddProductStateCopyWithImpl(this._self, this._then);

  final _AddProductState _self;
  final $Res Function(_AddProductState) _then;

/// Create a copy of AddProductState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imagePath = freezed,Object? flashOn = null,Object? discount = freezed,Object? tags = null,}) {
  return _then(_AddProductState(
imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,flashOn: null == flashOn ? _self.flashOn : flashOn // ignore: cast_nullable_to_non_nullable
as bool,discount: freezed == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as int?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}

// dart format on
