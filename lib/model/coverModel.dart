class CoverModel {
  final int id;
  final String name;
  final int value;

  CoverModel({required this.id, required this.name, required this.value});
  factory CoverModel.fromJson(Map<String, dynamic> json) {
    return CoverModel(id: json['id'], name: json['name'], value: json['value']);
  }
}
