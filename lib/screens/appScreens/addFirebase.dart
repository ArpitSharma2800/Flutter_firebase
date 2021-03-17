import 'package:days_100_code/Provider/ProviderClass.dart';
import 'package:days_100_code/screens/appScreens/homeApp.dart';
import 'package:days_100_code/services/auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../homeScreen.dart';

class AddFire2 extends StatefulWidget {
  AddFire2({Key key}) : super(key: key);

  @override
  _AddFire2State createState() => _AddFire2State();
}

class _AddFire2State extends State<AddFire2> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final myControllerPassword = TextEditingController();
  final myControllerEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.greenAccent[400],
            title: const Text('100DaysOfCode',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                )),
            elevation: 0,
          ),
          drawer: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.black, //desired color
            ),
            child: Drawer(
              // Add a ListView to the drawer. This ensures the user can scroll
              // through the options in the drawer if there isn't enough vertical
              // space to fit everything.
              child: Consumer<FirebaseAuthenticated>(
                builder: (context, provider, child) {
                  return ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      DrawerHeader(
                        child: Text('100DaysOfCode',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                            )),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent[400],
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.greenAccent[400],
                          ),
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomeApp()),
                          );
                        },
                      ),
                      ListTile(
                          title: Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.greenAccent[400],
                            ),
                          ),
                          onTap: () async {
                            print('logout');
                            dynamic result = await _auth.SignOut();
                            if (result == null) {
                              provider.notEligible();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                              );
                            } else {
                              print('signed in');
                            }
                          }),
                    ],
                  );
                },
              ),
            ),
          ),
          body: Consumer<FirebaseAuthenticated>(
              builder: (context, provider, child) {
            return SingleChildScrollView(
              child: Container(
                  // constraints: BoxConstraints(
                  //     maxHeight: MediaQuery.of(context).size.height,
                  //     maxWidth: MediaQuery.of(context).size.width),
                  decoration: BoxDecoration(color: Colors.black),
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('What you did today!!',
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
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(color: Colors.white),
                                      controller: myControllerEmail,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.date_range_sharp,
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
                                          labelText: 'Day',
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
          })),
    );
  }
}

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
