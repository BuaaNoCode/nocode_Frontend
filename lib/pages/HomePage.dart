import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nocodefront/pages/FormGenPage.dart';
import 'package:nocodefront/pages/PersonPage.dart';
import 'package:nocodefront/pages/RecordsPage.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _bottomNavigationColor = Colors.grey[400];
  final _bottomNavigationSelectColor = Colors.black;
  var _controller = PageController(
    initialPage: 0,
  );
  int _currentIndex = 0;
  static int isUpdate = 1;

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _pageChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: _pageChange,
        children: <Widget>[
          FormGenPage(),
          RecordsPage(),
          PersonPage(),
        ],
        controller: _controller,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.grey,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.date_range,
              color: _bottomNavigationSelectColor,
            ),
            icon: Icon(
              Icons.linked_camera,
              color: _bottomNavigationColor,
            ),
            title: Text("表单生成"),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.list,
              color: _bottomNavigationSelectColor,
            ),
            icon: Icon(
              Icons.list,
              color: _bottomNavigationColor,
            ),
            title: Text("历史记录"),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.person,
              color: _bottomNavigationSelectColor,
            ),
            icon: Icon(
              Icons.person,
              color: _bottomNavigationColor,
            ),
            title: Text("个人中心"),
          ),
        ],
        onTap: onTap,
        currentIndex: _currentIndex,
      ),
    );
  }

  void onTap(int index) {
    _controller.jumpToPage(index);
    setState(() {
      _currentIndex = index;
    });
  }
}
