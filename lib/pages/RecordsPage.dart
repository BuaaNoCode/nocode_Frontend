import 'package:flutter/material.dart';

class RecordsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("历史记录"),
      ),
      body: Text("历史记录"),
    );
  }
}