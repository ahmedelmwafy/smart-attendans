import 'package:flutter/material.dart';

class StudentFormViewModel {
  final nameController = TextEditingController();
  final idController = TextEditingController();
  final departmentController = TextEditingController();
  final bandController = TextEditingController();
  final branchController = TextEditingController();
  final courseController = TextEditingController();

  void dispose() {
    nameController.dispose();
    idController.dispose();
    departmentController.dispose();
    bandController.dispose();
    branchController.dispose();
    courseController.dispose();
  }

  void generateQr(BuildContext context) {
    final name = nameController.text.trim();
    final id = idController.text.trim();
    final department = departmentController.text.trim();
    final band = bandController.text.trim();
    final branch = branchController.text.trim();
    final course = courseController.text.trim();

    if (name.isEmpty ||
        id.isEmpty ||
        department.isEmpty ||
        band.isEmpty ||
        branch.isEmpty ||
        course.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields')),
      );
      return;
    }

    // TODO: Generate QR logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('QR Code Generated Successfully')),
    );
  }
}