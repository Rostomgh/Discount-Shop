import 'branch_model.dart';
import 'store_model.dart';

class ProfileRepository {
  /// The partner's store.
  // TODO: get it from the API (DioHelper + Endpoints) instead of fake data.
  Future<StoreModel> getStore() async {
    // Feels like a network call, so the loading animation is visible.
    await Future<void>.delayed(const Duration(milliseconds: 800));
    return StoreModel.fromJson(_fakeStore);
  }

  /// The partner's branches.
  // TODO: get them from the API.
  Future<List<BranchModel>> getBranches() async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    return _fakeBranches.map(BranchModel.fromJson).toList();
  }

  // TODO: send the changes to the API; they are only kept in memory for now.
  Future<void> updateStore(StoreModel store) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
  }
}

const _fakeStore = <String, dynamic>{
  'name': 'PC Store - SBA',
  'email': 'pcstoresidibelabbes@example.com',
  'phone': '+213 48 54 12 30',
  'category': 'Informatique',
  'address': 'Rue Larbi Ben M\'hidi, Sidi Bel Abbès',
  'status': 'member_subscriber',
  'branch_id': 'b1',
};

const _fakeBranches = <Map<String, dynamic>>[
  {
    'id': 'b1',
    'name': 'Sidi Bel Abbès - Centre-ville',
    'address': 'Rue Larbi Ben M\'hidi',
  },
  {
    'id': 'b2',
    'name': 'Sidi Bel Abbès - Sidi Djillali',
    'address': 'Cité 400 logements',
  },
  {'id': 'b3', 'name': 'Oran - Akid Lotfi', 'address': 'Boulevard de l\'ANP'},
];
