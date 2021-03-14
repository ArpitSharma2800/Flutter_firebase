// import 'package:days_100_code/model/user.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';

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

  void eligible(String emailU, DateTime loggedInU, String uidU) {
    _authenticated = true;
    email = emailU;
    loggedIn = loggedInU;
    uid = uidU;
    notifyListeners();
  }

  void notEligible() {
    _authenticated = false;

    //Call this whenever there is some change in any field of change notifier.
    notifyListeners();
  }
}
