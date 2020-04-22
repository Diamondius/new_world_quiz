import 'package:flutter/material.dart';

import '../helpers/auth.dart';
import '../locale/app_localization.dart';
import '../widgets/menu_button_flat.dart';
import '../widgets/spinner.dart';
import '../widgets/title_autotext.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final AuthService _auth = AuthService();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Spinner()
        : SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TitleAutoText(AppLocalizations.of(context).user),
                MenuButtonFlat(
                  text: AppLocalizations.of(context).signOut,
                  isDark: true,
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await _auth.signOut();
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
              ],
            ),
          );
  }
}
