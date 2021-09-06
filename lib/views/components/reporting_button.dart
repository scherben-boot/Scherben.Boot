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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                alignment: Alignment.topLeft,
                child: Text(
                  metadata.buttonDescription,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontFamily: "roboto",
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    metadata.buttonIcon,
                    size: 85,
                    color: Colors.grey[400],
                  ),
                ),
              )
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
            onSurface: Colors.orange,
            elevation: 5.5,
            padding: const EdgeInsets.only(
              top: 4.0,
              bottom: 4.0,
              right: 8.0,
              left: 8.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
    );
  }
}
