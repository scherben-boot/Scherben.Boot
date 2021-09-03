import 'package:flutter/material.dart';
import 'package:scherben_boot/models/point.dart';
import 'package:scherben_boot/services/geolocation.service.dart';

class LocationFormField extends FormField<Point?> {
  LocationFormField(GeolocationService geolocationService, double? sizeForText,
      double? sizeForIcon,
      {required FormFieldSetter<Point?> onSaved,
      required FormFieldValidator<Point?> validator})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            builder: (FormFieldState<Point?> state) {
              return FutureBuilder(
                future: state.value != null
                    ? geolocationService.describePoint(state.value!)
                    : Future.value(""),
                builder: (builder, snapshot) {
                  final String locationText =
                      snapshot.connectionState == ConnectionState.done &&
                              snapshot.data != ""
                          ? snapshot.data!.toString()
                          : "Unbekannter Ort";
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /* Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            color: Colors.blue,
                          ),
                          Text(locationText),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () async {
                                final location = await geolocationService
                                    .getCurrentUserLocation();
                                state.didChange(location);
                              },
                              icon: Icon(Icons.my_location_outlined),
                            ),
                          )
                        ],
                      )*/
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle_outlined,
                              color: Colors.lightGreen[700],
                              size: sizeForIcon,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Standort erforlgreich erfasst",
                                style: TextStyle(fontSize: sizeForText)),
                          ],
                        ),
                      )
                    ],
                  );
                },
              );
            });
}
