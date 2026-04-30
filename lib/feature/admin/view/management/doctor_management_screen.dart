import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/services/firestore_service.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/models/subject_model.dart';

class DoctorManagementScreen extends StatefulWidget {
  const DoctorManagementScreen({super.key});

  @override
  State<DoctorManagementScreen> createState() => _DoctorManagementScreenState();
}

class _DoctorManagementScreenState extends State<DoctorManagementScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  List<UserModel> _doctors = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDoctors();
  }

  Future<void> _loadDoctors() async {
    try {
      setState(() => _isLoading = true);
      final doctors = await _firestoreService.getDoctors();
      if (mounted) {
        setState(() {
          _doctors = doctors;
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
        title: const Text('إدارة الدكاترة'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.orangeAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _doctors.isEmpty
              ? const Center(child: Text('لا يوجد دكاترة مضافين'))
              : ListView.builder(
                  padding: EdgeInsets.all(20.w),
                  itemCount: _doctors.length,
                  itemBuilder: (context, index) {
                    final doctor = _doctors[index];
                    return _buildDoctorCard(doctor);
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDoctorPage(context),
        backgroundColor: Colors.orange,
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }

  Widget _buildDoctorCard(UserModel doctor) {
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
              color: Colors.orange.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.supervisor_account, color: Colors.orange, size: 25.w),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                ),
                Text(
                  doctor.email,
                  style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () => _confirmDelete(doctor.id),
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
                : const Text('هل أنت متأكد من حذف هذا الدكتور؟'),
              actions: innerLoading ? [] : [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
                TextButton(
                  onPressed: () async {
                    setState(() => innerLoading = true);
                    await _firestoreService.deleteUser(id);
                    Navigator.pop(context);
                    _loadDoctors();
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

  void _showAddDoctorPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddDoctorScreen(),
      ),
    ).then((_) => _loadDoctors());
  }
}

class AddDoctorScreen extends StatefulWidget {
  const AddDoctorScreen({super.key});

  @override
  State<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();
  
  List<SubjectModel> _unassignedSubjects = [];
  final List<String> _selectedSubjectIds = [];
  bool _loadingSubjects = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadUnassignedSubjects();
  }

  Future<void> _loadUnassignedSubjects() async {
    try {
      final subjects = await _firestoreService.getUnassignedSubjects();
      if (mounted) {
        setState(() {
          _unassignedSubjects = subjects;
          _loadingSubjects = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _loadingSubjects = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة دكتور جديد')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(nameController, 'اسم الدكتور', Icons.person, Colors.orange),
            _buildTextField(emailController, 'البريد الإلكتروني', Icons.email, Colors.orange),
            _buildTextField(passwordController, 'كلمة المرور', Icons.lock, Colors.orange, isPassword: true),
            SizedBox(height: 20.h),
            
            Text(
              'اختر المواد الدراسية:',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.orange),
            ),
            SizedBox(height: 10.h),
            _loadingSubjects
                ? const Center(child: CircularProgressIndicator())
                : _unassignedSubjects.isEmpty
                  ? const Text('لا توجد مواد غير مسندة حالياً', style: TextStyle(color: Colors.grey))
                  : Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: _unassignedSubjects.map((subject) {
                        final isSelected = _selectedSubjectIds.contains(subject.id);
                        return FilterChip(
                          label: Text(subject.name),
                          selected: isSelected,
                          onSelected: _isSaving ? null : (selected) {
                            setState(() {
                              if (selected) {
                                _selectedSubjectIds.add(subject.id);
                              } else {
                                _selectedSubjectIds.remove(subject.id);
                              }
                            });
                          },
                          selectedColor: Colors.orange.withOpacity(0.2),
                          checkmarkColor: Colors.orange,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.orange : Colors.black87,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        );
                      }).toList(),
                    ),
            
            SizedBox(height: 40.h),
            ElevatedButton(
              onPressed: _isSaving ? null : () async {
                if (nameController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                  setState(() => _isSaving = true);
                  try {
                    final result = await _authService.signUp(
                      emailController.text,
                      passwordController.text,
                      nameController.text,
                      null,
                      isDoctor: true,
                    );
                    
                    if (result != null && _selectedSubjectIds.isNotEmpty) {
                      for (var id in _selectedSubjectIds) {
                        await _firestoreService.assignSubjectToDoctor(id, result.user!.uid);
                      }
                    }
                    
                    if (mounted) Navigator.pop(context);
                  } finally {
                    if (mounted) setState(() => _isSaving = false);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: Size(double.infinity, 55.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
              ),
              child: _isSaving
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('حفظ الدكتور والمواد', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, Color color, {bool isPassword = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        enabled: !_isSaving,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: color),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
