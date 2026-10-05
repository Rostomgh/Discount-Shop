import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/branch_model.dart';
import '../model/profile_repository.dart';
import '../model/store_model.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

/// The partner's store and branches.
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._repository) : super(const ProfileState.initial());

  final ProfileRepository _repository;

  Future<void> load() async {
    emit(const ProfileState.loading());
    try {
      final (store, branches) = await (
        _repository.getStore(),
        _repository.getBranches(),
      ).wait;
      emit(ProfileState.loaded(store: store, branches: branches));
    } catch (e) {
      debugPrint('Loading the profile failed: $e');
      emit(const ProfileState.error());
    }
  }

  /// Saves the store's new details. Throws if they couldn't be saved.
  Future<void> updateStore(StoreModel store) async {
    await _repository.updateStore(store);
    if (state case ProfileLoaded loaded) emit(loaded.copyWith(store: store));
  }

  // TODO: tell the API which branch the partner works in.
  void selectBranch(String branchId) {
    if (state case ProfileLoaded loaded) {
      emit(loaded.copyWith(store: loaded.store.copyWith(branchId: branchId)));
    }
  }

  /// Forgets the store, e.g. on log out, so the next login loads it again.
  void reset() => emit(const ProfileState.initial());
}
