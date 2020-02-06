import 'package:flutter/material.dart';
import 'package:new_world_quiz/helpers/screen_size_helper.dart';

class GameInfoButton extends StatelessWidget {
  final String uploader;

  GameInfoButton(this.uploader);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.info,
        color: Theme.of(context).primaryColorDark,
        size: screenHeight(context, dividedBy: 20),
      ),
      color: Theme.of(context).primaryColor,
      elevation: 8,
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 1,
          child: Text(
            "$uploader",
            style: Theme.of(context).textTheme.button,
          ),
        )
      ],
    );
  }
}
