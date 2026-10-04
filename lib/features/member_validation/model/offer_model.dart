/// An offer the partner can apply to a member's purchase.
class OfferModel {
  const OfferModel({
    required this.id,
    required this.title,
    required this.description,
    this.pointsCost,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'].toString(),
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      pointsCost: (json['points_cost'] as num?)?.toInt(),
    );
  }

  final String id;

  /// Translation keys (e.g. 'offer_free_coffee') or plain text.
  final String title;
  final String description;

  /// Points taken from the member's balance; null when the offer is free.
  final int? pointsCost;
}
