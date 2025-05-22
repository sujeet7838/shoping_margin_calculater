class Gsmmodel {
  final int id;
  final String name;

  Gsmmodel({required this.id, required this.name});
  factory Gsmmodel.fromJson(Map<String, dynamic> json) {
    return Gsmmodel(id: json['id'], name: json['name']);
  }
}
