import 'package:coffee/models/user.dart';
import 'package:coffee/services/database.dart';
import 'package:coffee/shared/constants.dart';
import 'package:coffee/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return ListView(children: [
      StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData userData = snapshot.data;
              return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text('update your Coffee Settings',
                        style: TextStyle(fontSize: 18)),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: userData.name,
                      maxLines: 1,
                      decoration: textInputDecoration,
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) {
                        setState(() {
                          _currentName = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: _currentSugars ?? userData.sugars,
                      items: sugars.map((sugar1) {
                        return DropdownMenuItem<String>(
                          value: sugar1,
                          child: Text('$sugar1 suagrs'),
                        );
                      }).toList(),
                      onChanged: (value1) {
                        setState(() {
                          _currentSugars = value1;
                        });
                      },
                    ),
                    Slider(
                      min: 100,
                      max: 900,
                      divisions: 8,
                      activeColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      inactiveColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      value: (_currentStrength ?? userData.strength).toDouble(),
                      onChanged: (val) {
                        setState(() {
                          _currentStrength = val.round();
                        });
                      },
                    ),
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await DatabaseService(uid: user.uid).updateUserData(
                              _currentSugars ?? userData.sugars,
                              _currentName ?? userData.name,
                              _currentStrength ?? userData.strength,
                            );

                            Navigator.pop(context);
                          }
                        }),
                  ],
                ),
              );
            } else {
              return Loading();
            }
          })
    ]);
  }
}
