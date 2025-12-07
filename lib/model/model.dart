class ModelPage {
  final int id;
  final String name;
  final String size;
  final String value;

  ModelPage({
    required this.id,
    required this.name,
    required this.size,
    required this.value,
  });
  factory ModelPage.fromJson(Map<String, dynamic> json) {
    return ModelPage(
      id: json['id'],
      name: json['name'],
      size: json['size'],
      value: json['value'],
    );
  }
}
