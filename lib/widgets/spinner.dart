import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_world_quiz/helpers/screen_size_helper.dart';

class Spinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCircle(
        color: Theme.of(context).primaryColorDark,
        size: screenHeight(context, dividedBy: 4),
      ),
    );
  }
}
