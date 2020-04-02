import 'package:flutter/material.dart';
import 'package:new_world_quiz/locale/app_localization.dart';

class NewQuestionInputForm extends StatefulWidget {
  final Function _submit;
  final GlobalKey<FormState> _form;
  final Function putText;

  NewQuestionInputForm(this._submit, this.putText, this._form, {Key key})
      : super(key: key);

  @override
  _NewQuestionInputFormState createState() => _NewQuestionInputFormState();
}

class _NewQuestionInputFormState extends State<NewQuestionInputForm> {
  String _question;
  String _correctAnswer;
  String _wrongAnswer1;
  String _wrongAnswer2;
  String _wrongAnswer3;
  String _merged;
  final FocusNode _correctAnswerNode = FocusNode();
  final FocusNode _wrongAnswer1Node = FocusNode();
  final FocusNode _wrongAnswer2Node = FocusNode();
  final FocusNode _wrongAnswer3Node = FocusNode();

  void saveForm() {
    if (_question.isNotEmpty &&
        _correctAnswer.isNotEmpty &&
        _wrongAnswer1.isNotEmpty &&
        _wrongAnswer2.isNotEmpty &&
        _wrongAnswer3.isNotEmpty) {
      if (widget._form.currentState.validate()) {
        _merged =
            "Question: $_question\nCorrect Answer: $_correctAnswer\nWrong answer 1: $_wrongAnswer1\nWrong answer 2: $_wrongAnswer2\nWrong answer 3: $_wrongAnswer3";
        widget.putText(_merged);
      }
    }
  }

  void _submit() {
    if (_merged.isNotEmpty) {
      widget._submit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Form(
        key: widget._form,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.body2,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  return questionValidator(value);
                },
                onFieldSubmitted: (_) {
                  return _correctAnswerNode.requestFocus();
                },
                onSaved: (value) {
                  _question = value;
                },
                keyboardType: TextInputType.text,
                minLines: 1,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).question,
                  labelStyle: Theme.of(context).textTheme.subtitle,
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.body2,
                textInputAction: TextInputAction.next,
                focusNode: _correctAnswerNode,
                validator: (value) {
                  return answerValidator(value);
                },
                onFieldSubmitted: (value) {
                  return _wrongAnswer1Node.requestFocus();
                },
                onSaved: (value) {
                  _correctAnswer = value;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).correctAnswer,
                  labelStyle: Theme.of(context).textTheme.subtitle,
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.body2,
                textInputAction: TextInputAction.next,
                focusNode: _wrongAnswer1Node,
                validator: (value) {
                  return answerValidator(value);
                },
                onFieldSubmitted: (value) {
                  return _wrongAnswer2Node.requestFocus();
                },
                onSaved: (value) {
                  _wrongAnswer1 = value;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "${AppLocalizations.of(context).wrongAnswer} 1",
                  labelStyle: Theme.of(context).textTheme.subtitle,
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.body2,
                textInputAction: TextInputAction.next,
                focusNode: _wrongAnswer2Node,
                validator: (value) {
                  return answerValidator(value);
                },
                onFieldSubmitted: (value) {
                  _wrongAnswer3Node.requestFocus();
                },
                onSaved: (value) {
                  _wrongAnswer2 = value;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "${AppLocalizations.of(context).wrongAnswer} 2",
                  labelStyle: Theme.of(context).textTheme.subtitle,
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              margin: const EdgeInsets.only(bottom: 12),
              child: TextFormField(
                style: Theme.of(context).textTheme.body2,
                textInputAction: TextInputAction.done,
                focusNode: _wrongAnswer3Node,
                validator: (value) {
                  return answerValidator(value);
                },
                onFieldSubmitted: (value) {
                  saveForm();
                  return _submit();
                },
                onSaved: (value) {
                  _wrongAnswer3 = value;
                  return saveForm();
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "${AppLocalizations.of(context).wrongAnswer} 3",
                  labelStyle: Theme.of(context).textTheme.subtitle,
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding answerForm(
      {@required String label,
      @required TextInputAction action,
      @required Function validator,
      @required Function onFieldSubmitted,
      @required Function onSaved,
      @required FocusNode focusNode}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        style: Theme.of(context).textTheme.body2,
        textInputAction: action,
        focusNode: focusNode,
        validator: (value) {
          return validator(value);
        },
        onFieldSubmitted: (value) {
          return onFieldSubmitted(value);
        },
        onSaved: (value) {
          return onSaved(value);
        },
        keyboardType: TextInputType.text,
        minLines: 1,
        maxLines: 2,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: Theme.of(context).textTheme.overline,
          alignLabelWithHint: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColorDark,
            ),
          ),
        ),
      ),
    );
  }

  String questionValidator(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(context).emptyQuestionError;
    } else if (value.length < 10) {
      return AppLocalizations.of(context).shortQuestionError;
    }
    return null;
  }

  String answerValidator(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(context).emptyAnswerError;
    } else if (value.length > 100) {
      return AppLocalizations.of(context).longAnswerError;
    }
    return null;
  }
}
