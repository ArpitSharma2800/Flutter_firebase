import 'package:days_100_code/Provider/ProviderClass.dart';
import 'package:days_100_code/screens/appScreens/homeApp.dart';
import 'package:days_100_code/services/auth.dart';
import 'package:email_validator/email_validator.dart';
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Hello,\nWelcome Back!!',
                        style: TextStyle(
                            color: Colors.white54,
                            fontSize: 26.0,
                            fontWeight: FontWeight.w700)),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // const Divider(
                    //   color: Colors.white54,
                    //   height: 5,
                    //   thickness: 2,
                    //   indent: 0,
                    //   endIndent: 0,
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    controller: myControllerEmail,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: Colors.greenAccent[400],
                                        ),
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                            color: Colors.blueGrey[50],
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                            color: Colors.greenAccent[400],
                                            width: 2.0,
                                          ),
                                        ),
                                        border: OutlineInputBorder(),
                                        labelText: 'Email',
                                        labelStyle:
                                            TextStyle(color: Colors.white)),
                                    validator: (value) =>
                                        EmailValidator.validate(value)
                                            ? null
                                            : "Please enter a valid email",
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    controller: myControllerPassword,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: Colors.greenAccent[400],
                                        ),
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                            color: Colors.blueGrey[50],
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                            color: Colors.greenAccent[400],
                                            width: 2.0,
                                          ),
                                        ),
                                        border: OutlineInputBorder(),
                                        labelText: 'Password',
                                        labelStyle:
                                            TextStyle(color: Colors.white)),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 55,
                      child: GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            _displaySnackBar(context);
                            dynamic result = await _auth.signInAnon(
                                myControllerEmail.text,
                                myControllerPassword.text);
                            if (result == null) {
                              print('error signing in');
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              __displaySnackBarError(context);
                            } else {
                              provider.authCall(result.email,
                                  result.metadata.lastSignInTime, result.uid);
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeApp()),
                              );
                              print('signed in');
                              print(result.metadata.lastSignInTime);
                            }
                          }
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "LOGIN",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.1),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(width: 30.0),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.white,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.green[400],
                          borderRadius: BorderRadius.circular(50.0)),
                    )
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
_displaySnackBar(BuildContext context) {
  final snackBar = SnackBar(
    elevation: 6.0,
    behavior: SnackBarBehavior.floating,
    duration: Duration(days: 1),
    content: new Row(
      children: <Widget>[
        // SpinKitCubeGrid(
        //   color: Colors.white,
        //   size: 20.0,
        // ),
        new Text("  Registering...")
      ],
    ),
  );
  // _scaffoldKey.currentState.showSnackBar(snackBar);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

__displaySnackBarError(BuildContext context) {
  final snackBar = SnackBar(
    backgroundColor: Colors.red[400],
    content: new Row(
      children: <Widget>[new Text("  Invalid Credentials...")],
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
