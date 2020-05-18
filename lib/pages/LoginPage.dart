import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nocodefront/Global.dart';
import 'package:nocodefront/pages/SignUpPage.dart';

class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
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
  String userName;
  String password;
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  bool showPassword = false; //是否明文显示密码

  GlobalKey _formkey = new GlobalKey<FormState>();
  FocusNode _focusNodeUserName = new FocusNode();
  FocusNode _focusNodePassword = new FocusNode();

  @override
  void initState() {
    _focusNodeUserName.addListener(_focusNodeListener);
    _focusNodePassword.addListener(_focusNodeListener);
    super.initState();
  }

  Future<Null> _focusNodeListener() async {
    if (_focusNodeUserName.hasFocus) {
      _focusNodePassword.unfocus();
    }
    if (_focusNodePassword.hasFocus) {
      _focusNodeUserName.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        onTap: () {
          _focusNodeUserName.unfocus();
          _focusNodePassword.unfocus();
        },
        child: Center(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(50),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                autovalidate: false,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      //  autofocus: _autoUserNameFocus,
                      focusNode: _focusNodeUserName,
                      controller: _userNameController,
//                      validator: (v) =>
//                      v.trim().isNotEmpty ? Null : '请输入用户名',
                      decoration: InputDecoration(
                        hintText: '用户名',
                        //labelText: userName,
                        prefixIcon: Icon(Icons.person, color: Colors.black,),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      focusNode: _focusNodePassword,
                      controller: _passwordController,
                      obscureText: !showPassword,
//                      validator: (v) => v.trim().isNotEmpty ? Null : '请输入密码',
                      decoration: InputDecoration(
                        hintText: '密码',
                        //labelText: password,
                        prefixIcon: Icon(Icons.lock, color: Colors.black,),
                        suffixIcon: IconButton(
                          icon: Icon(showPassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints.expand(height: 50),
                        child: RaisedButton(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Text(
                            '登录',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                letterSpacing: 20,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.white),
                          ),
                          onPressed: () => print("login"),
                          disabledColor: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        OutlineButton(
                          borderSide: BorderSide(width: 0, color: Colors.white),
                          child: Text("忘记密码",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          onPressed: () => Navigator.pushNamed(context, '/signUpPage'),
                        ),
                        OutlineButton(
                          borderSide: BorderSide(width: 0, color: Colors.white),
                          child: Text("用户注册",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          onPressed: () => Navigator.pushNamed(context, '/signUpPage'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}