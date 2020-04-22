import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../classes/custom_input_decoration.dart';
import '../locale/app_localization.dart';

class TextFormFieldEmail extends StatelessWidget {
  final Function onChanged;
  final FocusNode focusNode;
  final Function onFieldSubmitted;

  TextFormFieldEmail(
      {@required this.onChanged,
      this.focusNode,
      @required this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration:
          customInputDecoration(AppLocalizations.of(context).email, context),
      style: Theme.of(context).textTheme.body2,
      maxLines: 1,
      focusNode: focusNode,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      onChanged: onChanged,
      autocorrect: false,
      onFieldSubmitted: onFieldSubmitted,
      validator: (value) =>
          RegExp(r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                  .hasMatch(value)
              ? null
              : AppLocalizations.of(context).invalidEmail,
      inputFormatters: [
        new BlacklistingTextInputFormatter(new RegExp(" ")),
      ],
    );
  }
}
