import 'package:coffee/models/user.dart';
import 'package:coffee/screens/authenticate/authentication.dart';
import 'package:coffee/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    if (user == null) {
      return Authentication_page();
    } else {
      return Home_page();
    }
  }
}
