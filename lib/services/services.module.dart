import 'package:kiwi/src/kiwi_container.dart';
import 'package:scherben_boot/dependecy_injection/module.dart';
import 'package:scherben_boot/services/geolocation.service.dart';
import 'package:scherben_boot/services/implementations/mail_reporting.service.dart';
import 'package:scherben_boot/services/reporting.service.dart';

class ServicesModule implements Module {
  @override
  void registerModule(KiwiContainer container) {
    container.registerSingleton<ReportingService>(
        (container) => MailReportingService());
    container.registerSingleton((container) => GeolocationService());
  }
}
