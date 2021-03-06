import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nocodefront/Global.dart';
import 'package:nocodefront/tool.dart';
import 'package:dio/dio.dart';

class PersonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PersonPageState();
}

void deleteUser(BuildContext context) async
{
  CancelToken _cancel = new CancelToken();
  BaseOptions options = new BaseOptions(
    headers: {HttpHeaders.authorizationHeader: "Bearer " + Global.token},
    connectTimeout: 30000,
    sendTimeout: 30000,
    receiveTimeout: 30000,
  );
  Response response;
  Dio dio = new Dio(options);
  try {
    showLoading(context);
    print("delete User Presses");
    response = await dio.request('http://114.115.205.135/auth/disable',
        data: {
          "username": Global.account,
          "password": Global.password,
        },
        options: Options(method: "POST", responseType: ResponseType.json),
        cancelToken: _cancel);
    //
    Global.setIsLogin(false);
    Navigator.pushNamedAndRemoveUntil(context, '/loginPage', ModalRoute.withName("/loginPage"));
    //保存用户信息
  } on DioError catch (e) {
    print("delete User failed");
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
      if (e.response.statusCode == 401) {
        if (error.detailCode == 40101) {
          showError(context, "用户名或密码错误");
        }
        else {
          showResponseError(context, error.detailCode.toString(), error.errorMsg);
        }
      }
      else if (e.response.statusCode == 404) {
        if (error.detailCode == 40400) {
          showError(context, "此用户名不存在");
        }
        else {
          showResponseError(context, error.detailCode.toString(), error.errorMsg);
        }
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

class passwordUpdate extends StatelessWidget {
  void passwordReset(String newCode, BuildContext context) async {
    CancelToken _cancel = new CancelToken();
    print("token:");
    print(Global.token);
    BaseOptions options = new BaseOptions(
      headers: {HttpHeaders.authorizationHeader: "Bearer " + Global.token},
      connectTimeout: 30000,
      sendTimeout: 30000,
      receiveTimeout: 30000,
    );
    print("options:");
    print(options);
    Response response;
    Dio dio = new Dio(options);
    try {
      showLoading(context);
      print("change Password pressed");
      response = await dio.request('http://114.115.205.135/auth/reset',
          data: {
            "username": Global.account,
            "password": Global.password,
            "new_password": newCode,
          },
          options: Options(method: "POST", responseType: ResponseType.json),
          cancelToken: _cancel);
      print(response);
      print("change password success");
      Global.setIsLogin(false);
      Navigator.pushNamedAndRemoveUntil(
          context, '/loginPage', ModalRoute.withName("/loginPage"));
      //保存用户信息
    } on DioError catch (e) {
      print("change password failed");
      if ((e.type == DioErrorType.CONNECT_TIMEOUT) ||
          (e.type == DioErrorType.RECEIVE_TIMEOUT) ||
          (e.type == DioErrorType.SEND_TIMEOUT)) {
        showError(context, "网络请求超时");
      } else if (e.type == DioErrorType.RESPONSE) {
        print(e.response);
        Map<String, dynamic> map = jsonDecode(e.response.toString());
        ErrorDecode error = ErrorDecode.fromJson(map);
        if (e.response.statusCode == 401) {
          if (error.detailCode == 40101) {
            showError(context, "用户名或密码错误");
          } else {
            showResponseError(
                context, error.detailCode.toString(), error.errorMsg);
          }
        }
        else if (e.response.statusCode == 404) {
          if (error.detailCode == 40400) {
            showError(context, "此用户名不存在");
          }
          else {
            showResponseError(context, error.detailCode.toString(), error.errorMsg);
          }
        }
        else {
          showError(context, "服务器错误");
        }
      } else if (e.type == DioErrorType.CANCEL) {
        showError(context, "请求取消");
      } else {
        showError(context, "未知错误");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String a, b, code;
    return Scaffold(
      appBar: AppBar(
        title: Text("修改密码"),
      ),
      body: Center(
        child: new Column(
          children: <Widget>[
            new TextField(
              autofocus: true,
              decoration: InputDecoration(
                  labelText: "请输入原密码",
                  hintText: "原密码",
                  prefixIcon: Icon(Icons.person)),
              onChanged: (value) {
                code = value;
              },
            ),
            new TextField(
              autofocus: true,
              decoration: InputDecoration(
                  labelText: "请输入新密码",
                  hintText: "新密码",
                  prefixIcon: Icon(Icons.person)),
              onChanged: (value) {
                a = value;
              },
            ),
            new TextField(
              autofocus: true,
              decoration: InputDecoration(
                  labelText: "请重复新密码",
                  hintText: "新密码",
                  prefixIcon: Icon(Icons.person)),
              onChanged: (value) {
                b = value;
              },
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new RaisedButton(
                  child: Text("提交"),
                  onPressed: () {
                    if (a == b) {
                      if (code != Global.password) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('warning'),
                                content: Text('输入密码错误'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('重试'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                      }
                      passwordReset(a, context);
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('warning'),
                              content: Text('两次输入的新密码不一致'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('重试'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                    }
                  },
                ),
                new Divider(
                  height: 10,
                  // 默认线是 1px 的高度，高度设置的是上下的间距
                  color: Colors.red,
                  endIndent: 75,
                  // 相当于 marginRight
                  indent: 25,
                  // 相当于 marginLeft
                  thickness: 10, // 线的厚度，
                ),
                new RaisedButton(
                  child: Text("取消"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("个人中心"),
        automaticallyImplyLeading: false,
      ),
      body: CustomScrollView(
        shrinkWrap: true,
        // 内容
        slivers: <Widget>[
          new SliverPadding(
            padding: const EdgeInsets.all(20.0),
            sliver: new SliverList(
              delegate: new SliverChildListDelegate(
                <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            contentPadding: EdgeInsets.all(0),
                            title: Text(
                              Global.account,
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            subtitle: Text(
                              "邮箱:${Global.email}",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.account_circle,
                          size: 50,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: ListTile(
                      leading: Icon(Icons.lock_open, size: 20),
                      title: Text(
                        '修改密码',
                        style: TextStyle(fontSize: 20),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        size: 20,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => passwordUpdate()));
                      },
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            top:
                                BorderSide(width: 1, color: Colors.grey[300]))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: ListTile(
                      leading: Icon(Icons.delete_forever, size: 20),
                      title: new Text(
                        '删除用户',
                        style: TextStyle(fontSize: 20),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('warning'),
                                content: Text('删除用户后不可恢复'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('确定删除'),
                                    onPressed: (){
                                      deleteUser(context);
                                    },),
                                  FlatButton(
                                    child: Text('取消'),
                                      onPressed: () => Navigator.pop(context),
                                  )
                                ],
                              );
                            });
                      },
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        size: 20,
                      ),
                    ),
                    decoration: BoxDecoration(border:
                      Border(top: BorderSide(width: 1, color: Colors.grey[300]))),
                  ),
//                  SizedBox(
//                    height: 10,
//                  ),
//                  Container(
//                    child: ListTile(
//                      leading: Icon(Icons.timer, size: 20),
//                      title: new Text(
//                        '使用次数: 1',
//                        style: TextStyle(fontSize: 20),
//                      ),
//                    ),
//                    decoration: BoxDecoration(
//                        border: Border(
//                            top:
//                                BorderSide(width: 1, color: Colors.grey[300]))),
//                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: MaterialButton(
                      color: Color(0x99FFFFFF),
                      minWidth: double.infinity,
                      height: 50,
                      child: Text(
                        "退出登录",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        Global.setIsLogin(false);
                        Navigator.pushNamedAndRemoveUntil(context, '/loginPage',
                            ModalRoute.withName("/loginPage"));
                      },
                    ),
//            decoration: BoxDecoration(border: Border.all(width: 1)),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
