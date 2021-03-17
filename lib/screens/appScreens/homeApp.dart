import 'package:days_100_code/Provider/ProviderClass.dart';
import 'package:days_100_code/screens/appScreens/addFirebase.dart';
import 'package:days_100_code/screens/homeScreen.dart';
import 'package:days_100_code/services/auth.dart';
import 'package:flutter/material.dart';
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
  CollectionReference users = FirebaseFirestore.instance.collection('100Days');
  // Future<void> addStore() async {
  //   print('preses');
  //   return users
  //       // .add({
  //       //   'Link': 'fullName', // John Doe
  //       //   'Works': 'company', // Stokes and Sons
  //       //   // 'date': age // 42
  //       // })
  //       .get()
  //       .then((value) => {
  //             value.docs.forEach((document) {
  //               print(document.data());
  //             })
  //           })
  //       .catchError((error) => print("Failed to add user: $error"));
  // }

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
              stream: users.snapshots(),
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
                    print(document.data()['Works']);
                    return Container(
                      margin: EdgeInsets.only(top: 10),
                      child: new Card(
                        color: Colors.blueGrey[900],
                        child: ListTile(
                          leading: FlutterLogo(size: 72.0),
                          title: Text(
                            document.data()['Works'],
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: new Text(document.data()['Link'],
                              style: TextStyle(color: Colors.blue)),
                          trailing: IconButton(
                            icon: Icon(Icons.delete_forever),
                            color: Colors.red,
                            onPressed: () {
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
