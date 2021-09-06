import 'package:flutter/material.dart';
import 'package:scherben_boot/models/report_metadata.dart';

import '../reporting_view.dart';

class ReportingButton extends StatelessWidget {
  const ReportingButton({
    Key? key,
    required this.metadata,
  }) : super(key: key);

  final ReportMetadata metadata;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.only(left: 15.0, top: 15.0),
              alignment: Alignment.topLeft,
              child: Text(
                metadata.buttonDescription,
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
                  metadata.buttonIcon,
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
                builder: (context) => ReportingView(metadata: metadata)),
          );
        },
        style: ElevatedButton.styleFrom(
          primary: metadata.primaryColor,
          onPrimary: Colors.white,
          onSurface: Colors.orange,
          shadowColor: Colors.black.withOpacity(0.9),
          elevation: 10.0,
          textStyle: TextStyle(fontFamily: 'roboto'),
          padding: const EdgeInsets.only(
              top: 4.0, bottom: 4.0, right: 8.0, left: 8.0),
          minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
      ),
    );
  }
}
