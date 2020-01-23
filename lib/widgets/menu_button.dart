import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../helpers/screen_size_helper.dart';

class MenuButton extends StatelessWidget {
  final Function buttonPressed;
  final String buttonText;

  MenuButton(this.buttonText, this.buttonPressed);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: double.infinity,
      height: screenHeight(context, dividedBy: 15),
      child: RaisedButton(
        /* shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),*/
        elevation: 8,
        color: Theme.of(context).primaryColor,
        onPressed: buttonPressed,
        child: AutoSizeText(
          buttonText,
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}
