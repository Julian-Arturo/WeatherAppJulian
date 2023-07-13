import 'dart:math' as math;

import 'package:flutter/cupertino.dart';

class Responsive {
  late double _width, _height, _diagonal;
  late bool _smallPhone;

  double get width => _width;
  double get height => _height;
  double get diagonal => _diagonal;
  bool get isPhone => _smallPhone;

  static Responsive of(BuildContext context) => Responsive(context);

  Responsive(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _width = size.width;
    _height = size.height;
    _diagonal = math.sqrt(
      math.pow(_width, 2) + math.pow(_height, 2),
    );

    _smallPhone =
        _width < 600; // Modificación: Considerar ancho en lugar de shortestSide
  }

  double wp(double percent) => _width * percent / 100;
  double hp(double percent) => _height * percent / 100;
  double db(double percent) => _diagonal * percent / 100;
}
