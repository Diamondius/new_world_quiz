import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_world_quiz/widgets/overline_autotext.dart';

import '../classes/custom_input_decoration.dart';
import '../helpers/auth.dart';
import '../locale/app_localization.dart';
import '../widgets/menu_button.dart';
import '../widgets/spinner.dart';
import '../widgets/text_form_field_email.dart';
import '../widgets/text_form_field_password.dart';
import '../widgets/title_autotext.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _recoveryFormKey = GlobalKey<FormState>();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  //Text Field State
  String _email = "";
  String _password = "";
  String _displayName = "";
  String _recoveryEmail = "";

  bool isLoading = false;

  void register() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      dynamic result = await _auth.registerWithEmailAndPassword(
        _email,
        _password,
        _displayName,
      );
      setState(() {
        isLoading = false;
      });
      if (result is String) {
        FocusScope.of(context).requestFocus(new FocusNode());
        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).errorColor,
            content: AutoSizeText(
              _auth.errorCodeToText(result, context),
              maxLines: 1,
              style: Theme.of(context).textTheme.button,
            ),
          ),
        );
      }
      _formKey.currentState.reset();
    }
  }

  void recoverEmail() async {
    if (_recoveryFormKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      String result = await _auth.resetPassword(_recoveryEmail);
      setState(() {
        isLoading = false;
      });
      if (result != null) {
        FocusScope.of(context).requestFocus(new FocusNode());
        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).primaryColor,
            content: AutoSizeText(
              _auth.errorCodeToText(result, context),
              maxLines: 1,
              style: Theme.of(context).textTheme.button,
            ),
          ),
        );
      }
      _recoveryFormKey.currentState.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Spinner()
        : SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TitleAutoText(AppLocalizations.of(context).signUp),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 15),
                      TextFormField(
                        decoration: customInputDecoration(
                            AppLocalizations.of(context).userName, context),
                        style: Theme.of(context).textTheme.body2,
                        textInputAction: TextInputAction.next,
                        maxLines: 1,
                        maxLength: 32,
                        enableSuggestions: false,
                        keyboardType: TextInputType.text,
                        validator: (value) => value.length < 6
                            ? AppLocalizations.of(context).userNameFewChars
                            : null,
                        inputFormatters: [
                          new BlacklistingTextInputFormatter(
                              new RegExp(r"[!@#\$%^&*():[]{}?~]")),
                        ],
                        autocorrect: false,
                        onFieldSubmitted: (value) {
                          return _emailNode.requestFocus();
                        },
                        onChanged: (value) {
                          setState(() {
                            _displayName = value;
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormFieldEmail(
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                        focusNode: _emailNode,
                        onFieldSubmitted: (value) {
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
                          register();
                        },
                        focusNode: _passwordNode,
                      ),
                      SizedBox(height: 15),
                      MenuButton(
                          "${AppLocalizations.of(context).signUp} ${AppLocalizations.of(context).withEmail}",
                          register),
                      SizedBox(height: 15),
                      OverLineAutoText(
                          AppLocalizations.of(context).forgotPassword),
                      SizedBox(height: 15),
                      Form(
                        key: _recoveryFormKey,
                        child: TextFormFieldEmail(
                          onChanged: (value) {
                            setState(() {
                              _recoveryEmail = value;
                            });
                          },
                          onFieldSubmitted: (value) {
                            recoverEmail();
                          },
                        ),
                      ),
                      SizedBox(height: 15),
                      MenuButton(
                          "${AppLocalizations.of(context).resetPassword}",
                          recoverEmail),
                      SizedBox(height: 15),
                      MenuButton(
                          "${AppLocalizations.of(context).resetPassword}",
                          recoverEmail),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
