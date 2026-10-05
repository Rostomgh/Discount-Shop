/// A discount the partner gives to members, e.g. "-15% on laptops".
class DiscountModel {
  const DiscountModel({
    required this.id,
    required this.title,
    required this.percent,
    this.description = '',
    this.active = true,
    this.endDate,
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json) {
    final endDate = json['end_date'] as String?;
    return DiscountModel(
      id: json['id'].toString(),
      title: json['title'] as String,
      percent: (json['percent'] as num).toInt(),
      description: json['description'] as String? ?? '',
      active: json['active'] as bool? ?? true,
      endDate: endDate == null ? null : DateTime.parse(endDate),
    );
  }

  final String id;
  final String title;

  /// Discount in percent, e.g. 15.
  final int percent;
  final String description;

  /// Inactive discounts are kept but members can't use them.
  final bool active;

  /// Last day of the discount; null when it never ends.
  final DateTime? endDate;

  DiscountModel copyWith({bool? active}) {
    return DiscountModel(
      id: id,
      title: title,
      percent: percent,
      description: description,
      active: active ?? this.active,
      endDate: endDate,
    );
  }
}
