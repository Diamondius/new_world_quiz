import 'package:flutter/foundation.dart';

//Class that describes the user object (Player)
class User {
  final String uid;
  final String userName;
  final String email;
  final String photoUrl;
  bool isVerified = true;

  User(
      {@required this.uid,
      @required this.userName,
      @required this.email,
      this.photoUrl,
      this.isVerified});

  @override
  String toString() {
    return "UID: $uid \n Username: $userName";
  }
}
