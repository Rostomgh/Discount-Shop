import 'discount_model.dart';

class DiscountsRepository {
  /// The discounts the partner gives to members.
  // TODO: get them from the API (DioHelper + Endpoints) instead of fake data.
  // Added, changed and deleted discounts are only kept in memory for now.
  Future<List<DiscountModel>> getDiscounts() async {
    // Feels like a network call, so the loading animation is visible.
    await Future<void>.delayed(const Duration(milliseconds: 800));
    return _fakeDiscounts.map(DiscountModel.fromJson).toList();
  }
}

const _fakeDiscounts = <Map<String, dynamic>>[
  {
    'id': 'd1',
    'title': 'Rentrée scolaire',
    'description': 'Sur tous les ordinateurs portables',
    'percent': 15,
    'end_date': '2026-10-31',
  },
  {
    'id': 'd2',
    'title': 'Accessoires gaming',
    'description': 'Claviers, souris et casques',
    'percent': 20,
  },
  {
    'id': 'd3',
    'title': 'Black Friday',
    'description': 'Sur tout le magasin',
    'percent': 30,
    'active': false,
    'end_date': '2026-11-27',
  },
];
