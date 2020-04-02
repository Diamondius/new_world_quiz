import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:new_world_quiz/helpers/screen_size_helper.dart';
import 'package:provider/provider.dart';

import '../locale/app_localization.dart';
import '../providers/language.dart';
import '../providers/questions.dart';

//List Tile with a drop button for choosing a language
class LanguagePicker extends StatefulWidget {
  @override
  _LanguagePickerState createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {
  String _selectedLanguage; //Currently picked language
  Language language; //Language provider
  Questions questions; //Questions provider

  @override
  Widget build(BuildContext context) {
    language = Provider.of<Language>(context);
    questions = Provider.of<Questions>(context);
    _selectedLanguage = language.code; //Load the language from the provider
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(Icons.language),
        title: AutoSizeText(
          AppLocalizations.of(context).language,
          style: Theme.of(context).textTheme.overline,
          maxLines: 1,
          overflow: TextOverflow.clip,
        ),
        trailing: Container(
          width: screenWidth(context, dividedBy: 3.5),
          child: DropdownButton(
              isExpanded: true,
              style: TextStyle(
                  color: Theme
                      .of(context)
                      .primaryColorDark, fontSize: 30),
              elevation: 8,
              underline: Container(
                height: 2,
                color: Theme
                    .of(context)
                    .primaryColorDark,
              ),
              items: Language.getLanguages.map((Language language) {
                return DropdownMenuItem(
                  value: language.code,
                  child: Center(
                    child: AutoSizeText(
                      "${Language.languageName(language, _selectedLanguage)}",
                      textAlign: TextAlign.center,
                      style: Theme
                          .of(context)
                          .textTheme
                          .body2,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String value) {
                setState(() {
                  _selectedLanguage = value;
                });
                language.setLanguageCode(_selectedLanguage);
                questions.fetchAndSetQuestions(_selectedLanguage);
              },
              value: _selectedLanguage),
        ),
      ),
    );
  }
}
