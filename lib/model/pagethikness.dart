class PageThikness {
  final int id;
  final String name;
  final int value;

  PageThikness({required this.id, required this.name, required this.value});
  factory PageThikness.fromJson(Map<String, dynamic> json) {
    return PageThikness(id: json['id'], name: json['name'], value: json['value']);
  }
}

