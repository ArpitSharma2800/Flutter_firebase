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
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final myControllerPassword = TextEditingController();
  final myControllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.black,
        // appBar: AppBar(
        //   // backgroundColor: Colors.brown[400],
        //   elevation: 0.0,
        //   title: Text('Login to 100DaysOfCode'),
        // ),
        body: Consumer<FirebaseAuthenticated>(
            builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height,
                    maxWidth: MediaQuery.of(context).size.width),
                decoration: BoxDecoration(color: Colors.black),
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello\nWelcome Back!!',
                        style: TextStyle(
                            color: Colors.white54,
                            fontSize: 26.0,
                            fontWeight: FontWeight.w700)),
                    SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      color: Colors.white54,
                      height: 5,
                      thickness: 2,
                      indent: 0,
                      endIndent: 0,
                    ),
                  ],
                )),
          );
        }),
      ),
    );
  }
}

// onPressed: () async {
//                   dynamic result = await _auth.signInAnon();
//                   if (result == null) {
//                     print('error signing in');
//                   } else {
//                     provider.authCall(result.email,
//                         result.metadata.lastSignInTime, result.uid);
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => HomeApp()),
//                     );
//                     print('signed in');
//                     print(result.metadata.lastSignInTime);
//                   }
//                 },
