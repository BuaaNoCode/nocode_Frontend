import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nocodefront/pages/FormGenPage.dart';
import 'package:nocodefront/pages/HomePage.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:nocodefront/pages/PersonPage.dart';
import 'package:nocodefront/pages/RecordsPage.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'nocode_OCR',
      theme: ThemeData(
        primaryColor: Colors.grey,
      ),
      home: MyHomePage(),
      routes: {
        '/homePage': (context) => MyHomePage(),
        '/formGenPage': (context) => FormGenPage(),
        '/recordsPage': (context) => RecordsPage(),
        '/personPage': (context) => PersonPage(),
      },
    );
  }
}
