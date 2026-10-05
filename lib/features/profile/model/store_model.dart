/// The partner's store, shown at the top of the profile tab.
class StoreModel {
  const StoreModel({
    required this.name,
    required this.email,
    required this.branchId,
    this.phone = '',
    this.category = '',
    this.address = '',
    this.status = '',
    this.photoPath,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      name: json['name'] as String,
      email: json['email'] as String? ?? '',
      branchId: json['branch_id'].toString(),
      phone: json['phone'] as String? ?? '',
      category: json['category'] as String? ?? '',
      address: json['address'] as String? ?? '',
      status: json['status'] as String? ?? '',
      photoPath: json['photo'] as String?,
    );
  }

  final String name;
  final String email;

  /// The branch the partner is working in now.
  final String branchId;
  final String phone;
  final String category;
  final String address;

  /// Translation key (e.g. 'member_subscriber') or plain text.
  final String status;

  /// Local photo file; null shows the initials instead.
  final String? photoPath;

  /// "PC Store - SBA" → "PS".
  String get initials => name
      .split(' ')
      .where((part) => part.isNotEmpty && part != '-')
      .take(2)
      .map((part) => part[0].toUpperCase())
      .join();

  StoreModel copyWith({
    String? name,
    String? email,
    String? branchId,
    String? phone,
    String? category,
    String? address,
    String? photoPath,
  }) {
    return StoreModel(
      name: name ?? this.name,
      email: email ?? this.email,
      branchId: branchId ?? this.branchId,
      phone: phone ?? this.phone,
      category: category ?? this.category,
      address: address ?? this.address,
      status: status,
      photoPath: photoPath ?? this.photoPath,
    );
  }
}
