import 'package:days_100_code/Provider/ProviderClass.dart';
import 'package:flutter/material.dart';
import 'package:days_100_code/screens/fingerPrintAuth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FirebaseAuthenticated(),
      child: MaterialApp(
          title: '100Days',
          debugShowCheckedModeBanner: false,
          home: LocalAuth()),
    );
  }
}
