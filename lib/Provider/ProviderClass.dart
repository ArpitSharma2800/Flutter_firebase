import 'package:days_100_code/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FirebaseAuthenticated extends ChangeNotifier {
  bool _authenticated = false;
  String email;
  String loggedIn;
  String uid;

  // void authCall(String emailU, String loggedInU, String uidU ){
  //   uid != null ? {
  //     _authenticated =
  //   }
  // }

}
