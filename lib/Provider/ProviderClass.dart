// import 'package:days_100_code/model/user.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthenticated extends ChangeNotifier {
  bool _authenticated = false;
  String email;
  DateTime loggedIn;
  String uid;

  void authCall(String emailU, DateTime loggedInU, String uidU) {
    if (uidU != null)
      eligible(emailU, loggedInU, uidU);
    else
      notEligible();
  }

  void eligible(String emailU, DateTime loggedInU, String uidU) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', emailU);
    prefs.setString('loggedIn', loggedInU.toString());
    prefs.setString('uid', uidU);
    _authenticated = true;
    email = emailU;
    loggedIn = loggedInU;
    uid = uidU;
    notifyListeners();
  }

  void notEligible() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', null);
    prefs.setString('loggedIn', null);
    prefs.setString('uid', null);
    _authenticated = false;
    email = null;
    loggedIn = null;
    uid = null;

    //Call this whenever there is some change in any field of change notifier.
    notifyListeners();
  }
}
