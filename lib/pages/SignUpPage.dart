import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text("注册"),
      ),
      body: SignUpPageBody(),
    );
  }
}

class SignUpPageBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>_SignUpPageBodyState();
}


class _SignUpPageBodyState extends State<SignUpPageBody> {
  String userName;
  String password;
  String email;
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  bool showPassword = false; //是否明文显示密码

  GlobalKey _formkey = new GlobalKey<FormState>();
  FocusNode _focusNodeUserName = new FocusNode();
  FocusNode _focusNodePassword = new FocusNode();
  FocusNode _focusNodeEmail = new FocusNode();

  @override
  void initState() {
    _focusNodeUserName.addListener(_focusNodeListener);
    _focusNodePassword.addListener(_focusNodeListener);
    _focusNodeEmail.addListener(_focusNodeListener);
    super.initState();
  }

  Future<Null> _focusNodeListener() async {
    if (_focusNodeUserName.hasFocus) {
      _focusNodePassword.unfocus();
    }
    if (_focusNodePassword.hasFocus) {
      _focusNodeUserName.unfocus();
    }
    if (_focusNodeEmail.hasFocus) {
      _focusNodeEmail.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        onTap: () {
          _focusNodeUserName.unfocus();
          _focusNodePassword.unfocus();
          _focusNodeEmail.unfocus();
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
                      validator: (v) =>
                      v.trim().isNotEmpty ? Null : '请输入用户名',
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
                      focusNode: _focusNodeEmail,
                      controller: _emailController,
                      validator: (v) => v.trim().isNotEmpty ? Null : '请输入邮箱',
                      decoration: InputDecoration(
                        hintText: '邮箱',
                        //labelText: password,
                        prefixIcon: Icon(Icons.email, color: Colors.black,),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      focusNode: _focusNodePassword,
                      controller: _passwordController,
                      obscureText: !showPassword,
                      validator: (v) => v.trim().isNotEmpty ? Null : '请输入密码',
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
                            '注册',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                letterSpacing: 20,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.white),
                          ),
                          onPressed: () => print("SignUp"),
                          disabledColor: Colors.grey,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ));
  }
}