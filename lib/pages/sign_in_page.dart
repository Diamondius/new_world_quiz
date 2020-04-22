import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_world_quiz/widgets/spinner.dart';

import '../helpers/auth.dart';
import '../locale/app_localization.dart';
import '../screens/offline_game_screen.dart';
import '../widgets/menu_button.dart';
import '../widgets/menu_button_flat.dart';
import '../widgets/overline_autotext.dart';
import '../widgets/text_form_field_email.dart';
import '../widgets/text_form_field_password.dart';
import '../widgets/title_autotext.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _passwordNode = FocusNode();

  //Text Field State
  String _email = "";
  String _password = "";

  bool isLoading = false;

  void login(Future login) async {
    setState(() {
      isLoading = true;
    });
    dynamic result = await login;
    if (result is String) {
      setState(() {
        isLoading = false;
      });
      FocusScope.of(context).requestFocus(new FocusNode());
      Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).errorColor,
        content: AutoSizeText(
          _auth.errorCodeToText(result, context),
          maxLines: 1,
          style: Theme.of(context).textTheme.button,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Spinner()
        : SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TitleAutoText(AppLocalizations.of(context).signIn),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 15),
                      TextFormFieldEmail(
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                        onFieldSubmitted: (_) {
                          _passwordNode.requestFocus();
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormFieldPassword(
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                        onFieldSubmitted: (value) {
                          login(_auth.logInWithEmailAndPassword(
                              _email, _password));
                        },
                        focusNode: _passwordNode,
                      ),
                      SizedBox(height: 15),
                      MenuButton(
                        "${AppLocalizations.of(context).signIn} ${AppLocalizations.of(context).withEmail}",
                        () async {
                          if (_formKey.currentState.validate()) {
                            login(_auth.logInWithEmailAndPassword(
                                _email, _password));
                            _formKey.currentState.reset();
                          }
                        },
                        icon: Icons.email,
                      ),
                      SizedBox(height: 15),
                      MenuButton(
                        "${AppLocalizations.of(context).signIn} ${AppLocalizations.of(context).withGoogle}",
                        () async {
                          login(_auth.logInWithGoogle());
                        },
                        icon: FontAwesomeIcons.google,
                      ),
                      SizedBox(height: 15),
                      MenuButton(
                          "${AppLocalizations.of(context).signIn} ${AppLocalizations.of(context).onFacebook}",
                          () async {
                        login(_auth.logInWithFacebook());
                      }, icon: FontAwesomeIcons.facebookF),
                      SizedBox(height: 15),
                      OverLineAutoText(AppLocalizations.of(context).or),
                      SizedBox(height: 15),
                      MenuButtonFlat(
                        text:
                            "${AppLocalizations.of(context).play} ${AppLocalizations.of(context).offline}",
                        isDark: false,
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(OfflineGameScreen.routeName);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
