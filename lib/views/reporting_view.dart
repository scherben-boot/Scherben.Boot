import 'package:flutter/material.dart';
import 'package:scherben_boot/dependecy_injection/container.dart';
import 'package:scherben_boot/models/point.dart';
import 'package:scherben_boot/models/report.dart';
import 'package:scherben_boot/models/report_metadata.dart';
import 'package:scherben_boot/services/reporting.service.dart';

class ReportingView extends StatefulWidget {
  final ReportingService _reportingService = container.resolve();
  final ReportMetadata metadata;

  ReportingView({Key? key, required this.metadata}) : super(key: key);

  @override
  _ReportingViewState createState() => _ReportingViewState();
}

class _ReportingViewState extends State<ReportingView> {
  String? attachmentPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.metadata.formTitle),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.image_search),
                label: Text("Bild anfügen")),
            ElevatedButton(
              onPressed: () async {
                final description = "";
                final location = Point(0, 0);

                await widget._reportingService.sendReport(Report.fromMetadata(
                    widget.metadata, description, attachmentPath, location));
                Navigator.pop(context);
              },
              child: Text("Senden"),
            ),
          ],
        ),
      ),
    );
  }
}
