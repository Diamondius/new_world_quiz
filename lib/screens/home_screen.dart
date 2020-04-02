//Page that holds the bottom navigation bar and switches bodies according to the selected button
import 'package:flutter/material.dart';
import 'package:new_world_quiz/locale/app_localization.dart';

import '../helpers/screen_size_helper.dart';
import '../pages/custom_game_page.dart';
import '../pages/settings_page.dart';
import '../pages/welcome_page.dart';
import '../widgets/navigation_bar_icon_text.dart';
import '../widgets/page_background.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home"; //Name for the named route

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPageIndex = 0; //Page selected index
  List<Widget> _pages = [
    WelcomePage(),
    CustomGamePage(),
    SettingsPage(),
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
      resizeToAvoidBottomPadding: false,
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
        backgroundColor: Theme
            .of(context)
            .primaryColorDark,
        unselectedIconTheme: Theme.of(context).iconTheme,
        selectedIconTheme: Theme.of(context).accentIconTheme,
        currentIndex: _selectedPageIndex,
        iconSize: screenHeight(context, dividedBy: 20),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: NavigationBarIconText(
              AppLocalizations.of(context).home,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            activeIcon: Icon(Icons.play_circle_filled),
            title: NavigationBarIconText(
              AppLocalizations
                  .of(context)
                  .play,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: NavigationBarIconText(AppLocalizations.of(context).settings),
          ),
        ],
        onTap: _selectScreen,
      ),
    );
  }
}
