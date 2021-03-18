import 'package:days_100_code/Provider/ProviderClass.dart';
import 'package:days_100_code/screens/appScreens/addFirebase.dart';
import 'package:days_100_code/screens/homeScreen.dart';
import 'package:days_100_code/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeApp extends StatefulWidget {
  HomeApp({Key key}) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  final AuthService _auth = AuthService();
  String email = "";
  String uid = "";
  CollectionReference users = FirebaseFirestore.instance.collection('100Days');
  // Future<void> addStore() async {
  //   print('preses');
  //   return users
  //       // .add({
  //       //   'Link': 'fullName', // John Doe
  //       //   'Works': 'company', // Stokes and Sons
  //       //   // 'date': age // 42
  //       // })

  //       .where('uid', isEqualTo: uid)
  //       .get()
  //       .then((value) => {
  //             value.docs.forEach((document) {
  //               print(document.data());
  //             })
  //           })
  //       .catchError((error) => print("Failed to add user: $error"));
  // }
  Future<void> deleteUser(docUid) {
    return users
        .doc(docUid)
        .delete()
        .then((value) => {
              ScaffoldMessenger.of(context).hideCurrentSnackBar(),
              _displaySnackBarSuccess(context)
            })
        .catchError((error) => {
              ScaffoldMessenger.of(context).hideCurrentSnackBar(),
              __displaySnackBarError(context)
            });
  }

  void getEmailInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userEmail = prefs.getString('email');
    final String userUid = prefs.getString('uid');
    print(userUid);
    setState(() {
      email = userEmail;
      uid = userUid;
    });
  }

  @override
  void initState() {
    super.initState();
    getEmailInfo();
  }

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
                    child: Text(email,
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
                      'Add Data',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.greenAccent[400],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddFire2()),
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
      body:
          Consumer<FirebaseAuthenticated>(builder: (context, provider, child) {
        return (Container(
            width: MediaQuery.of(context).size.width,
            // padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: users.where('uid', isEqualTo: uid).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return new ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    // print(document.data()['Works']);
                    return Container(
                      margin: EdgeInsets.only(top: 10),
                      child: new Card(
                        color: Colors.blueGrey[900],
                        child: ListTile(
                          leading: Text(document.data()['day'].toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold)),
                          title: Text(
                            document.data()['Works'],
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: new Text(document.data()['Github'],
                              style: TextStyle(color: Colors.blue)),
                          trailing: document.data()['tweeted'] == true
                              ? Wrap(children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.twitter,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete_forever),
                                    color: Colors.red,
                                    onPressed: () {
                                      _displaySnackBar(context);
                                      deleteUser(document.id);
                                      print(document.id);
                                    },
                                  ),
                                ])
                              : IconButton(
                                  icon: Icon(Icons.delete_forever),
                                  color: Colors.red,
                                  onPressed: () {
                                    _displaySnackBar(context);
                                    deleteUser(document.id);
                                    print(document.id);
                                  },
                                ),
                          // isThreeLine: true,
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            )
            // TextButton(
            //   child: Text(email),
            //   onPressed: () async {
            //     addStore();
            //     // dynamic result = await _auth.SignOut();
            //     // if (result == null) {
            //     //   provider.notEligible();
            //     //   Navigator.pushReplacement(
            //     //     context,
            //     //     MaterialPageRoute(builder: (context) => HomeScreen()),
            //     //   );
            //     // } else {
            //     //   print('signed in');
            //     // }
            //   },
            // ),
            ));
      }),
    ));
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
        new Text("  Deleting from firestore")
      ],
    ),
  );
  // _scaffoldKey.currentState.showSnackBar(snackBar);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

_displaySnackBarSuccess(BuildContext context) {
  final snackBar = SnackBar(
    elevation: 6.0,
    backgroundColor: Colors.greenAccent[400],
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: 1),
    content: new Row(
      children: <Widget>[
        // SpinKitCubeGrid(
        //   color: Colors.white,
        //   size: 20.0,
        // ),
        new Text("  Deleted from Firestore")
      ],
    ),
  );
  // _scaffoldKey.currentState.showSnackBar(snackBar);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

__displaySnackBarError(BuildContext context) {
  final snackBar = SnackBar(
    duration: Duration(seconds: 1),
    backgroundColor: Colors.red[400],
    content: new Row(
      children: <Widget>[new Text("  Eorrors in deleting...")],
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
