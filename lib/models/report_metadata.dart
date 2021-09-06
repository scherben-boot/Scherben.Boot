import 'package:flutter/material.dart';

class ReportMetadata {
  final String typeIdentifier;
  final String recipient;
  final String formTitle;
  final String buttonDescription;
  final IconData buttonIcon;
  final Color primaryColor;

  ReportMetadata(
      {required this.typeIdentifier,
      required this.recipient,
      required this.formTitle,
      required this.buttonDescription,
      required this.buttonIcon,
      required this.primaryColor});
}
