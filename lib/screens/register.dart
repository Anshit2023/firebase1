import 'package:firebaseninja/shared/constants.dart';
import 'package:firebaseninja/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebaseninja/services/auth.dart';
class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey=GlobalKey<FormState>();
  bool loading=false;

  String email = '';
  String password = '';
  String error='';

  @override
  Widget build(BuildContext context) {
    return loading?Loading():Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        title: Text('Sign up'),
        actions: <Widget>[
          FlatButton.icon(onPressed: () {
            widget.toggleView();
          }, icon: Icon(Icons.person), label: Text('Sign In'))
        ],
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val)=>val.isEmpty?'Enter an Email':null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (val)=>val.length<6?'Enter an Password 6+characters long':null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20,),
                RaisedButton(
                  color: Colors.pink,
                  child: Text('Register'
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(() {
                        loading=true;
                      });
                      dynamic result=await _auth.registerWithEmailAndPassword(email, password);
                      if(result==null){
                        setState(() {error='Please Supply Valid Email';
                        loading=false;
                        });
                      }
                    }
                  }
                ),
                SizedBox(height: 12,),
                Text(
                  error
                ),
              ],
            ),
          )
      ),
    );
  }
}