import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

class HomeViewOutoffBoundaries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Icon(
                      Icons.location_off_outlined,
                      color: Colors.grey[400],
                      size: MediaQuery.of(context).size.width * 0.5,
                    ),
                  ),
                )),
            Expanded(
                child: Container(
              child: Text("Bitte begeben Sie sich nach Rheinfelden",
                  style: new TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.048)),
            )),
            Expanded(
                child: Container(
                    child: Align(
              alignment: Alignment.bottomCenter,
              child: new GestureDetector(
                onTap: () {
                  AppSettings.openLocationSettings();
                },
                child: new Text(
                  "Erlauben Sie die Nutzung Ihres Standortes",
                  style: new TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: MediaQuery.of(context).size.width * 0.036),
                ),
              ),
            )))
          ],
        ),
      ),
    );
  }
}
