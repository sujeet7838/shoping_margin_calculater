class Boundtype {
  final int id;
  final String name;
  final String value;

  Boundtype({required this.id, required this.name, required this.value});
  factory Boundtype.fromJson(Map<String, dynamic> json) {
    return Boundtype(id: json['id'], name: json['name'], value: json['value']);
  }
}
  // Staple bound types 
  // 0 to 11

 // spiral bound types

//  12 to 17