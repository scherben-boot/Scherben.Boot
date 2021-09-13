import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scherben_boot/dependecy_injection/container.dart' as di;
import 'package:scherben_boot/services/geolocation.service.dart';
import 'package:scherben_boot/views/components/home_view_outoff_boundaries.dart';
import 'package:scherben_boot/views/components/home_view_within_boundaries.dart';

class HomeView extends StatefulWidget {
  final GeolocationService _geolocationService = di.container.resolve();

  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isWithinBoundaries = false;

  @override
  Widget build(BuildContext context) {
    widget._geolocationService.subscribeToBoundaryChanges((boundaryReport) =>
        setState(() => isWithinBoundaries = boundaryReport.isWithinBoundaries));

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.sailing_outlined),
        titleSpacing: 0,
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
        Divider(
          height: 25,
        ),
        isWithinBoundaries
            ? HomeViewWithinBoundaries()
            : HomeViewOutoffBoundaries()
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget._geolocationService.cancelSubscription();
  }
}
