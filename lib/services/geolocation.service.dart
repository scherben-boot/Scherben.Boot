import 'package:scherben_boot/models/point.dart';

abstract class GeolocationService {
  Future<Point?> getCurrentUserLocation();

  Future<String?> describePoint(Point point);
}
