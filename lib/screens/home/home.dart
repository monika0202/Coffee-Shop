import 'package:coffee/models/coffee.dart';
import 'package:coffee/screens/home/setting_form.dart';
import 'package:coffee/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:coffee/services/database.dart';
import 'package:provider/provider.dart';
import 'package:coffee/screens/home/coffee_list.dart';

class Home_page extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              // mainAxisSize: MainAxisSize.min
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: SettingForm(),
            );
          });
    }

    return StreamProvider<List<Coffee>>.value(
        value: DatabaseService().coffee,
        initialData: null,
        child: Scaffold(
          backgroundColor: Colors.brown[100],
          appBar: AppBar(
            title: Text('Coffee Shop'),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                onPressed: () async {
                  await _auth.signOutAnon();
                },
                icon: Icon(Icons.person),
                label: Text('logout'),
              ),
              FlatButton.icon(
                icon: Icon(Icons.settings),
                onPressed: () {
                  _showSettingsPanel();
                },
                label: Text('settings'),
              )
            ],
          ),
          body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/xyz.jpeg',
                      ))),
              child: CoffeeList()),
        ));
  }
}
