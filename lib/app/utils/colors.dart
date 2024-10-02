import 'package:flutter/material.dart';

class ColorHelper {
  static const Color whitecolor = Colors.white;
  static const Color blackcolor = Colors.black;
  static const Color primarycolor = Color(0xff1C70B9);

 static MaterialColor createPrimarySwatch(Color color) {
    Map<int, Color> swatchColors = {
      50: color.withOpacity(0.1),
      100: color.withOpacity(0.2),
      200: color.withOpacity(0.3),
      300: color.withOpacity(0.4),
      400: color.withOpacity(0.5),
      500: color.withOpacity(0.6),
      600: color.withOpacity(0.7),
      700: color.withOpacity(0.8),
      800: color.withOpacity(0.9),
      900: color.withOpacity(1),
    };

    return MaterialColor(color.value, swatchColors);
  }
}
