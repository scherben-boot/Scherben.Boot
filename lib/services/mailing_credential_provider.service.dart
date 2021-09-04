import 'package:scherben_boot/models/mailing_credentials.dart';

abstract class MailingCredentialProvider {
  Future<MailingCredentials> getCredentials();
}
