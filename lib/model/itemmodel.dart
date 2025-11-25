class ItemModel {
  final int id;
  final String name;
  final dynamic value;

  ItemModel({
    required this.id,
    required this.name,
    required this.value,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      name: json['name'],
      value: json['value'],
    );
  }
}
