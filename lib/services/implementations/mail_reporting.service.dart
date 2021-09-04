import 'dart:io';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:scherben_boot/dependecy_injection/container.dart';
import 'package:scherben_boot/models/report.dart';
import 'package:scherben_boot/services/mailing_credential_provider.service.dart';
import 'package:scherben_boot/services/reporting.service.dart';

class MailReportingService implements ReportingService {
  final MailingCredentialProvider _credentialProvider = container.resolve();

  @override
  Future<void> sendReport(Report report) async {
    final credentials = await _credentialProvider.getCredentials();
    final smtpServer = gmail(credentials.username, credentials.password);
    final equivalentMessage = Message()
      ..from = Address(credentials.username, "ScherbenBoot")
      ..recipients.add(Address(report.recipient))
      ..subject =
          "[${report.typeIdentifier}] ScherbenBoot report from ${DateTime.now().toString()}"
      ..text = _createMailBody(report)
      ..html = _createHTMLBody(report);

    if (report.attachmentPath != null) {
      equivalentMessage.attachments
          .add(FileAttachment(File(report.attachmentPath!)));
    }

    await send(equivalentMessage, smtpServer);
  }

  String _createMailBody(Report report) {
    return """Es gab eine neue Meldung vom Typ ${report.typeIdentifier}.
    Der Benutzer hat folgende Standortdaten angehängt:
      Longitude: ${report.location.longitude}
      Latitude: ${report.location.latitude}
    
    Und beschreibt die Situation wie folgt:
      ${report.description}""";
  }

  String _createHTMLBody(Report report) {
    return "";
  }
}
