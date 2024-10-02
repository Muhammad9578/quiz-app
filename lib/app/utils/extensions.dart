// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

extension CustomSpacing on num {
  SizedBox get SpaceX {
    return SizedBox(height: toDouble());
  }

  SizedBox get SpaceY {
    return SizedBox(width: toDouble());
  }

  SizedBox get squaresp {
    return SizedBox(width: toDouble(), height: toDouble());
  }
}
