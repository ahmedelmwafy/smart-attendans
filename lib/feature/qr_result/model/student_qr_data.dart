class StudentQrData {
  final String name;
  final String id;
  final String department;
  final String band;
  final String branch;
  final String course;

  const StudentQrData({
    required this.name,
    required this.id,
    required this.department,
    required this.band,
    required this.branch,
    required this.course,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'department': department,
      'band': band,
      'branch': branch,
      'course': course,
    };
  }

  String toQrString() {
    return '''
Name: $name
ID: $id
Department: $department
Band: $band
Branch: $branch
Course: $course
''';
  }
}