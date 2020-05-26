import 'package:firebaseninja/services/auth.dart';
import 'package:firebaseninja/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebaseninja/shared/constants.dart';
class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth=AuthService();
  final _formKey=GlobalKey<FormState>();
  bool loading=false;

  //text field state
  String email='';
  String password='';
  String error='';
  @override
  Widget build(BuildContext context) {
    return loading?Loading():Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        title: Text('Sign in'),
        actions: <Widget>[
          FlatButton.icon(onPressed: (){widget.toggleView();}, icon: Icon(Icons.person), label: Text('Register'))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 50),
        child:Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val)=>val.isEmpty?'Enter an Email':null,
                onChanged: (val){
                  setState(()=>email=val);
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val)=>val.length<6?'Enter an Password 6+characters long':null,
                onChanged: (val){
                  setState(()=>password=val);
                  },
              ),
              SizedBox(height: 20,),
              RaisedButton(
                color: Colors.pink,
                child: Text('Sign In'
                ),
                onPressed: ()async{

                  if(_formKey.currentState.validate()){
                    setState(() =>loading=true);
                    dynamic result=await _auth.signInWithEmailAndPassword(email, password);

                    if(result==null){
                      setState(() {error='COULD NOT SIGN IN WITH THOSE CREDENTIALS';
                      loading=false;

                      });
                    }
                  }

                },
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
