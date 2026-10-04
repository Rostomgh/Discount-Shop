// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HistoryState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'HistoryState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'HistoryState()';
}


}

/// @nodoc
class $HistoryStateCopyWith<$Res>  {
$HistoryStateCopyWith(HistoryState _, $Res Function(HistoryState) __);
}


/// Adds pattern-matching-related methods to [HistoryState].
extension HistoryStatePatterns on HistoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HistoryInitial value)?  initial,TResult Function( HistoryLoading value)?  loading,TResult Function( HistoryLoaded value)?  loaded,TResult Function( HistoryError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HistoryInitial() when initial != null:
return initial(_that);case HistoryLoading() when loading != null:
return loading(_that);case HistoryLoaded() when loaded != null:
return loaded(_that);case HistoryError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HistoryInitial value)  initial,required TResult Function( HistoryLoading value)  loading,required TResult Function( HistoryLoaded value)  loaded,required TResult Function( HistoryError value)  error,}){
final _that = this;
switch (_that) {
case HistoryInitial():
return initial(_that);case HistoryLoading():
return loading(_that);case HistoryLoaded():
return loaded(_that);case HistoryError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HistoryInitial value)?  initial,TResult? Function( HistoryLoading value)?  loading,TResult? Function( HistoryLoaded value)?  loaded,TResult? Function( HistoryError value)?  error,}){
final _that = this;
switch (_that) {
case HistoryInitial() when initial != null:
return initial(_that);case HistoryLoading() when loading != null:
return loading(_that);case HistoryLoaded() when loaded != null:
return loaded(_that);case HistoryError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<TransactionModel> transactions,  String query)?  loaded,TResult Function()?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HistoryInitial() when initial != null:
return initial();case HistoryLoading() when loading != null:
return loading();case HistoryLoaded() when loaded != null:
return loaded(_that.transactions,_that.query);case HistoryError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<TransactionModel> transactions,  String query)  loaded,required TResult Function()  error,}) {final _that = this;
switch (_that) {
case HistoryInitial():
return initial();case HistoryLoading():
return loading();case HistoryLoaded():
return loaded(_that.transactions,_that.query);case HistoryError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<TransactionModel> transactions,  String query)?  loaded,TResult? Function()?  error,}) {final _that = this;
switch (_that) {
case HistoryInitial() when initial != null:
return initial();case HistoryLoading() when loading != null:
return loading();case HistoryLoaded() when loaded != null:
return loaded(_that.transactions,_that.query);case HistoryError() when error != null:
return error();case _:
  return null;

}
}

}

/// @nodoc


class HistoryInitial with DiagnosticableTreeMixin implements HistoryState {
  const HistoryInitial();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'HistoryState.initial'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'HistoryState.initial()';
}


}




/// @nodoc


class HistoryLoading with DiagnosticableTreeMixin implements HistoryState {
  const HistoryLoading();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'HistoryState.loading'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'HistoryState.loading()';
}


}




/// @nodoc


class HistoryLoaded with DiagnosticableTreeMixin implements HistoryState {
  const HistoryLoaded({required final  List<TransactionModel> transactions, this.query = ''}): _transactions = transactions;
  

 final  List<TransactionModel> _transactions;
 List<TransactionModel> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}

@JsonKey() final  String query;

/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryLoadedCopyWith<HistoryLoaded> get copyWith => _$HistoryLoadedCopyWithImpl<HistoryLoaded>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'HistoryState.loaded'))
    ..add(DiagnosticsProperty('transactions', transactions))..add(DiagnosticsProperty('query', query));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryLoaded&&const DeepCollectionEquality().equals(other._transactions, _transactions)&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_transactions),query);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'HistoryState.loaded(transactions: $transactions, query: $query)';
}


}

/// @nodoc
abstract mixin class $HistoryLoadedCopyWith<$Res> implements $HistoryStateCopyWith<$Res> {
  factory $HistoryLoadedCopyWith(HistoryLoaded value, $Res Function(HistoryLoaded) _then) = _$HistoryLoadedCopyWithImpl;
@useResult
$Res call({
 List<TransactionModel> transactions, String query
});




}
/// @nodoc
class _$HistoryLoadedCopyWithImpl<$Res>
    implements $HistoryLoadedCopyWith<$Res> {
  _$HistoryLoadedCopyWithImpl(this._self, this._then);

  final HistoryLoaded _self;
  final $Res Function(HistoryLoaded) _then;

/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? transactions = null,Object? query = null,}) {
  return _then(HistoryLoaded(
transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class HistoryError with DiagnosticableTreeMixin implements HistoryState {
  const HistoryError();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'HistoryState.error'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'HistoryState.error()';
}


}




// dart format on
