import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../helpers/screen_size_helper.dart';

//Raised button with full width styling for use on app menus
class MenuButton extends StatelessWidget {
  final Function buttonPressed;
  final String buttonText;
  final bool enabled;
  final IconData icon;

  MenuButton(this.buttonText, this.buttonPressed,
      {this.enabled = true, this.icon});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: double.infinity,
      height: screenHeight(context, dividedBy: 15),
      disabledColor: Colors.grey,
      child: RaisedButton(
        elevation: 8,
        color: Theme.of(context).primaryColor,
        onPressed: enabled ? buttonPressed : null,
        child: icon == null
            ? autoSizeTextStandard(context)
            : Row(
          children: <Widget>[
            SizedBox(
              width: screenWidth(context, dividedBy: 20),
            ),
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(
              width: screenWidth(context, dividedBy: 10),
            ),
            autoSizeTextStandard(context),
          ],
        ),
      ),
    );
  }

  AutoSizeText autoSizeTextStandard(BuildContext context) {
    return AutoSizeText(
      buttonText,
      textAlign: TextAlign.center,
      style: Theme
          .of(context)
          .textTheme
          .button,
    );
  }
}
