import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:nocodefront/Global.dart';
import 'package:nocodefront/tool.dart';

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

  CancelToken _cancel = new CancelToken();

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
      _focusNodeEmail.unfocus();
    }
    if (_focusNodePassword.hasFocus) {
      _focusNodeUserName.unfocus();
      _focusNodeEmail.unfocus();
    }
    if (_focusNodeEmail.hasFocus) {
      _focusNodeUserName.unfocus();
      _focusNodePassword.unfocus();
    }
  }

  void _signUp() async {
    print("signUp Pressed");
    if (_userNameController.text.isEmpty || _passwordController.text.isEmpty
        || _emailController.text.isEmpty) {
      print('账号、密码或邮箱为空，请继续输入');
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: Text(
                '提示',
                textAlign: TextAlign.center,
              ),
              children: <Widget>[
                Text(
                  '请将账号密码以及邮箱填写完整',
                  textAlign: TextAlign.center,
                ),
              ],
            );
          });
    }
    else {
      BaseOptions options = new BaseOptions(
        connectTimeout: 30000,
        sendTimeout: 30000,
        receiveTimeout: 30000,
      );
      Response response;
      Dio dio = new Dio(options);
      try {
        showLoading(context);
        response = await dio.request('http://114.115.205.135/auth/create',
            data: {
              "username": _userNameController.text,
              "password": _passwordController.text,
              "email": _emailController.text,
            },
            options: Options(method: "POST", responseType: ResponseType.json),
            cancelToken: _cancel);
        print(response);
        print('response end');
        Navigator.of(context).pop();
        //保存用户信息
//        Global.setUser(_userNameController.text, _passwordController.text,
//            response.data['name'], response.data['student_id']);
//        Global.setIsLogin(true);
//        //切换页面
//        Navigator.pushReplacementNamed(context, '/homePage');
      } on DioError catch (e) {
        print("error type:${e.type},");
        Navigator.of(context).pop();
        if ((e.type == DioErrorType.CONNECT_TIMEOUT) ||
            (e.type == DioErrorType.RECEIVE_TIMEOUT) ||
            (e.type == DioErrorType.SEND_TIMEOUT)) {
          showError(context, "网络请求超时");
        }
        else if (e.type == DioErrorType.RESPONSE) {
          print(e.response);
          Map<String, dynamic> map = jsonDecode(e.response.toString());
          ErrorDecode error = ErrorDecode.fromJson(map);
          if (e.response.statusCode == 409) {
            showError(context, "用户名冲突");
          }
          else if (e.response.statusCode == 400){
            showResponseError(context, error.detailCode.toString(), error.errorMsg);
          }
          else {
            showError(context, "服务器错误");
          }
        }
        else if (e.type == DioErrorType.CANCEL) {
          showError(context, "请求取消");
        }
        else {
          showError(context, "未知错误");
        }
      }
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
                          onPressed: _signUp,
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