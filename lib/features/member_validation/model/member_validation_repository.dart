import 'member_model.dart';

class MemberValidationRepository {
  /// The member who owns the card [code], with their offers.
  // TODO: get the member from the API (DioHelper + Endpoints) instead of fake
  // data; every code returns the same member for now.
  Future<MemberModel> getMember(String code) async {
    // Feels like a network call, so the loading animation is visible.
    await Future<void>.delayed(const Duration(milliseconds: 800));
    return MemberModel.fromJson({..._fakeMember, 'id': code});
  }
}

const _fakeMember = <String, dynamic>{
  'name': 'Soundous Bel',
  'status': 'member_subscriber',
  'points': 1250,
  'offers': [
    {
      'id': 'o1',
      'title': 'offer_discount_10',
      'description': 'offer_discount_10_hint',
    },
    {
      'id': 'o2',
      'title': 'offer_free_coffee',
      'description': 'offer_free_coffee_hint',
      'points_cost': 15,
    },
  ],
};
