import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nocodefront/Global.dart';
import 'package:nocodefront/tool.dart';

class EmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text("注册"),
      ),
      body: EmailPageBody(),
    );
  }
}

class EmailPageBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmailPageBodyState();
}

class _EmailPageBodyState extends State<EmailPageBody> {
  String email;
  TextEditingController _emailController = new TextEditingController();
  GlobalKey _formkey = new GlobalKey<FormState>();

  FocusNode _focusNodeEmail = new FocusNode();

  CancelToken _cancel = new CancelToken();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _captcha() async {
    if (_emailController.text.isEmpty) {
      print('邮箱为空，请继续输入');
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
                  '请将验证邮箱填写完整',
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
        response = await dio.request('http://114.115.205.135/auth/captcha',
            data: {
              "email": _emailController.text,
            },
            options: Options(method: "POST", responseType: ResponseType.json),
            cancelToken: _cancel);
        print(response);
        print('response end');
        //保存用户信息
        Global.setEmial(_emailController.text);
        //切换页面
        Navigator.pushReplacementNamed(context, '/signUpPage');
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
          if (e.response.statusCode == 400) {
            showError(context, "邮箱地址无效");
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
                    Text("请填写邮箱，获取验证码", style: TextStyle(
                      fontSize: 20
                    ),),
                    TextFormField(
                      //  autofocus: _autoUserNameFocus,
                      focusNode: _focusNodeEmail,
                      controller: _emailController,
                      validator: (v) =>
                      v.trim().isNotEmpty ? Null : '请输入验证邮箱',
                      decoration: InputDecoration(
                        hintText: '邮箱',
                        //labelText: userName,
                        prefixIcon: Icon(Icons.email, color: Colors.black,),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints.expand(height: 50),
                        child: RaisedButton(
                          color: Colors.blue  ,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Text(
                            '发送验证码',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                letterSpacing: 0,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.black),
                          ),
                          onPressed: _captcha,
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