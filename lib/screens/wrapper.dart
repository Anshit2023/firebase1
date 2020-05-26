import 'package:firebaseninja/home/home.dart';
import 'package:firebaseninja/screens/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebaseninja/models/user.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user =Provider.of<User>(context);

    //either home or authenticate
  if(user==null){
    return Authenticate();
  }else{
    return Home();
    }
  }
}
