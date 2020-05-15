import 'package:flutter/material.dart';

class PersonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("个人中心"),
      ),
      body: Text("个人中心"),
    );
  }
}