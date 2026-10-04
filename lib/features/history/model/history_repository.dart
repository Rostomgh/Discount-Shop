import 'transaction_model.dart';

class HistoryRepository {
  /// The partner's transactions, newest first.
  // TODO: get them from the API (DioHelper + Endpoints) instead of fake data.
  Future<List<TransactionModel>> getTransactions() async {
    // Feels like a network call, so the loading animation is visible.
    await Future<void>.delayed(const Duration(milliseconds: 800));
    return _fakeTransactions().map(TransactionModel.fromJson).toList();
  }
}

/// Dates are relative to now so the list always looks recent.
List<Map<String, dynamic>> _fakeTransactions() {
  final now = DateTime.now();
  String ago(int days, {int hours = 0}) =>
      now.subtract(Duration(days: days, hours: hours)).toIso8601String();

  return [
    {
      'id': 't1',
      'type': 'reward',
      'description': 'Cashback de la commande #2106',
      'amount': 450,
      'date': ago(0),
    },
    {
      'id': 't2',
      'type': 'purchase',
      'description': 'Commande (Nike Air Max 270)',
      'amount': -18500,
      'date': ago(0, hours: 3),
    },
    {
      'id': 't3',
      'type': 'refund',
      'description': 'Remboursement de la commande #INV-2083',
      'amount': 2300,
      'date': ago(1),
    },
    {
      'id': 't4',
      'type': 'topUp',
      'description': 'Recharge par carte bancaire',
      'amount': 5000,
      'date': ago(3),
    },
    {
      'id': 't5',
      'type': 'purchase',
      'description': 'Commande #Laneige Water Cream',
      'amount': -4200,
      'date': ago(5),
    },
    {
      'id': 't6',
      'type': 'reward',
      'description': 'Points fidélité convertis',
      'amount': 300,
      'date': ago(8),
    },
    {
      'id': 't7',
      'type': 'purchase',
      'description': 'Commande (Pull en maille vert)',
      'amount': -3150,
      'date': ago(12),
    },
    {
      'id': 't8',
      'type': 'topUp',
      'description': 'Recharge par virement',
      'amount': 2000,
      'date': ago(15),
    },
  ];
}
