import 'package:days_100_code/screens/appScreens/homeApp.dart';
import 'package:days_100_code/screens/authenticate/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future token() async {
    print(FirebaseAuth.instance.currentUser
        .getIdTokenResult()
        .then((value) => print(value.token)));
  }

  @override
  Widget build(BuildContext context) {
    User currentFirebaseUser = FirebaseAuth.instance.currentUser;
    print(currentFirebaseUser);
    if (currentFirebaseUser != null) {
      return HomeApp();
    } else {
      return Authenticate();
    }
  }
}
