import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../classes/custom_input_decoration.dart';
import '../locale/app_localization.dart';

class TextFormFieldPassword extends StatelessWidget {
  final Function onChanged;
  final Function onFieldSubmitted;
  final FocusNode focusNode;

  TextFormFieldPassword(
      {@required this.onChanged,
      @required this.onFieldSubmitted,
      @required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration:
          customInputDecoration(AppLocalizations.of(context).password, context),
      style: Theme.of(context).textTheme.body2,
      keyboardType: TextInputType.text,
      obscureText: true,
      focusNode: focusNode,
      textInputAction: TextInputAction.done,
      maxLines: 1,
      maxLength: 32,
      enableSuggestions: false,
      autocorrect: false,
      validator: (value) =>
          value.length < 6 ? AppLocalizations.of(context).weakPassword : null,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
