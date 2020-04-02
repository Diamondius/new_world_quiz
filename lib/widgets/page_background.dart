import 'package:flutter/material.dart';

import '../classes/background_gradient.dart';
import '../helpers/screen_size_helper.dart';

class PageBackground extends StatelessWidget {
  final Widget child;

  PageBackground({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth(context, dividedBy: 18),
          vertical: screenHeight(context, dividedBy: 40),
        ),
        margin: EdgeInsets.only(top: statusBarHeight(context)),
        decoration: BackgroundGradient(),
        child: child);
  }
}
