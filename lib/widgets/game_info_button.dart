import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helpers/screen_size_helper.dart';
import '../locale/app_localization.dart';
import '../providers/games.dart';

class GameInfoButton extends StatefulWidget {
  final String uploader;
  final String source;

  GameInfoButton(this.uploader, this.source);

  @override
  _GameInfoButtonState createState() => _GameInfoButtonState();
}

// Button that shows an in game menu that allows for some actions
class _GameInfoButtonState extends State<GameInfoButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) {
        if (value == 1) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  AppLocalizations
                      .of(context)
                      .source,
                  textAlign: TextAlign.center,
                ),
                content: Text(
                  AppLocalizations
                      .of(context)
                      .sourceAlertWindowDescription,
                  style: Theme
                      .of(context)
                      .textTheme
                      .body2,
                  textAlign: TextAlign.justify,
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(AppLocalizations
                        .of(context)
                        .cancel),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text(AppLocalizations
                        .of(context)
                        .go),
                    onPressed: () async {
                      if (await canLaunch(widget.source)) {
                        await launch(widget.source);
                        Navigator.of(context).pop();
                        Provider.of<Games>(context, listen: false)
                            .increaseRound();
                      } else {
                        throw 'Could not launch ${widget
                            .source}'; //Todo: When I connect analytics make a report for false urls.
                      }
                    },
                  ),
                ],
              );
            },
          );
        }
      },
      icon: Icon(
        Icons.info,
        color: Theme
            .of(context)
            .primaryColorLight,
        size: screenHeight(context, dividedBy: 20),
      ),
      color: Theme.of(context).primaryColor,
      elevation: 8,
      itemBuilder: (BuildContext context) {
        var list = List<PopupMenuEntry<Object>>();
        list.add(
          PopupMenuItem(
            value: 1,
            child: Text(
              widget.source == null
                  ? AppLocalizations
                  .of(context)
                  .noSource
                  : AppLocalizations
                  .of(context)
                  .source,
              style: Theme
                  .of(context)
                  .textTheme
                  .button,
            ),
            enabled: widget.source == null ? false : true,
          ),
        );
        list.add(PopupMenuDivider(
          height: 10,
        ));
        list.add(
          PopupMenuItem(
            enabled: false,
            child: Text(
              "${AppLocalizations
                  .of(context)
                  .by}: ${widget.uploader}",
              style: Theme
                  .of(context)
                  .textTheme
                  .button,
            ),
          ),
        );
        return list;
      },
    );
  }
}
