import 'package:flutter/material.dart';
import 'package:scherben_boot/models/report_metadata.dart';
import 'package:scherben_boot/views/components/reporting_button.dart';

class HomeViewWithinBoundaries extends StatelessWidget {
  final danger = new ReportMetadata(
      "Incident",
      "schmidlu@dhbw-loerrach.de",
      "Gefahr melden",
      "Melde eine Gefahr",
      Icons.warning_amber_outlined,
      Colors.yellow[700]!);
  final proposal = new ReportMetadata(
      "Proposal",
      "sommeref@dhbw-loerrach.de",
      "Neuer Vorschlag",
      "Mach einen Vorschlag",
      Icons.emoji_objects_outlined,
      Colors.lightGreen[700]!);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 4,
        child: Column(children: [
          ReportingButton(metadata: danger),
          SizedBox(
            height: 20,
          ),
          ReportingButton(metadata: proposal)
        ]));
  }
}
