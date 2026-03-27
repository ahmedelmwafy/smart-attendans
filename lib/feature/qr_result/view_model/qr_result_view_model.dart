import '../model/student_qr_data.dart';

class QrResultViewModel {
  final StudentQrData data;

  QrResultViewModel(this.data);

  String get qrData => data.toQrString();
}