import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../helpers/screen_size_helper.dart';
import '../locale/app_localization.dart';
import '../pages/sign_in_page.dart';
import '../pages/sign_up_page.dart';
import '../widgets/navigation_bar_icon_text.dart';
import '../widgets/page_background.dart';

class AuthenticateScreen extends StatefulWidget {
  static const String routeName = "/authenticate";

  AuthenticateScreen({Key key}) : super(key: key);

  @override
  _AuthenticateScreenState createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  int _selectedPageIndex = 0; //Page selected index
  List<Widget> _pages = [
    SignInPage(),
    SignUpPage(),
  ]; //List of bodies to be loaded
  //Changes page index when bottom NavigationBar button is pressed
  void _selectScreen(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  //Changes the pages also with drag
  void _onHorizontalDrag(DragEndDetails details) {
    if (details.primaryVelocity == 0)
      return; // user have just tapped on screen (no dragging)
    if (details.primaryVelocity.compareTo(0) == -1) {
      if (_selectedPageIndex == _pages.length - 1)
        return;
      else {
        setState(() {
          _selectedPageIndex++;
        });
      }
    } else {
      if (_selectedPageIndex == 0)
        return;
      else {
        setState(() {
          _selectedPageIndex--;
        });
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      /*  appBar: _selectedPageIndex == 1 ? AppBar() : null,*/
      //Shared Background and measurements
      body: GestureDetector(
        //To change the pages with dragging
        onHorizontalDragEnd: (DragEndDetails details) =>
            _onHorizontalDrag(details),
        child: PageBackground(
          child: _pages[_selectedPageIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColorDark,
        unselectedIconTheme: Theme.of(context).iconTheme,
        selectedIconTheme: Theme.of(context).accentIconTheme,
        currentIndex: _selectedPageIndex,
        iconSize: screenHeight(context, dividedBy: 20),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.signInAlt),
            title: NavigationBarIconText(
              AppLocalizations.of(context).signIn,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.pen),
            title: NavigationBarIconText(
              AppLocalizations.of(context).signUp,
            ),
          ),
        ],
        onTap: _selectScreen,
      ),
    );
  }
}
