import 'package:scherben_boot/models/point.dart';

class Polygon {
  late List<Point> _points;

  Polygon(List<Point> pointList) {
    _points = [pointList.last, ...pointList];
  }

  bool isWithinBoundaries(Point pointInQuestion) {
    var temp = -1;
    for (var i = 0; i < _points.length - 1; i++) {
      temp *= _crossProductTest(pointInQuestion, _points[i], _points[i + 1]);
      if (temp == 0) return true;
    }

    return temp == 1;
  }

  int _crossProductTest(
    Point pointInQuestion,
    Point polygonPointA,
    Point polygonPaintB,
  ) {
    if (pointInQuestion.latitude == polygonPointA.latitude &&
        polygonPointA.latitude == polygonPaintB.latitude) {
      if ((polygonPointA.longitude <= pointInQuestion.longitude &&
              pointInQuestion.longitude <= polygonPaintB.longitude) ||
          (polygonPaintB.longitude <= pointInQuestion.longitude &&
              pointInQuestion.longitude <= polygonPointA.longitude)) {
        return 0;
      }
      return 1;
    }
    if (pointInQuestion.latitude == polygonPointA.latitude &&
        pointInQuestion.longitude == pointInQuestion.longitude) {
      return 0;
    }
    if (polygonPointA.latitude > polygonPaintB.latitude) {
      final temp = polygonPointA;
      polygonPointA = polygonPaintB;
      polygonPaintB = temp;
    }
    if (pointInQuestion.latitude <= polygonPointA.latitude ||
        pointInQuestion.latitude > polygonPaintB.latitude) {
      return 1;
    }

    final delta = (polygonPointA.longitude - pointInQuestion.longitude) *
            (polygonPaintB.latitude - pointInQuestion.latitude) -
        (polygonPointA.latitude - pointInQuestion.latitude) *
            (polygonPaintB.longitude - pointInQuestion.longitude);
    if (delta > 0) {
      return -1;
    } else if (delta < 0) {
      return 1;
    }
    return 0;
  }
}
