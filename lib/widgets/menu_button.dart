import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../helpers/screen_size_helper.dart';

class MenuButton extends StatelessWidget {
  final Function buttonPressed;
  final String buttonText;
  final bool enabled;

  MenuButton(this.buttonText, this.buttonPressed, {this.enabled = true});

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
        child: AutoSizeText(
          buttonText,
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}
