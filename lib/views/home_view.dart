import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scherben_boot/dependecy_injection/container.dart' as di;
import 'package:scherben_boot/models/report_metadata.dart';
import 'package:scherben_boot/services/geolocation.service.dart';
import 'package:scherben_boot/views/reporting_view.dart';

class HomeView extends StatefulWidget {
  final GeolocationService _geolocationService = di.container.resolve();

  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final danger = new ReportMetadata(
      "Incident", "schmidlu@dhbw-loerrach.de", "Gefahr melden");
  final proposal = new ReportMetadata(
      "Proposal", "sommeref@dhbw-loerrach.de", "Neuer Vorschlag");

  bool isWithinBoundaries = false;

  @override
  Widget build(BuildContext context) {
    widget._geolocationService.subscribeToBoundaryChanges((boundaryReport) =>
        setState(() => isWithinBoundaries = boundaryReport.isWithinBoundaries));

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Scherben Boot',
            style:
                GoogleFonts.dancingScript(color: Colors.white, fontSize: 30)),
      ),
      body: Column(children: [
        Flexible(
          flex: 3,
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/rheinfelden2.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        Expanded(
            flex: 0,
            child: Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 5.0),
              child: Text(
                '📍 Du befindest dich in Rheinfelden',
                style: new TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.left,
              ),
            )),
        Divider(
          height: 25,
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: ElevatedButton(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Melde eine Gefahr",
                      style: new TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.warning_amber_outlined,
                        color: Colors.grey[400],
                        size: 100,
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReportingView(metadata: danger)),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow[700],
                onPrimary: Colors.white,
                onSurface: Colors.orange,
                shadowColor: Colors.black.withOpacity(0.9),
                elevation: 10.0,
                textStyle: TextStyle(fontFamily: 'roboto'),
                padding: const EdgeInsets.only(
                    top: 4.0, bottom: 4.0, right: 8.0, left: 8.0),
                minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: ElevatedButton(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Mach einen Vorschlag",
                      style: new TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.emoji_objects_outlined,
                        color: Colors.grey[400],
                        size: 100,
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReportingView(metadata: proposal)),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.lightGreen[700],
                onPrimary: Colors.white,
                onSurface: Colors.orange,
                shadowColor: Colors.black.withOpacity(0.9),
                elevation: 10.0,
                textStyle: TextStyle(fontFamily: 'roboto'),
                padding: const EdgeInsets.only(
                    top: 4.0, bottom: 4.0, right: 8.0, left: 8.0),
                minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
