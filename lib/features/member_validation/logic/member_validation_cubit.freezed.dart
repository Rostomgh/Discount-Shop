// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_validation_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MemberValidationState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MemberValidationState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberValidationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MemberValidationState()';
}


}

/// @nodoc
class $MemberValidationStateCopyWith<$Res>  {
$MemberValidationStateCopyWith(MemberValidationState _, $Res Function(MemberValidationState) __);
}


/// Adds pattern-matching-related methods to [MemberValidationState].
extension MemberValidationStatePatterns on MemberValidationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MemberValidationLoading value)?  loading,TResult Function( MemberValidationLoaded value)?  loaded,TResult Function( MemberValidationError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MemberValidationLoading() when loading != null:
return loading(_that);case MemberValidationLoaded() when loaded != null:
return loaded(_that);case MemberValidationError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MemberValidationLoading value)  loading,required TResult Function( MemberValidationLoaded value)  loaded,required TResult Function( MemberValidationError value)  error,}){
final _that = this;
switch (_that) {
case MemberValidationLoading():
return loading(_that);case MemberValidationLoaded():
return loaded(_that);case MemberValidationError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MemberValidationLoading value)?  loading,TResult? Function( MemberValidationLoaded value)?  loaded,TResult? Function( MemberValidationError value)?  error,}){
final _that = this;
switch (_that) {
case MemberValidationLoading() when loading != null:
return loading(_that);case MemberValidationLoaded() when loaded != null:
return loaded(_that);case MemberValidationError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( MemberModel member,  String? selectedOfferId)?  loaded,TResult Function()?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MemberValidationLoading() when loading != null:
return loading();case MemberValidationLoaded() when loaded != null:
return loaded(_that.member,_that.selectedOfferId);case MemberValidationError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( MemberModel member,  String? selectedOfferId)  loaded,required TResult Function()  error,}) {final _that = this;
switch (_that) {
case MemberValidationLoading():
return loading();case MemberValidationLoaded():
return loaded(_that.member,_that.selectedOfferId);case MemberValidationError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( MemberModel member,  String? selectedOfferId)?  loaded,TResult? Function()?  error,}) {final _that = this;
switch (_that) {
case MemberValidationLoading() when loading != null:
return loading();case MemberValidationLoaded() when loaded != null:
return loaded(_that.member,_that.selectedOfferId);case MemberValidationError() when error != null:
return error();case _:
  return null;

}
}

}

/// @nodoc


class MemberValidationLoading with DiagnosticableTreeMixin implements MemberValidationState {
  const MemberValidationLoading();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MemberValidationState.loading'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberValidationLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MemberValidationState.loading()';
}


}




/// @nodoc


class MemberValidationLoaded with DiagnosticableTreeMixin implements MemberValidationState {
  const MemberValidationLoaded({required this.member, this.selectedOfferId});
  

 final  MemberModel member;
 final  String? selectedOfferId;

/// Create a copy of MemberValidationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberValidationLoadedCopyWith<MemberValidationLoaded> get copyWith => _$MemberValidationLoadedCopyWithImpl<MemberValidationLoaded>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MemberValidationState.loaded'))
    ..add(DiagnosticsProperty('member', member))..add(DiagnosticsProperty('selectedOfferId', selectedOfferId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberValidationLoaded&&(identical(other.member, member) || other.member == member)&&(identical(other.selectedOfferId, selectedOfferId) || other.selectedOfferId == selectedOfferId));
}


@override
int get hashCode => Object.hash(runtimeType,member,selectedOfferId);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MemberValidationState.loaded(member: $member, selectedOfferId: $selectedOfferId)';
}


}

/// @nodoc
abstract mixin class $MemberValidationLoadedCopyWith<$Res> implements $MemberValidationStateCopyWith<$Res> {
  factory $MemberValidationLoadedCopyWith(MemberValidationLoaded value, $Res Function(MemberValidationLoaded) _then) = _$MemberValidationLoadedCopyWithImpl;
@useResult
$Res call({
 MemberModel member, String? selectedOfferId
});




}
/// @nodoc
class _$MemberValidationLoadedCopyWithImpl<$Res>
    implements $MemberValidationLoadedCopyWith<$Res> {
  _$MemberValidationLoadedCopyWithImpl(this._self, this._then);

  final MemberValidationLoaded _self;
  final $Res Function(MemberValidationLoaded) _then;

/// Create a copy of MemberValidationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? member = null,Object? selectedOfferId = freezed,}) {
  return _then(MemberValidationLoaded(
member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as MemberModel,selectedOfferId: freezed == selectedOfferId ? _self.selectedOfferId : selectedOfferId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class MemberValidationError with DiagnosticableTreeMixin implements MemberValidationState {
  const MemberValidationError();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MemberValidationState.error'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberValidationError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MemberValidationState.error()';
}


}




// dart format on
