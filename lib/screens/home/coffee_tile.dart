import 'package:coffee/models/coffee.dart';
import 'package:coffee/models/user.dart';
import 'package:flutter/material.dart';

class CoffeeTile extends StatelessWidget {
  final Coffee coffee;
  CoffeeTile({this.coffee});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[coffee.strength],
            backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(coffee.name),
          subtitle: Text('Takes ${coffee.sugars} sugar(s)'),
        ),
      ),
    );
  }
}
