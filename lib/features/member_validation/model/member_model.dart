import 'offer_model.dart';

/// A member whose card was scanned, with the offers they can use here.
class MemberModel {
  const MemberModel({
    required this.id,
    required this.name,
    required this.status,
    required this.points,
    this.photoUrl,
    this.offers = const [],
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id'].toString(),
      name: json['name'] as String,
      status: json['status'] as String? ?? '',
      points: (json['points'] as num?)?.toInt() ?? 0,
      photoUrl: json['photo'] as String?,
      offers: [
        for (final offer in json['offers'] as List<dynamic>? ?? const [])
          OfferModel.fromJson(offer as Map<String, dynamic>),
      ],
    );
  }

  final String id;
  final String name;

  /// Translation key (e.g. 'member_subscriber') or plain text.
  final String status;

  /// Points balance.
  final int points;

  /// Null shows the initials instead.
  final String? photoUrl;
  final List<OfferModel> offers;

  /// "Soundous Bel" → "SB".
  String get initials => name
      .split(' ')
      .where((part) => part.isNotEmpty)
      .take(2)
      .map((part) => part[0].toUpperCase())
      .join();
}
