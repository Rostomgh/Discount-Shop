import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/member_model.dart';
import '../model/member_validation_repository.dart';
import '../model/offer_model.dart';

part 'member_validation_state.dart';
part 'member_validation_cubit.freezed.dart';

/// The member whose card was scanned, and the offer the partner applies.
class MemberValidationCubit extends Cubit<MemberValidationState> {
  MemberValidationCubit(this._repository, {required this.code})
    : super(const MemberValidationState.loading());

  final MemberValidationRepository _repository;

  /// The scanned or typed card number.
  final String code;

  /// Always offered last: pay normally (or collect points).
  static const noOffer = OfferModel(
    id: 'none',
    title: 'offer_none',
    description: 'offer_none_hint',
  );

  /// The member's offers, then [noOffer].
  static List<OfferModel> offersOf(MemberModel member) => [
    ...member.offers,
    noOffer,
  ];

  Future<void> load() async {
    emit(const MemberValidationState.loading());
    try {
      final member = await _repository.getMember(code);
      // The partner may have left the screen while it was loading.
      if (!isClosed) emit(MemberValidationState.loaded(member: member));
    } catch (e) {
      debugPrint('Loading the member failed: $e');
      if (!isClosed) emit(const MemberValidationState.error());
    }
  }

  void selectOffer(String offerId) {
    if (state case MemberValidationLoaded loaded) {
      emit(loaded.copyWith(selectedOfferId: offerId));
    }
  }

  // TODO: send the card and the selected offer to the API.
}
