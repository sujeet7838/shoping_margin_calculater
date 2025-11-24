class PageType {
  final int id;
  final String name;
  final String value;

  PageType({required this.id, required this.name, required this.value});
  factory PageType.fromJson(Map<String, dynamic> json) {
    return PageType(id: json['id'], name: json['name'], value: json['value']);
  }
}
