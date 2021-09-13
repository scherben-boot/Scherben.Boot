import 'package:scherben_boot/models/mailing_credentials.dart';
import 'package:scherben_boot/services/mailing_credential_provider.service.dart';

class UnsecureMailingCredentialProvider implements MailingCredentialProvider {
  @override
  Future<MailingCredentials> getCredentials() {
    return Future.value(
        MailingCredentials("scherben.boot@gmail.com", "rqXkXaa]79d5[/h!\"j7("));
  }
}
