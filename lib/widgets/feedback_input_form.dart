import 'package:flutter/material.dart';
import 'package:new_world_quiz/classes/custom_input_decoration.dart';
import 'package:new_world_quiz/locale/app_localization.dart';

class FeedbackInputForm extends StatefulWidget {
  final Function _submit;
  final GlobalKey<FormState> _form;
  final Function putText;

  FeedbackInputForm(this._submit, this.putText, this._form, {Key key})
      : super(key: key);

  @override
  _FeedbackInputFormState createState() => _FeedbackInputFormState();
}

class _FeedbackInputFormState extends State<FeedbackInputForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Form(
        key: widget._form,
        child: TextFormField(
          style: Theme.of(context).textTheme.body2,
          decoration: customInputDecoration(
              AppLocalizations
                  .of(context)
                  .feedback, context),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.multiline,
          maxLines: 6,
          validator: (value) {
            if (value.isEmpty) {
              return AppLocalizations.of(context).feedbackEmpty;
            } else if (value.length < 10) {
              return AppLocalizations.of(context).feedbackFewChars;
            }
            return null;
          },
          onFieldSubmitted: (value) {
            widget._submit();
          },
          onSaved: (value) {
            widget.putText(value);
          },
        ),
      ),
    );
  }
}
