part of 'member_validation_cubit.dart';

@freezed
sealed class MemberValidationState with _$MemberValidationState {
  const factory MemberValidationState.loading() = MemberValidationLoading;

  /// [selectedOfferId] is null until the partner picks an offer.
  const factory MemberValidationState.loaded({
    required MemberModel member,
    String? selectedOfferId,
  }) = MemberValidationLoaded;
  const factory MemberValidationState.error() = MemberValidationError;
}
