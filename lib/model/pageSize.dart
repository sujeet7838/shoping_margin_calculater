class PageSize {
  final int id;
  final String name;
  final int value;

  PageSize({required this.id, required this.name, required this.value});
  factory PageSize.fromJson(Map<String, dynamic> json) {
    return PageSize(id: json['id'], name: json['name'], value: json['value']);
  }
}

