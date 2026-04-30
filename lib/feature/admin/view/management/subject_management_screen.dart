import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/services/firestore_service.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/models/subject_model.dart';

class SubjectManagementScreen extends StatefulWidget {
  const SubjectManagementScreen({super.key});

  @override
  State<SubjectManagementScreen> createState() => _SubjectManagementScreenState();
}

class _SubjectManagementScreenState extends State<SubjectManagementScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  List<SubjectModel> _subjects = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSubjects();
  }

  Future<void> _loadSubjects() async {
    try {
      setState(() => _isLoading = true);
      final subjects = await _firestoreService.getAllSubjects();
      if (mounted) {
        setState(() {
          _subjects = subjects;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة المواد'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.lightGreenAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _subjects.isEmpty
              ? const Center(child: Text('لا توجد مواد مضافة'))
              : ListView.builder(
                  padding: EdgeInsets.all(20.w),
                  itemCount: _subjects.length,
                  itemBuilder: (context, index) {
                    final subject = _subjects[index];
                    return _buildSubjectCard(subject);
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSubjectPage(context),
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSubjectCard(SubjectModel subject) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.book, color: Colors.green, size: 25.w),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                ),
                Text(
                  subject.doctorId == null ? 'غير نشطة (بدون دكتور)' : 'نشطة',
                  style: TextStyle(
                    color: subject.doctorId == null ? Colors.orange : Colors.green,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () => _confirmDelete(subject.id),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(String id) {
    showDialog(
      context: context,
      builder: (context) {
        bool innerLoading = false;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('تأكيد الحذف'),
              content: innerLoading
                ? const SizedBox(height: 100, child: Center(child: CircularProgressIndicator()))
                : const Text('هل أنت متأكد من حذف هذه المادة؟'),
              actions: innerLoading ? [] : [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
                TextButton(
                  onPressed: () async {
                    setState(() => innerLoading = true);
                    await _firestoreService.deleteSubject(id);
                    Navigator.pop(context);
                    _loadSubjects();
                  },
                  child: const Text('حذف', style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          }
        );
      },
    );
  }

  void _showAddSubjectPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddSubjectScreen(),
      ),
    ).then((_) => _loadSubjects());
  }
}

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({super.key});

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final nameController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة مادة جديدة')),
      body: Padding(
        padding: EdgeInsets.all(25.w),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              enabled: !_isSaving,
              decoration: InputDecoration(
                labelText: 'اسم المادة',
                prefixIcon: const Icon(Icons.book, color: Colors.green),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            const Text(
              'ملاحظة: سيتم إنشاء المادة كغير نشطة. يمكنك تفعيلها عند إضافة دكتور جديد وربطها به.',
              style: TextStyle(color: Colors.grey, fontSize: 13),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.h),
            ElevatedButton(
              onPressed: _isSaving ? null : () async {
                if (nameController.text.isNotEmpty) {
                  setState(() => _isSaving = true);
                  try {
                    await _firestoreService.addSubject(nameController.text);
                    if (mounted) Navigator.pop(context);
                  } finally {
                    if (mounted) setState(() => _isSaving = false);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 55.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
              ),
              child: _isSaving
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('حفظ المادة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
