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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.width * 0.25,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: LocationFormField(
                        widget._geolocationService,
                        onSaved: (value) {},
                        validator: (value) {},
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.width * 0.6,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Bitte geben Sie eine Beschreibung an";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Beschreibung",
                        ),
                        controller: _descriptionController,
                        minLines: 7,
                        maxLines: 12,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.width * 0.4,
                  child: Card(
                    child: Column(children: [
                      Align(
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 10.0)),
                              Expanded(
                                child: ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: Icon(Icons.image_search),
                                    label: Text("Bild anfügen")),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5.0)),
                              Expanded(
                                child: ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: Icon(Icons.delete),
                                    label: Text("Bild entfernen")),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(right: 10.0)),
                            ],
                          ))
                    ]),
                  ),
                ),
                Divider(
                  height: MediaQuery.of(context).size.width * 0.05,
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: ElevatedButton(
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
