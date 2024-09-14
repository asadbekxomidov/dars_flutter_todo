class Notes {
  final int? id;
  final String name;
  final String phone;

  Notes({this.id, required this.name, required this.phone});

  factory Notes.fromMap(Map<String, dynamic> json) => Notes(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
    };
  }
}
