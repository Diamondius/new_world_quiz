import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helpers/screen_size_helper.dart';
import '../locale/app_localization.dart';
import '../providers/games.dart';
import '../widgets/feedback_input_form.dart';
import '../widgets/new_question_input_form.dart';
import '../widgets/page_background.dart';

enum userForms {
  feedback,
  newQuestion,
  errorQuestion,
}

//Screen that manages every type of feedback
class SubmitFeedbackScreen extends StatefulWidget {
  SubmitFeedbackScreen({Key key}) : super(key: key);
  static const String routeName = "/feedback"; //Name for the named route

  @override
  _SubmitFeedbackScreenState createState() => _SubmitFeedbackScreenState();
}

class _SubmitFeedbackScreenState extends State<SubmitFeedbackScreen> {
  int _index; //Index on what type of feedback to load
  String _submitText; //Text to be emailed
  userForms fb;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    //Swaps the feedback enum to an index for the swaps
    fb = ModalRoute.of(context).settings.arguments as userForms;
    switch (fb) {
      case userForms.feedback:
        _index = 0;
        break;
      case userForms.errorQuestion:
        _index = 1;
        break;
      case userForms.newQuestion:
        _index = 2;
        break;
    }
    super.didChangeDependencies();
  }

//Submitting the forms
  void submit() async {
    _form.currentState.save(); //Saving all fields
    if (_form.currentState.validate()) {
      //If all fields are validated the rest are sent
      String toMailId = "";
      String subject = "Feedback";
      String body = _submitText;
      if (fb == userForms.errorQuestion) {
        //If it is report question it draws the question id to share in the email
        String questionId = Provider.of<Games>(context, listen: false)
            .getGame
            .getCurrentQuestionId
            .toString();
        body = "Question Id: $questionId \n $_submitText";
      }
      var url = 'mailto:$toMailId?subject=$subject&body=$body';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
      Navigator.of(context).pop();
    }
  }

  void putText(String text) {
    _submitText = text;
  }

  @override
  Widget build(BuildContext context) {
    List<String> titleList = [
      AppLocalizations.of(context).feedback,
      AppLocalizations.of(context).reportQuestion,
      AppLocalizations.of(context).newQuestion,
    ];
    List<String> underlineList = [
      AppLocalizations.of(context).shareThoughts,
      AppLocalizations.of(context).reportQuestionUnderline,
      AppLocalizations.of(context).shareQuestionUnderline,
    ];
    List<Widget> formList = [
      FeedbackInputForm(submit, putText, _form),
      FeedbackInputForm(submit, putText, _form),
      NewQuestionInputForm(submit, putText, _form),
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight(context),
          child: PageBackground(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: screenHeight(context, dividedBy: 1.3),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        AutoSizeText(
                          titleList[_index],
                          style: Theme.of(context).textTheme.title,
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          height: screenHeight(context, dividedBy: 12),
                          child: AutoSizeText(
                            underlineList[_index],
                            style: Theme.of(context).textTheme.body1,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SingleChildScrollView(child: formList[_index]),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        thirdScreenButton(
                          AppLocalizations.of(context).cancel,
                          () {
                            Navigator.of(context).pop();
                          },
                          context,
                        ),
                        thirdScreenButton(
                          AppLocalizations.of(context).go,
                          () {
                            submit();
                          },
                          context,
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//Button that takes a third of the screen
  Container thirdScreenButton(
      String text, Function onPressed, BuildContext context) {
    return Container(
      width: screenWidth(context, dividedBy: 2.5),
      child: RaisedButton(
          color: Theme.of(context).primaryColor,
          elevation: 8,
          disabledColor: Colors.grey,
          child: AutoSizeText(
            text,
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: onPressed),
    );
  }
}
