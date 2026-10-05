part of 'profile_cubit.dart';

@freezed
sealed class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = ProfileInitial;
  const factory ProfileState.loading() = ProfileLoading;
  const factory ProfileState.loaded({
    required StoreModel store,
    required List<BranchModel> branches,
  }) = ProfileLoaded;
  const factory ProfileState.error() = ProfileError;
}
