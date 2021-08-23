import 'package:scherben_boot/models/report.dart';

abstract class ReportingService {
  Future<void> sendReport(Report report);
}
