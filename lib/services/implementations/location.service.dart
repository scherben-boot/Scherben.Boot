import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';
import 'package:scherben_boot/models/point.dart';

import '../geolocation.service.dart';

class LocationService implements GeolocationService {
  @override
  Future<Point?> getCurrentUserLocation() async {
    Location location = new Location();

    bool _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    try {
      PermissionStatus _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return null;
        }
      }
    } catch (e) {
      print(e);
    }

    LocationData _locationData = await location.getLocation();
    return Point(_locationData.longitude!, _locationData.latitude!);
  }

  @override
  Future<String?> describePoint(Point point) async {
    List<geocoding.Placemark> placemarks = await geocoding
        .placemarkFromCoordinates(point.latitude, point.longitude);

    if (placemarks.isNotEmpty) return placemarks.first.name;
  }
}
