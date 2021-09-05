import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LocationDisclaimer extends StatelessWidget {
  const LocationDisclaimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outlined,
                    color: Colors.lightGreen[700],
                    size: MediaQuery.of(context).size.height * 0.05,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Standort erforlgreich erfasst",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
