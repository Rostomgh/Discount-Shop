import 'product_model.dart';

class HomeRepository {
  /// The partner's discounted products.
  // TODO: get them from the API (DioHelper + Endpoints) instead of fake data.
  Future<List<ProductModel>> getProducts() async {
    // Feels like a network call, so the loading animation is visible.
    await Future<void>.delayed(const Duration(milliseconds: 800));
    return _fakeProducts.map(ProductModel.fromJson).toList();
  }
}

const _fakeProducts = <Map<String, dynamic>>[
  {
    'id': 'p1',
    'name': 'Pull en maille vert',
    'category': 'Vêtements',
    'price': 4500,
    'discount': 30,
    'tags': ['tag_new'],
  },
  {
    'id': 'p2',
    'name': 'Tote bag Farmers Market',
    'category': 'Accessoires',
    'price': 1800,
    'discount': 20,
    'tags': ['tag_best_seller'],
  },
  {
    'id': 'p3',
    'name': 'T-shirt rose Rebel',
    'category': 'Vêtements',
    'price': 2200,
    'discount': 40,
    'tags': ['tag_limited'],
  },
  {
    'id': 'p4',
    'name': 'Carnet à motifs floraux',
    'category': 'Papeterie',
    'price': 650,
    'discount': 15,
  },
  {
    'id': 'p5',
    'name': "Boucles d'oreilles dorées",
    'category': 'Bijoux',
    'price': 1200,
    'discount': 25,
    'tags': ['tag_new'],
  },
  {
    'id': 'p6',
    'name': 'Casquette en jean',
    'category': 'Accessoires',
    'price': 1500,
    'discount': 50,
  },
  {
    'id': 'p7',
    'name': 'Bougie parfumée vanille',
    'category': 'Maison',
    'price': 950,
    'discount': 10,
  },
];
