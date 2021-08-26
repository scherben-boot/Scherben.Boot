import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scherben_boot/models/report_metadata.dart';
import 'package:scherben_boot/views/reporting_view.dart';

// Buttons in einer Foreach Schleife

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final danger = new ReportMetadata(
      "Incident", "schmidlu@dhbw-loerrach.de", "Gefahr melden");
  final proposal = new ReportMetadata(
      "Proposal", "sommeref@dhbw-loerrach.de", "Neuer Vorschlag");

  bool isWithinBoundaries = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // leading: Padding(
          //   padding: EdgeInsets.all(10),
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(8.0),
          //     child: Image(
          //       image: AssetImage('assets/dhbw_white.png'),
          //     ),
          //   ),
          // ),
          centerTitle: false,
          title: Text('Scherben Boot',
              style:
                  GoogleFonts.dancingScript(color: Colors.white, fontSize: 30)),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.my_location_outlined),
              onPressed: () {},
            )
          ]),
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
                //button's fill color
                onPrimary: Colors.white,
                //specify the color of the button's text and icons as well as the overlay colors used to indicate the hover, focus, and pressed states
                onSurface: Colors.orange,
                //specify the button's disabled text, icon, and fill color
                shadowColor: Colors.black.withOpacity(0.9),
                //specify the button's elevation color
                elevation: 10.0,
                //buttons Material shadow
                textStyle: TextStyle(fontFamily: 'roboto'),
                //specify the button's text TextStyle
                padding: const EdgeInsets.only(
                    top: 4.0, bottom: 4.0, right: 8.0, left: 8.0),
                //specify the button's Padding
                minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 0),
                //specify the button's first: width and second: height
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        20.0)), // set the buttons shape. Make its birders rounded etc
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
