import 'package:flutter/material.dart';
import 'package:scherben_boot/models/report_metadata.dart';
import 'package:scherben_boot/views/components/reporting_button.dart';

class HomeViewWithinBoundaries extends StatelessWidget {
  final danger = new ReportMetadata(
      typeIdentifier: "Incident",
      recipient: "scherbenboot.incident@gmail.com",
      formTitle: "Gefahr melden",
      buttonDescription: "Melde eine Gefahr",
      buttonIcon: Icons.warning_amber_outlined,
      primaryColor: Colors.yellow[700]!);

  final proposal = new ReportMetadata(
      typeIdentifier: "Proposal",
      recipient: "scherbenboot.proposal@gmail.com",
      formTitle: "Neuer Vorschlag",
      buttonDescription: "Mach einen Vorschlag",
      buttonIcon: Icons.emoji_objects_outlined,
      primaryColor: Colors.lightGreen[700]!);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 4,
        child: Column(children: [
          ReportingButton(metadata: danger),
          ReportingButton(metadata: proposal)
        ]));
  }
}
