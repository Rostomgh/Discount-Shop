import '../../../core/constant/enums.dart';

/// A movement on the partner's wallet.
class TransactionModel {
  const TransactionModel({
    required this.id,
    required this.type,
    required this.description,
    required this.amount,
    required this.date,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'].toString(),
      type: TransactionType.values.byName(json['type'] as String),
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
    );
  }

  final String id;
  final TransactionType type;
  final String description;

  /// Positive for money in (reward, refund, top up), negative for money out.
  final double amount;
  final DateTime date;

  bool get isCredit => amount >= 0;

  /// Search: [query] in the description or in the translated [typeLabel],
  /// ignoring case.
  bool matches(String query, {required String typeLabel}) {
    final q = query.trim().toLowerCase();
    return q.isEmpty ||
        description.toLowerCase().contains(q) ||
        typeLabel.toLowerCase().contains(q);
  }
}
