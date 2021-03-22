import 'package:coffee/models/coffee.dart';
import 'package:coffee/screens/home/coffee_tile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/services/database.dart';
import 'package:provider/provider.dart';

class CoffeeList extends StatefulWidget {
  @override
  _CoffeeListState createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {
  @override
  Widget build(BuildContext context) {
    final coffee = Provider.of<List<Coffee>>(context) ?? [];
    // print(coffee.documents);

    return ListView.builder(
      itemCount: coffee.length,
      itemBuilder: (context, index) {
        return CoffeeTile(coffee: coffee[index]);
      },
    );
  }
}
