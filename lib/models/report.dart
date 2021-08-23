import 'package:scherben_boot/models/point.dart';
import 'package:scherben_boot/models/report_metadata.dart';

class Report {
  late String typeIdentifier;
  late String recipient;
  final String? description;
  final String? attachmentPath;
  final Point location;

  Report.fromMetadata(ReportMetadata metadata, this.description,
      this.attachmentPath, this.location)
      : assert(attachmentPath != null || description != null) {
    typeIdentifier = metadata.typeIdentifier;
    recipient = metadata.recipient;
  }
}
