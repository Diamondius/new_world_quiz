import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../helpers/screen_size_helper.dart';
import '../locale/app_localization.dart';

//Enum to help choosing which mode of this widget will be loaded
enum dropDownButtonType {
  difficulty,
  numberOfQuestions,
}

//Swaps between a drop down button for questions and one for difficulty. Done to avoid code duplications but not really worth it.
class CustomGameDropDownButton extends StatefulWidget {
  CustomGameDropDownButton(this._type, this._change, this._defaultValue);

  final dropDownButtonType _type;
  final Function
  _change; //Loads the reference to the function that changes the value on the custom game screen when the dropdown value is changed
  final _defaultValue; //Default value is the starting value of the dropdown, since it changes according to type
  static const List<int> _numberOfQuestionsValueList = [
    10,
    20,
    30,
    40,
    50
  ]; //List of available number of questions options.

  @override
  _CustomGameDropDownButtonState createState() =>
      _CustomGameDropDownButtonState();
}

class _CustomGameDropDownButtonState extends State<CustomGameDropDownButton> {
  @override
  Widget build(BuildContext context) {
    List<String> _difficultyLabels = [
      //List of the difficulties in every language. Actual language loading used the index of that
      AppLocalizations.of(context).random,
      AppLocalizations.of(context).easy,
      AppLocalizations.of(context).normal,
      AppLocalizations.of(context).hard,
    ];

    return Container(
      width: screenWidth(context, dividedBy: 4, reducedBy: -50),
      alignment: Alignment.centerRight,
      child: DropdownButton(
        isExpanded: true,
        style:
        TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 30),
        elevation: 8,
        underline: Container(
          height: 2,
          color: Theme
              .of(context)
              .primaryColorDark,
        ),
        value: widget._defaultValue,
        items: widget._type == dropDownButtonType.difficulty
            ? _difficultyLabels
            .map(
              (String diff) => DropdownMenuItem(
            value: diff,
            child: FittedBox(
              fit: BoxFit.contain,
              child: AutoSizeText(
                diff,
                style: Theme.of(context).textTheme.body2,
              ),
            ),
          ),
        )
            .toList()
            : CustomGameDropDownButton._numberOfQuestionsValueList
            .map(
              (int number) => DropdownMenuItem(
            value: number,
            child: FittedBox(
              fit: BoxFit.contain,
              child: AutoSizeText(number.toString(),
                  style: Theme.of(context).textTheme.body2),
            ),
          ),
        )
            .toList(),
        onChanged: (value) {
          if (widget._type == dropDownButtonType.difficulty) {
            int difficultyPosition = _difficultyLabels.indexOf(value);
            widget._change(difficultyPosition, value);
          } else {
            widget._change(value, value);
          }
        },
      ),
    );
  }
}
