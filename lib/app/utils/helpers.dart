import 'package:flutter/material.dart';

bool isValidEmail(String email) {
  final RegExp emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    caseSensitive: false,
    multiLine: false,
  );

  return emailRegex.hasMatch(email);
}

Future<void> preloadImage(BuildContext context, AssetImage img) async {
  img.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener(
          (info, _) {},
        ),
      );
}
