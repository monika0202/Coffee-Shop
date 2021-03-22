import 'package:coffee/screens/authenticate/rgister.dart';
import 'package:coffee/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authentication_page extends StatefulWidget {
  @override
  _Authentication_pageState createState() => _Authentication_pageState();
}

class _Authentication_pageState extends State<Authentication_page> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Container(child: Sign_In(toggleView: toggleView));
    } else {
      return Container(child: RagiterPage(toggleView: toggleView));
    }
  }
}
