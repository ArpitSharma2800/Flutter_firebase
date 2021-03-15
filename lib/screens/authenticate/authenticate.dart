import 'package:days_100_code/screens/authenticate/register.dart';
import 'package:days_100_code/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.blueGrey[900],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    // bottomRight: Radius.circular(50.0)
                  )),
            ),
            Positioned(
              top: 110.0,
              left: 100.0,
              right: 100,
              child: Column(
                children: [
                  ClipRRect(
                    child: SvgPicture.asset(
                      "assets/images/welcome.svg",
                      height: 180,
                    ),
                  ),
                  Text(
                    "100DaysCOde",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 170.0,
              left: 100.0,
              right: 100.0,
              child: Container(
                width: 150,
                height: 55,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => SignIn()));
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
                      SizedBox(width: 55.0),
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
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height - 180.0,
                left: 100,
                right: 100,
                child: Container(
                  width: 150,
                  height: 55,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => Register()));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "REGISTER",
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
                ))
          ],
        ),
      ),
    ));

    // Container(
    //   child: SignIn(),
    // );
  }
}
