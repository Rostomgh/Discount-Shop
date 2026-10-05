/// One of the partner's shops.
class BranchModel {
  const BranchModel({required this.id, required this.name, this.address = ''});

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      id: json['id'].toString(),
      name: json['name'] as String,
      address: json['address'] as String? ?? '',
    );
  }

  final String id;
  final String name;
  final String address;
}
