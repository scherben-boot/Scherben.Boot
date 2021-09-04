import 'package:kiwi/src/kiwi_container.dart';
import 'package:scherben_boot/dependecy_injection/module.dart';
import 'package:scherben_boot/services/geolocation.service.dart';
import 'package:scherben_boot/services/implementations/image_picker_image_provider.service.dart';
import 'package:scherben_boot/services/implementations/location.service.dart';
import 'package:scherben_boot/services/implementations/mail_reporting.service.dart';
import 'package:scherben_boot/services/implementations/unsecure_mailing_credential_provider.dart';
import 'package:scherben_boot/services/mailing_credential_provider.service.dart';
import 'package:scherben_boot/services/reporting.service.dart';
import 'image_provider.service.dart';

class ServicesModule implements Module {
  @override
  void registerModule(KiwiContainer container) {
    container.registerSingleton<ReportingService>(
        (container) => MailReportingService());
    container.registerSingleton<GeolocationService>(
        (container) => LocationService());
    container.registerSingleton<ImageProviderService>(
        (container) => ImagePickerImageProviderService());
    container.registerSingleton<MailingCredentialProvider>(
        (container) => UnsecureMailingCredentialProvider());
  }
}
