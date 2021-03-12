import 'package:flutter/material.dart';
import 'package:days_100_code/screens/fingerPrintAuth.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '100Days', debugShowCheckedModeBanner: false, home: LocalAuth());
  }
}
