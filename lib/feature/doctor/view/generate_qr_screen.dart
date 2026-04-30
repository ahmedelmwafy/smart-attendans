import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/models/subject_model.dart';
import '../../../core/services/firestore_service.dart';
import '../../../core/theme/text_styles.dart';

class GenerateQrScreen extends StatefulWidget {
  const GenerateQrScreen({super.key});

  @override
  State<GenerateQrScreen> createState() => _GenerateQrScreenState();
}

class _GenerateQrScreenState extends State<GenerateQrScreen> {
  late SubjectModel _subject;
  String _qrData = '';
  bool _useLocation = false;
  double _radius = 50.0;
  Position? _currentPosition;
  bool _isFetchingLocation = false;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _subject = ModalRoute.of(context)!.settings.arguments as SubjectModel;
    _generateNewCode();
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isFetchingLocation = true);
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      
      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition();
        setState(() {
          _currentPosition = position;
          _isFetchingLocation = false;
        });
      }
    } catch (e) {
      setState(() => _isFetchingLocation = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('خطأ في تحديد الموقع: $e')));
      }
    }
  }

  void _generateNewCode() async {
    // QR data format: "subjectId|subjectName|timestamp"
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    setState(() {
      _qrData = '${_subject.id}|${_subject.name}|$timestamp';
    });

    // Update session in Firestore
    await _firestoreService.updateSession(
      subjectId: _subject.id,
      useLocation: _useLocation,
      lat: _currentPosition?.latitude ?? 0.0,
      long: _currentPosition?.longitude ?? 0.0,
      radius: _radius,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('توليد رمز QR')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              Text(
                _subject.name,
                style: TextStyles.font20White500Weight(context).copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.sp,
                ),
              ),
              SizedBox(height: 20.h),
              
              // Location Settings Card
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                child: Padding(
                  padding: EdgeInsets.all(15.w),
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: const Text('تفعيل التحقق من الموقع'),
                        value: _useLocation,
                        onChanged: (val) {
                          setState(() => _useLocation = val);
                          if (val && _currentPosition == null) {
                            _getCurrentLocation();
                          }
                        },
                      ),
                      if (_useLocation) ...[
                        const Divider(),
                        if (_isFetchingLocation)
                          const CircularProgressIndicator()
                        else if (_currentPosition != null)
                          Text('الموقع الحالي: ${_currentPosition!.latitude.toStringAsFixed(4)}, ${_currentPosition!.longitude.toStringAsFixed(4)}')
                        else
                          ElevatedButton.icon(
                            onPressed: _getCurrentLocation,
                            icon: const Icon(Icons.location_on),
                            label: const Text('تحديد موقعي الحالي'),
                          ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            const Text('نطاق السماح (متر):'),
                            Expanded(
                              child: Slider(
                                value: _radius,
                                min: 10,
                                max: 500,
                                divisions: 49,
                                label: _radius.round().toString(),
                                onChanged: (val) => setState(() => _radius = val),
                              ),
                            ),
                            Text('${_radius.round()} م'),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 30.h),
              
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20),
                  ],
                ),
                child: QrImageView(
                  data: _qrData,
                  version: QrVersions.auto,
                  size: 200.w,
                  backgroundColor: Colors.white,
                ),
              ),
              
              SizedBox(height: 30.h),
              ElevatedButton.icon(
                onPressed: _generateNewCode,
                icon: const Icon(Icons.refresh),
                label: const Text('تحديث الرمز وتفعيل الجلسة'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
