import 'package:flutter/material.dart';

import '../classes/background_gradient.dart';
import '../helpers/screen_size_helper.dart';

class PageBackground extends StatelessWidget {
  final Widget child;

  PageBackground({@required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth(context, dividedBy: 18),
            vertical: screenHeight(context, dividedBy: 40),
          ),
          decoration: BackgroundGradient(),
          child: child),
    );
  }
}
