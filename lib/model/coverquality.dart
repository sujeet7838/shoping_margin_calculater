class CoverQuality {
  final int id;
  final String name;
  final String value;

  CoverQuality({required this.id, required this.name, required this.value});
  factory CoverQuality.fromJson(Map<String, dynamic> json) {
    return CoverQuality(id: json['id'], name: json['name'], value: json['value']);
  }
}