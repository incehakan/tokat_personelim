import 'package:flutter/material.dart';

import '../enums/subordinate_type.dart';

extension SubordinateTypeColorExtension on SubordinateType {
  Color get color {
    switch (this) {
      case SubordinateType.normal:
        return Colors.green;
      case SubordinateType.lateEntry:
        return Colors.amber;
      case SubordinateType.earlyExit:
        return Colors.red;
      case SubordinateType.pdksLeave:
        return Colors.deepOrangeAccent;
      case SubordinateType.bbysLeave:
        return Colors.blue;
    }
  }
}

extension SubordinateTypeTitleExtension on SubordinateType {
  String get title {
    switch (this) {
      case SubordinateType.normal:
        return 'Normal';
      case SubordinateType.lateEntry:
        return 'Geç Giriş';
      case SubordinateType.earlyExit:
        return 'Erken Çkış';
      case SubordinateType.pdksLeave:
        return 'PDKS İzin';
      case SubordinateType.bbysLeave:
        return 'BBYS İzin';
    }
  }
}
