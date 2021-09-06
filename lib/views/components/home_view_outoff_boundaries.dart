//import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

class HomeViewOutoffBoundaries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        child: Column(
          children: [
            Icon(
              Icons.location_off_outlined,
              color: Colors.grey[400],
              size: 200,
            ),
            Text("Bitte begeben Sie sich nach Rheinfelden",
                style: new TextStyle(fontSize: 20)),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: new GestureDetector(
                /*onTap: () {
                  AppSettings.openLocationSettings();
                },*/
                child: new Text(
                  "Erlauben Sie die Nutzung Ihres Standortes",
                  style: new TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
