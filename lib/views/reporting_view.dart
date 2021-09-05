import 'package:flutter/material.dart';
import 'package:scherben_boot/dependecy_injection/container.dart';
import 'package:scherben_boot/models/report.dart';
import 'package:scherben_boot/models/report_metadata.dart';
import 'package:scherben_boot/services/geolocation.service.dart';
import 'package:scherben_boot/services/image_provider.service.dart';
import 'package:scherben_boot/services/reporting.service.dart';
import 'package:scherben_boot/views/components/description_card.dart';
import 'package:scherben_boot/views/components/image_picker_card.dart';
import 'package:scherben_boot/views/components/location_disclaimer.dart';

class ReportingView extends StatefulWidget {
  final ReportingService _reportingService = container.resolve();
  final GeolocationService _geolocationService = container.resolve();
  final ImageProviderService _imageProviderService = container.resolve();
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
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(widget.metadata.formTitle),
          ),
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    LocationDisclaimer(),
                    DescriptionCard(
                      descriptionController: _descriptionController,
                    ),
                    ImagePickerCard(
                      imageProviderService: widget._imageProviderService,
                      onSaved: (filePath) =>
                          setState(() => attachmentPath = filePath),
                    ),
                    Expanded(child: Divider()),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          final description = _descriptionController.text;
                          final location = await widget._geolocationService
                              .getCurrentUserLocation();

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
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueGrey[500],
                        minimumSize: Size(
                          MediaQuery.of(context).size.width * 0.95,
                          MediaQuery.of(context).size.height * 0.05,
                        ),
                      ),
                      child: Text(
                        "Senden",
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ));
  }
}
