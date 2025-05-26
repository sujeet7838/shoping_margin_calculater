class NoOfPageModel {
  final int id;
  final String name;
  final int value;

  NoOfPageModel({required this.id, required this.name, required this.value});
  factory NoOfPageModel.fromJson(Map<String, dynamic> json) {
    return NoOfPageModel(
      id: json['id'],
      name: json['name'],
      value: json['value'],
    );
  }
}
