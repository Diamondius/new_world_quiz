import 'package:flutter/material.dart';

class BackgroundGradient extends BoxDecoration {
  @override
  Gradient get gradient => LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.green.shade50, Colors.green]);
}
