import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:new_world_quiz/locale/app_localization.dart';

enum dropDownButtonType {
  difficulty,
  numberOfQuestions,
}

class CustomGameDropDownButton extends StatefulWidget {
  CustomGameDropDownButton(this.type, this.change, this.defaultValue);

  final dropDownButtonType type;
  final Function change;
  final defaultValue;
  static const _numberOfQuestionsValueList = [10, 20, 30, 40, 50];

  @override
  _CustomGameDropDownButtonState createState() =>
      _CustomGameDropDownButtonState();
}

class _CustomGameDropDownButtonState extends State<CustomGameDropDownButton> {
  @override
  Widget build(BuildContext context) {
    List<String> _difficultyLabels = [
      AppLocalizations.of(context).random,
      AppLocalizations.of(context).easy,
      AppLocalizations.of(context).normal,
      AppLocalizations.of(context).hard,
    ];

    return FittedBox(
      fit: BoxFit.contain,
      child: DropdownButton(
        style:
            TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 30),
        elevation: 8,
        underline: Container(
          height: 2,
          color: Theme.of(context).primaryColor,
        ),
        value: widget.defaultValue,
        items: widget.type == dropDownButtonType.difficulty
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
          int difficultyPosition = _difficultyLabels.indexOf(value);
          widget.change(difficultyPosition, value);
        },
      ),
    );
  }
}
