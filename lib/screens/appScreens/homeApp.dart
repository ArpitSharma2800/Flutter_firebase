import 'package:days_100_code/Provider/ProviderClass.dart';
import 'package:days_100_code/screens/homeScreen.dart';
import 'package:days_100_code/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeApp extends StatefulWidget {
  HomeApp({Key key}) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  final AuthService _auth = AuthService();
  String email = "";
  void getEmailInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userEmail = prefs.getString('email');
    setState(() {
      email = userEmail;
    });
  }

  @override
  void initState() {
    super.initState();
    getEmailInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body:
          Consumer<FirebaseAuthenticated>(builder: (context, provider, child) {
        return (Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: TextButton(
            child: Text(email),
            onPressed: () async {
              dynamic result = await _auth.SignOut();
              if (result == null) {
                provider.notEligible();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              } else {
                print('signed in');
              }
            },
          ),
        ));
      }),
    ));
  }
}
