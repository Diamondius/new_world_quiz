import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../locale/app_localization.dart';
import '../models/user.dart';

//Service that allows to authenticate in various ways and returns a custom user
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  //Create user object based on FirebaseUser
  User _userFromFireBaseUser(FirebaseUser user) {
    return user != null
        ? User(
            userName: user.displayName,
            uid: user.uid,
            email: user.email,
            isVerified: user.isEmailVerified,
            photoUrl: user.photoUrl,
          )
        : null;
  }

  //Auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFireBaseUser);
  }

  //Sign in with Google
  Future logInWithGoogle() async {
    String errorMessage;
    FirebaseUser currentUser;
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final AuthResult authResult =
          await _auth.signInWithCredential(credential);
      final FirebaseUser firebaseUser = authResult.user;

      assert(!firebaseUser.isAnonymous);
      assert(await firebaseUser.getIdToken() != null);

      currentUser = await _auth.currentUser();
      assert(firebaseUser.uid == currentUser.uid);
    } catch (e) {
      errorMessage = e.code;
      print(e.toString());
    }
    if (errorMessage != null) {
      return errorMessage;
    }
    return _userFromFireBaseUser(currentUser);
  }

  //Sign in with Facebook
  Future logInWithFacebook() async {
    String errorMessage;
    FirebaseUser firebaseUser;

    ///This object comes from facebook_login_plugin package
    final facebookLogin = new FacebookLogin();

    final facebookLoginResult =
        await facebookLogin.logIn(['email', 'public_profile']);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        return "ERROR_FACEBOOK";
        break;

      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        return "ERROR_CANCELED_BY_USER";
        break;

      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");

        /// calling the auth method and getting the logged user
        try {
          AuthCredential credential = FacebookAuthProvider.getCredential(
              accessToken: facebookLoginResult.accessToken.token);
          AuthResult result = await _auth.signInWithCredential(credential);
          firebaseUser = result.user;
        } catch (e) {
          errorMessage = e.code;
          print("Error toString: ${e.toString()}");
        }
        if (errorMessage != null) {
          return errorMessage;
        }
        return _userFromFireBaseUser(firebaseUser);
    }
  }

  //Sign in Email/Password
  Future logInWithEmailAndPassword(String email, String password) async {
    String errorMessage;
    FirebaseUser firebaseUser;
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      firebaseUser = result.user;
    } catch (e) {
      errorMessage = e.code;
      print(e.toString());
    }
    if (errorMessage != null) {
      return errorMessage;
    }
    return _userFromFireBaseUser(firebaseUser);
  }

  //Register Email/Password
  Future registerWithEmailAndPassword(
    String email,
    String password,
    String displayName,
  ) async {
    FirebaseUser firebaseUser;
    String errorMessage;
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      firebaseUser = result.user;
      if (firebaseUser != null) {
        UserUpdateInfo updateInfo = UserUpdateInfo();
        updateInfo.displayName = displayName;
        firebaseUser.updateProfile(updateInfo);
      }
    } catch (e) {
      errorMessage = e.code;
      print(e.toString());
    }
    try {
      await firebaseUser.sendEmailVerification();
    } catch (e) {
      return "ERROR_NOT_ABLE_TO_SEND_VERIFICATION_EMAIL";
    }
    if (errorMessage != null) {
      return errorMessage;
    }
    return _userFromFireBaseUser(firebaseUser);
  }

  //Reset Email Password
  Future resetPassword(String email) async {
    String returnedText = "RESET_EMAIL_SENT";
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      returnedText = e.code;
      print(e.toString());
    }
    return returnedText;
  }

  //Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Changes error codes to user understandable text in different languages
  String errorCodeToText(String code, BuildContext context) {
    String errorResponse;
    switch (code) {
      case "ERROR_WEAK_PASSWORD":
        errorResponse = AppLocalizations.of(context).weakPassword;
        break;
      case "ERROR_INVALID_EMAIL":
        AppLocalizations.of(context).invalidEmail;
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        errorResponse = AppLocalizations.of(context).emailInUse;
        break;
      case "ERROR_INVALID_CREDENTIAL":
        errorResponse = AppLocalizations.of(context).invalidCredentials;
        break;
      case "ERROR_WRONG_PASSWORD":
        errorResponse = AppLocalizations.of(context).invalidPassword;
        break;
      case "ERROR_USER_NOT_FOUND":
        errorResponse = AppLocalizations.of(context).userNotFound;
        break;
      case "ERROR_USER_DISABLED":
        errorResponse = AppLocalizations.of(context).userDisabled;
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        errorResponse = AppLocalizations.of(context).tooManyAttemptsToSignIn;
        break;
      case "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL":
        errorResponse = AppLocalizations.of(context).emailInUse;
        break;
      case "ERROR_NOT_ABLE_TO_SEND_VERIFICATION_EMAIL":
        errorResponse = AppLocalizations.of(context).errorVerification;
        break;
        break;
      case "RESET_EMAIL_SENT":
        errorResponse = AppLocalizations.of(context).resetEmailSent;
        break;
      case "network_error":
        errorResponse = AppLocalizations.of(context).networkError;
        break;
      case "ERROR_FACEBOOK":
        errorResponse = AppLocalizations.of(context).facebookError;
        break;
      case "ERROR_CANCELED_BY_USER":
        errorResponse = AppLocalizations.of(context).canceledByUser;
        break;
      case "ERROR_NETWORK_REQUEST_FAILED":
        errorResponse = AppLocalizations.of(context).networkError;
        break;
      default:
        errorResponse = AppLocalizations.of(context).unidentifiedError;
    }
    return errorResponse;
  }
}
