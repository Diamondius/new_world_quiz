import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class NavigationBarIconText extends StatelessWidget {
  final String text;

  NavigationBarIconText(this.text);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white),
    );
  }
}
