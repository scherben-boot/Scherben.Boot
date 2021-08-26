import 'package:scherben_boot/models/point.dart';

class GeolocationService {
  Future<Point> getCurrentUserLocation() async {
    return Point(100, 0);
  }

  Future<String> describePoint(Point point) async {
    return "Schützenstraße 3A, Lörrach";
  }
}
