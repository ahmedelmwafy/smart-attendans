import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/subject_model.dart';
import '../models/attendance_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Student Validation & Management (Directory)
  Future<Map<String, dynamic>?> validateStudent(
    String name,
    String studentId,
  ) async {
    final query = await _db
        .collection('students')
        .where('Name', isEqualTo: name)
        .where('Student_ID', isEqualTo: int.tryParse(studentId) ?? studentId)
        .get();

    if (query.docs.isNotEmpty) {
      return query.docs.first.data();
    }
    return null;
  }

  Future<void> addStudentToDirectory(
    String name,
    String studentId,
    String branch,
    String department,
    String grade,
  ) async {
    await _db.collection('students').add({
      'Name': name,
      'Student_ID': int.tryParse(studentId) ?? studentId,
      'Branch': branch,
      'Department': department,
      'Grade': grade,
    });
  }

  Future<void> updateStudentInDirectory(
    String docId,
    String name,
    String studentId,
    String branch,
    String department,
    String grade,
  ) async {
    await _db.collection('students').doc(docId).update({
      'Name': name,
      'Student_ID': int.tryParse(studentId) ?? studentId,
      'Branch': branch,
      'Department': department,
      'Grade': grade,
    });
  }

  Future<List<Map<String, dynamic>>> getAllStudentsFromDirectory() async {
    final query = await _db.collection('students').get();
    return query.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
  }

  Future<void> deleteStudentFromDirectory(String docId) async {
    await _db.collection('students').doc(docId).delete();
  }

  // User Management
  Future<void> createUser(UserModel user) async {
    await _db.collection('users').doc(user.id).set(user.toMap());
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    }
    return null;
  }

  Future<List<UserModel>> getDoctors() async {
    final query = await _db
        .collection('users')
        .where('role', isEqualTo: 'doctor')
        .get();
    return query.docs.map((d) => UserModel.fromMap(d.data())).toList();
  }

  Future<void> deleteUser(String uid) async {
    await _db.collection('users').doc(uid).delete();
  }

  // Subject Management
  Future<void> addSubject(String name, {String? doctorId}) async {
    final doc = _db.collection('subjects').doc();
    await doc.set({'id': doc.id, 'name': name, 'doctorId': doctorId});
  }

  Future<void> deleteSubject(String subjectId) async {
    await _db.collection('subjects').doc(subjectId).delete();
  }

  Future<void> assignSubjectToDoctor(String subjectId, String doctorId) async {
    await _db.collection('subjects').doc(subjectId).update({
      'doctorId': doctorId,
    });
  }

  Future<List<SubjectModel>> getUnassignedSubjects() async {
    final query = await _db
        .collection('subjects')
        .where('doctorId', isNull: true)
        .get();
    return query.docs.map((doc) => SubjectModel.fromMap(doc.data())).toList();
  }

  Future<List<SubjectModel>> getAllSubjects() async {
    final query = await _db.collection('subjects').get();
    return query.docs.map((doc) => SubjectModel.fromMap(doc.data())).toList();
  }

  Future<List<SubjectModel>> getDoctorSubjects(String doctorId) async {
    final query = await _db
        .collection('subjects')
        .where('doctorId', isEqualTo: doctorId)
        .get();
    return query.docs.map((doc) => SubjectModel.fromMap(doc.data())).toList();
  }

  // Attendance Management
  Future<void> recordAttendance(AttendanceRecordModel record) async {
    await _db.collection('attendance').add(record.toMap());
  }

  Future<List<AttendanceRecordModel>> getStudentHistory(
    String studentId,
  ) async {
    final query = await _db
        .collection('attendance')
        .where('studentId', isEqualTo: studentId)
        .get();

    final records = query.docs
        .map((d) => AttendanceRecordModel.fromMap(d.data()))
        .toList();
    records.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return records;
  }

  Future<List<AttendanceRecordModel>> getSubjectHistory(
    String subjectId,
  ) async {
    final query = await _db
        .collection('attendance')
        .where('subjectId', isEqualTo: subjectId)
        .get();

    final records = query.docs
        .map((d) => AttendanceRecordModel.fromMap(d.data()))
        .toList();
    records.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return records;
  }

  Future<List<AttendanceRecordModel>> getAllAttendance() async {
    final query = await _db.collection('attendance').get();

    final records = query.docs
        .map((d) => AttendanceRecordModel.fromMap(d.data()))
        .toList();
    records.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return records;
  }

  // Session & Location Management
  Future<void> updateSession({
    required String subjectId,
    required bool useLocation,
    required double lat,
    required double long,
    required double radius,
  }) async {
    await _db.collection('sessions').doc(subjectId).set({
      'useLocation': useLocation,
      'lat': lat,
      'long': long,
      'radius': radius,
      'lastUpdated': FieldValue.serverTimestamp(),
    });
  }

  Future<Map<String, dynamic>?> getSession(String subjectId) async {
    final doc = await _db.collection('sessions').doc(subjectId).get();
    return doc.data();
  }
}
