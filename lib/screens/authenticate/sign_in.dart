import 'package:days_100_code/Provider/ProviderClass.dart';
import 'package:days_100_code/screens/appScreens/homeApp.dart';
import 'package:days_100_code/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
      ),
      body:
          Consumer<FirebaseAuthenticated>(builder: (context, provider, child) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: TextButton(
            child: Text('sign in anon'),
            onPressed: () async {
              dynamic result = await _auth.signInAnon();
              if (result == null) {
                print('error signing in');
              } else {
                provider.authCall(
                    result.email, result.metadata.lastSignInTime, result.uid);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeApp()),
                );
                print('signed in');
                print(result.metadata.lastSignInTime);
              }
            },
          ),
        );
      }),
    );
  }
}
