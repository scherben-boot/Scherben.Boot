import 'package:scherben_boot/models/boundary_report.dart';
import 'package:scherben_boot/models/point.dart';

typedef LocationObserver = void Function(BoundaryReport);

abstract class GeolocationService {
  Future<Point> getCurrentUserLocation();
  Future<String?> describePoint(Point point);
  void subscribeToBoundaryChanges(LocationObserver observer);
  Future<void> initialize();
}
