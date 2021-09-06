import 'package:flutter/material.dart';

class ReportMetadata {
  final String typeIdentifier;
  final String recipient;
  final String formTitle;
  final String buttonDescription;
  final IconData buttonIcon;
  final Color primaryColor;

  ReportMetadata(this.typeIdentifier, this.recipient, this.formTitle,
      this.buttonDescription, this.buttonIcon, this.primaryColor);
}
