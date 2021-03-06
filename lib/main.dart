
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nocodefront/Global.dart';
import 'package:nocodefront/pages/DisplayTable.dart';
import 'package:nocodefront/pages/EmailPage.dart';
import 'package:nocodefront/pages/FormGenPage.dart';
import 'package:nocodefront/pages/HomePage.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:nocodefront/pages/LoginPage.dart';
import 'package:nocodefront/pages/PersonPage.dart';
import 'package:nocodefront/pages/RecordsPage.dart';
import 'package:nocodefront/pages/SignUpPage.dart';
import 'package:nocodefront/ui/take_picture_screen/take_picture_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Global.init();
  final cameras = await availableCameras();
  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
  runApp(MyApp(camera: firstCamera));
  if (Platform.isAndroid) {
    //设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，
    //覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  final camera;
  const MyApp ({Key key, this.camera}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'nocode_OCR',
      theme: ThemeData(
        primaryColor: Colors.grey,
      ),
      home: getHomePage(),
      routes: {
        '/loginPage':(context) => LoginPage(),
        '/homePage': (context) => MyHomePage(camera: this.camera),
        '/recordsPage': (context) => RecordsPage(),
        '/personPage': (context) => PersonPage(),
        '/signUpPage': (context) => SignUpPage(),
        '/loginPage': (context) => LoginPage(),
        '/emailPage': (context) => EmailPage(),
      },
    );
  }
}


Widget getHomePage()
{
  if (Global.isLogin)
    return MyHomePage();
  else
    return LoginPage();
}
