import 'package:flutter/material.dart';
import 'package:nocodefront/Global.dart';

class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: LoginPageBody(),
    );
  }
}

class LoginPageBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>_LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: Center(
        child: Container(
          child: Row(
            children: <Widget>[
              RaisedButton(
                child: Text("登录"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/homePage');
                  Global.setIsLogin(true);
                },
              ),
              RaisedButton(
                child: Text("注册"),
                onPressed: () => Navigator.pushReplacementNamed(context, '/signUpPage'),
              )
            ],
          ),
        ),
      ),
    );
  }
}