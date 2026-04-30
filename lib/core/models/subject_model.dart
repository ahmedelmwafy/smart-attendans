class SubjectModel {
  final String id;
  final String name;
  final String? doctorId;

  SubjectModel({
    required this.id,
    required this.name,
    this.doctorId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'doctorId': doctorId,
    };
  }

  factory SubjectModel.fromMap(Map<String, dynamic> map) {
    return SubjectModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      doctorId: map['doctorId'],
    );
  }
}
