class CoverBoard {
  final int id;
  final String name;
  final String value;

  CoverBoard({required this.id, required this.name, required this.value});
  factory CoverBoard.fromJson(Map<String, dynamic> json) {
    return CoverBoard(id: json['id'], name: json['name'], value: json['value']);
  }
}