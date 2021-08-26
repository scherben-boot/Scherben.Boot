import 'package:flutter/material.dart';
import 'package:scherben_boot/dependecy_injection/container.dart';
import 'package:scherben_boot/models/point.dart';
import 'package:scherben_boot/models/report.dart';
import 'package:scherben_boot/models/report_metadata.dart';
import 'package:scherben_boot/services/geolocation.service.dart';
import 'package:scherben_boot/services/reporting.service.dart';
import 'package:scherben_boot/views/components/location_form_field.dart';

class ReportingView extends StatefulWidget {
  final ReportingService _reportingService = container.resolve();
  final GeolocationService _geolocationService = container.resolve();
  final ReportMetadata metadata;

  ReportingView({Key? key, required this.metadata}) : super(key: key);

  @override
  _ReportingViewState createState() => _ReportingViewState();
}

class _ReportingViewState extends State<ReportingView> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();

  String? attachmentPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.metadata.formTitle),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                LocationFormField(
                  widget._geolocationService,
                  onSaved: (value) {},
                  validator: (value) {},
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Bitte geben Sie eine Beschreibung an";
                    }
                    return null;
                  },
                  controller: _descriptionController,
                ),
                ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.image_search),
                    label: Text("Bild anfügen")),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final description = _descriptionController.text;
                      final location = Point(0, 0);

                      await widget._reportingService.sendReport(
                          Report.fromMetadata(widget.metadata, description,
                              attachmentPath, location));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Meldung wurde erstattet")),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Senden"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
