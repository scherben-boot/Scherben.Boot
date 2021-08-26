import 'package:flutter/material.dart';
import 'package:scherben_boot/models/point.dart';
import 'package:scherben_boot/services/geolocation.service.dart';

class LocationFormField extends FormField<Point?> {
  LocationFormField(GeolocationService geolocationService,
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
                    children: [
                      Row(
                        children: [
                          Text(locationText),
                          IconButton(
                            onPressed: () async {
                              final location = await geolocationService
                                  .getCurrentUserLocation();
                              state.didChange(location);
                            },
                            icon: Icon(Icons.my_location_outlined),
                          )
                        ],
                      )
                    ],
                  );
                },
              );
            });
}
