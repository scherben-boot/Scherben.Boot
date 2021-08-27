import 'dart:io';

import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';
import 'package:scherben_boot/models/boundary_report.dart';
import 'package:scherben_boot/models/point.dart';
import 'package:scherben_boot/models/polygon.dart';

import '../geolocation.service.dart';

class LocationService implements GeolocationService {
  static final Polygon _allowedArea = Polygon([
    Point(47.54603648878054, 7.7150186725964005),
    Point(47.56549920466025, 7.7066072656258),
    Point(47.57708072251098, 7.7172502703641115),
    Point(47.60613905058391, 7.718108577197846),
    Point(47.61099982512743, 7.727206630064094),
    Point(47.61667015712981, 7.729438227831804),
    Point(47.62199276640987, 7.751410882775416),
    Point(47.622339874280264, 7.785914817491557),
    Point(47.61829013905517, 7.7886613993595075),
    Point(47.62523235024023, 7.821277059041431),
    Point(47.61632301161574, 7.836383259315163),
    Point(47.607875093729255, 7.83209172514649),
    Point(47.600814828040065, 7.840846454850586),
    Point(47.586459875113505, 7.832435047879984),
    Point(47.5866914378568, 7.818530477173479),
    Point(47.56827900234754, 7.810634053700952),
    Point(47.555768750172525, 7.790892996525052),
    Point(47.544877765650895, 7.753127495840719),
    Point(47.54209672606116, 7.7242883862272285),
    Point(47.55356756345643, 7.710040492787231)
  ]);

  final Location _location = Location();
  Point? _lastKnownLocation;
  LocationObserver? _observer;

  @override
  Point? getCurrentUserLocation() {
    return _lastKnownLocation;
  }

  @override
  Future<String?> describePoint(Point point) async {
    List<geocoding.Placemark> placemarks = await geocoding
        .placemarkFromCoordinates(point.latitude, point.longitude);

    if (placemarks.isNotEmpty) return placemarks.first.name;
  }

  @override
  void subscribeToBoundaryChanges(LocationObserver observer) {
    _observer = observer;
  }

  void publishBoundaryReport(LocationData event, LocationObserver? observer) {
    if (observer == null) return;

    var boundaryReport = BoundaryReport(
        event.longitude!,
        event.latitude!,
        _allowedArea
            .isWithinBoundaries(Point(event.latitude!, event.longitude!)));

    observer.call(boundaryReport);
  }

  @override
  Future<void> initialize() async {
    bool _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    PermissionStatus _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _location.onLocationChanged.listen((event) {
      _lastKnownLocation = Point(event.latitude!, event.longitude!);
      publishBoundaryReport(event, _observer);
    });
  }
}
