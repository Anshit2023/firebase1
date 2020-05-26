import 'package:firebaseninja/services/auth.dart';
import 'package:flutter/material.dart';
class Home extends StatelessWidget {

  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          FlatButton.icon(onPressed: () async{
            await _auth.signOut();

          }, icon: Icon(Icons.person), label: Text('Log Out'))
        ],
      ),
    );
  }
}
