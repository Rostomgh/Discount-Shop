import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/widgets/fade_slide_in.dart';
import '../logic/member_validation_cubit.dart';
import '../model/member_model.dart';
import 'member_profile.dart';
import 'offer_card.dart';
import 'points_balance.dart';

/// The loaded member: profile, the offers to pick from, and the points.
class MemberDetails extends StatelessWidget {
  const MemberDetails({
    super.key,
    required this.member,
    required this.scanned,
    required this.selectedOfferId,
    required this.onSelectOffer,
  });

  final MemberModel member;
  final bool scanned;
  final String? selectedOfferId;
  final ValueChanged<String> onSelectOffer;

  @override
  Widget build(BuildContext context) {
    final offers = MemberValidationCubit.offersOf(member);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MemberProfile(member: member, scanned: scanned),
        SizedBox(height: 28.h),
        for (final (index, offer) in offers.indexed)
          Padding(
            padding: EdgeInsets.only(bottom: 14.h),
            child: FadeSlideIn(
              delay: Duration(milliseconds: 200 + 80 * index),
              child: OfferCard(
                offer: offer,
                selected: offer.id == selectedOfferId,
                onTap: () => onSelectOffer(offer.id),
              ),
            ),
          ),
        SizedBox(height: 6.h),
        Center(
          child: FadeSlideIn(
            delay: Duration(milliseconds: 200 + 80 * offers.length),
            child: PointsBalance(points: member.points),
          ),
        ),
      ],
    );
  }
}
