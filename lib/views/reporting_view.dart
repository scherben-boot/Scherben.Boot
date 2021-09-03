import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scherben_boot/dependecy_injection/container.dart';
import 'package:scherben_boot/models/point.dart';
import 'package:scherben_boot/models/report.dart';
import 'package:scherben_boot/models/report_metadata.dart';
import 'package:scherben_boot/services/geolocation.service.dart';
import 'package:scherben_boot/services/image_provider.service.dart';
import 'package:scherben_boot/services/reporting.service.dart';
import 'package:scherben_boot/views/components/location_form_field.dart';

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
  String? _imagePath;

  Future<void> _updateImagePath(bool includeImage) async {
    if (!includeImage) {
      setState(() {
        _imagePath = null;
      });
      return;
    }
    final imagePath = await widget._imageProviderService.pickImage();
    setState(() {
      _imagePath = imagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(widget.metadata.formTitle),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: LocationFormField(
                          widget._geolocationService,
                          MediaQuery.of(context).size.height * 0.02,
                          MediaQuery.of(context).size.height * 0.05,
                          onSaved: (value) {},
                          validator: (value) {},
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height * 0.3,
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
                          maxLines: 99,
                          decoration: InputDecoration(
                            hintText: "Beschreibung",
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.0),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blueGrey, width: 0.0),
                            ),
                          ),
                          controller: _descriptionController,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Card(
                      child: Column(children: [
                        Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, bottom: 5.0),
                              child: Row(
                                children: [
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0)),
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        (includeImage) =>
                                            _updateImagePath(includeImage);
                                      },
                                      icon: Icon(Icons.image_search),
                                      label: Text("Bild anfügen"),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.blueGrey[500],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 5.0)),
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () {},
                                      icon: Icon(Icons.delete),
                                      label: Text("Bild entfernen"),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.blueGrey[500],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0)),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Icon(
                                Icons.image_not_supported_outlined,
                                color: Colors.grey[400],
                                size:
                                    MediaQuery.of(context).size.height * 0.125,
                              ),
                              Text(
                                "Kein Bild hinzugefügt",
                                style: TextStyle(color: Colors.grey[400]),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                  Divider(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final description = _descriptionController.text;
                              final location = Point(0, 0);

                              await widget._reportingService.sendReport(
                                  Report.fromMetadata(widget.metadata,
                                      description, attachmentPath, location));
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
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ));
  }
}
