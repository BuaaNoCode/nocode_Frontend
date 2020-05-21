import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nocodefront/Global.dart';
import 'package:nocodefront/pages/LoginPage.dart';
import 'package:nocodefront/pages/HomePage.dart';
void passwordReset(String newCode)
{

}

class PersonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PersonPageState();
}

class passwordUpdate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String a,b,code;
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
                  prefixIcon: Icon(Icons.person)
              ),
              onChanged: (value){
                code = value;
              },
            ),
            new TextField(
              autofocus: true,
              decoration: InputDecoration(
                  labelText: "请输入新密码",
                  hintText: "新密码",
                  prefixIcon: Icon(Icons.person)
              ),
              onChanged: (value){
                a = value;
              },
            ),
            new TextField(
              autofocus: true,
              decoration: InputDecoration(
                  labelText: "请重复新密码",
                  hintText: "新密码",
                  prefixIcon: Icon(Icons.person)
              ),
              onChanged: (value){
                b = value;
              },
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new RaisedButton(
                  child: Text("提交"),
                  onPressed: (){
                    if(a == b){
                      if(code != Global.password){
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('warning'),
                                content: Text('输入密码错误'),
                                actions: <Widget>[
                                  FlatButton(child: Text('重试'),onPressed: (){Navigator.pop(context);},),
                                ],
                              );
                            });
                      }
                      passwordReset(a);
                      Navigator.pushNamedAndRemoveUntil(context,'/loginPage',ModalRoute.withName("/loginPage"));
                    }
                    else{
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('warning'),
                              content: Text('两次输入的新密码不一致'),
                              actions: <Widget>[
                                FlatButton(child: Text('重试'),onPressed: (){Navigator.pop(context);},),
                              ],
                            );
                          });
                    }
                  },
                ),
                new Divider(
                  height: 10, // 默认线是 1px 的高度，高度设置的是上下的间距
                  color: Colors.red,
                  endIndent: 75, // 相当于 marginRight
                  indent: 25, // 相当于 marginLeft
                  thickness: 10, // 线的厚度，
                ),
                new RaisedButton(
                  child: Text("取消"),
                  onPressed: (){Navigator.pop(context);},
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
      ),
      body: new Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: new Column(
          children: <Widget>[
            new ListTile(
              leading: Icon(Icons.perm_identity,size: 20),
              title: new Text('用户名'),
              subtitle: new Row(
                children: <Widget>[
                  new Text('lzyckd1'),
                ],
              ),
            ),
            new ListTile(
              leading: Icon(Icons.lock,size: 20),
              title: new Text('密码'),
              subtitle: new Row(
                children: <Widget>[
                  new Text(Global.password),
                ],
              ),
            ),
            new ListTile(
              leading: Icon(Icons.lock_open,size: 20),
              title: new Text('修改密码'),
              onTap: () {
                Navigator.push( context,
                    MaterialPageRoute(builder: (context) {
                      return passwordUpdate();
                    }));
              },
            ),
            new ListTile(
              leading: Icon(Icons.email,size: 20),
              title: new Text('邮箱'),
              subtitle: new Row(
                children: <Widget>[
                  new Text(Global.account),
                ],
              ),
            ),
            new ListTile(
              leading: Icon(Icons.account_circle,size: 20),
              title: new Text('删除用户'),
              subtitle: new Row(
                children: <Widget>[
                  new Text('password'),
                ],
              ),
            ),
            new ListTile(
              leading: Icon(Icons.timer,size: 20),
              title: new Text('使用次数'),
              subtitle: new Row(
                children: <Widget>[
                  new Text('1'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}