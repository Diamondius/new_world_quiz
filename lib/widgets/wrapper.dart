import 'package:flutter/material.dart';
import 'package:new_world_quiz/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../screens/authenticate_screen.dart';

class Wrapper extends StatelessWidget {
  static const String routeName = "/wrapper";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    //Return either HomeScreen or Authenticate depending on user login
    if (user == null) {
      return AuthenticateScreen();
    } else {
      return HomeScreen();
    }
  }
}
