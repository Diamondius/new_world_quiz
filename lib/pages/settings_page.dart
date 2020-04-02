import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_world_quiz/providers/language.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helpers/screen_size_helper.dart';
import '../locale/app_localization.dart';
import '../screens/submit_feedback_screen.dart';
import '../widgets/language_picker.dart';
import '../widgets/settings_sounds_check_box.dart';
import '../widgets/settings_vibration_check_box.dart';

class SettingsPage extends StatelessWidget {
  //Launch browser for connecting to social media. Backup Url exists for when the phone does not have the primary app installed
  void launchUrl(String url, {String backupUrl}) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    } else if (await canLaunch(backupUrl)) {
      await launch(backupUrl);
    } else {
      throw 'Could not launch $url'; //Todo: When I connect analytics make a report for false urls.
    }
  }

  //Styling of the icon so code duplication is avoided
  IconButton contactIconButton(String url, FaIcon icon, BuildContext context,
      {String backupUrl}) {
    return IconButton(
      color: Theme.of(context).primaryColorDark,
      iconSize: screenHeight(context, dividedBy: 20),
      icon: icon,
      onPressed: () {
        launchUrl(url, backupUrl: backupUrl);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Language>(
        context); //This is so the settings page rebuilds every time the language is changed so the strings update according
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            AutoSizeText(
              AppLocalizations.of(context).settings,
              style: Theme.of(context).textTheme.title,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
            LanguagePicker(),
            SettingsSoundCheckBox(),
            SettingsVibrationCheckBox(),
            Padding(
              padding:
                  EdgeInsets.only(top: screenHeight(context, dividedBy: 40)),
              child: AutoSizeText(
                AppLocalizations.of(context).contact,
                style: Theme.of(context).textTheme.title,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              //Row with social media icons
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  contactIconButton(
                      "fb://page/1484321295211353",
                      FaIcon(
                        FontAwesomeIcons.facebookSquare,
                      ),
                      context,
                      backupUrl: "https://www.facebook.com/NWkouiz/"),
                  contactIconButton(
                    "https://discord.gg/cruwn8s",
                    FaIcon(FontAwesomeIcons.discord),
                    context,
                  ),
                  contactIconButton(
                    "https://invite.viber.com/?g2=AQBJJUJygn9raksxeoP%2FbS3AfPhb4n%2FpqWyAIF%2BDxe202BDyJXOBL7MxUUuoNm2C",
                    FaIcon(FontAwesomeIcons.viber),
                    context,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: screenHeight(context, dividedBy: 14),
              child: FlatButton(
                child: AutoSizeText(
                  AppLocalizations.of(context).shareQuestion,
                  style: Theme.of(context).textTheme.button,
                  textAlign: TextAlign.center,
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                      SubmitFeedbackScreen.routeName,
                      arguments: userForms.newQuestion);
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: screenHeight(context, dividedBy: 14),
              child: FlatButton(
                child: AutoSizeText(
                  AppLocalizations.of(context).feedback,
                  style: Theme.of(context).textTheme.button,
                  textAlign: TextAlign.center,
                ),
                color: Theme.of(context).primaryColorDark,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                      SubmitFeedbackScreen.routeName,
                      arguments: userForms.feedback);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
