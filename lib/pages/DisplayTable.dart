import 'package:flutter/material.dart';

class DisplayTable extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DisplayTable();
}

class _DisplayTable extends State<DisplayTable> {
  List<List<String>> _sour;
  String _tablename = "new table";

  setTableName(String name)
  {
    _tablename = name;
  }

  setSour(List<List<String>> a)
  {
    _sour = [["1","1"],["2","2"]];
  }

  List<TableRow> getTableData() {
    List<TableRow> tableData = List();
    print(_sour);
    _sour.forEach((e) {
      List<Text> tmp = List();
      e.forEach((element) {
        tmp.add(Text(element));
      });
      tableData.add(TableRow(
        children: tmp,
      ));
    });
    return tableData;
  }

  saveTable(String filename)
  {

  }

  @override
  Widget build(BuildContext context) {
    setSour([[""],[""]]);
    String filename = "";
      return Scaffold(
        appBar: new AppBar(
          title: new Text(_tablename),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.save),
                onPressed: ()
                {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return new Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Text("111"),
                                    /*
                                    new TextField(
                                      autofocus: true,
                                      decoration: InputDecoration(
                                          labelText: "请输入文件名",
                                          hintText: "文件名",

                                      ),
                                      onChanged: (value){
                                        filename = value;
                                      },
                                    ),
*/
                                    new FlatButton(child: Text('确认'),onPressed: (){
                                      saveTable(filename);
                                    },),
                                  ],
                                ),
                            );
                      });
                }
            )
          ],
        ),
        body:
        ListView( //使用ListView在表格数据较大的时候可以滑动
          children: <Widget>[_sour == null ?  //判断非空
          Center(child:
          Text("欢迎使用",style: TextStyle(fontSize: 30,color: Colors.blue),) ,):
          Table(
            //所有列宽
            columnWidths: const {
                //列宽
                0: FixedColumnWidth(25.0),
                1: FixedColumnWidth(100.0),
                2: FixedColumnWidth(100.0),
            },
            //表格边框样式
            border: TableBorder.all(
                color: Colors.green,
                width: 2.0,
                style: BorderStyle.solid,
            ),
            children: getTableData(),
            ),
          ],
        )
      );
  }
}
