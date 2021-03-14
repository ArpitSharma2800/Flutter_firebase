import 'package:days_100_code/Provider/ProviderClass.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeApp extends StatefulWidget {
  HomeApp({Key key}) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body:
          Consumer<FirebaseAuthenticated>(builder: (context, provider, child) {
        return (Container(
          child: Text(provider.email),
        ));
      }),
    ));
  }
}
