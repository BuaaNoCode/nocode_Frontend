//import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:nocodefront/pages/CropImageRoute.dart';
//import 'dart:io';
//
//class FormGenPage extends StatefulWidget {
//
//  @override
//  State<StatefulWidget> createState() => _FormGenPageState();
//}
//
//class _FormGenPageState extends State<FormGenPage> {
//
//  void showSelectPicker(BuildContext context) {
//    showModalBottomSheet(
//        context: context,
//        builder: (context) {
//          return Container (
//            height: 200,
//            child: Column(
//              children: <Widget>[
//                InkWell(
//                  child: Container(
//                    alignment: Alignment.center,
//                    height: 100,
//                    child: Text('拍照'),
//                    decoration: BoxDecoration(
//                        border: Border(
//                            bottom: BorderSide(width: 0.5, color: Colors.black26)
//                        )
//                    ),
//                  ),
//                  onTap: _takePhoto,
//                ),
//                InkWell(
//                  child: Container(
//                    alignment: Alignment.center,
//                    height: 100,
//                    child: Text('相册选择'),
//                  ),
//                  onTap: _choosePhoto,
//                )
//              ],
//            ),
//          );
//        }
//    );
//  }
//
//  Future _takePhoto() async {
//    await ImagePicker.pickImage(source: ImageSource.camera)
//        .then((image) => cropImage(image));
//  }
//
//  Future _choosePhoto() async {
//    await ImagePicker.pickImage(source: ImageSource.gallery)
//        .then((image) => cropImage(image));
//  }
//
//  void cropImage(File originalImage) async {
//    String result = await Navigator.push(context,
//        MaterialPageRoute(builder: (context) => CropImageRoute(originalImage)));
//    if (result.isEmpty) {
//      print('上传失败');
//    } else {
//      print('上传成功：$result');
//      //result是图片上传后拿到的url
//      setState(() {
//      });
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Scaffold(
//      appBar: AppBar(
//        automaticallyImplyLeading: false,
//        title: Text("表格生成页面"),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.add_a_photo),
//            tooltip: "Add photos",
//            onPressed: () {showSelectPicker(context);},
//          )
//        ],
//      ),
//      body: SingleChildScrollView(
//        scrollDirection: Axis.vertical,
//        child: Column(
//          mainAxisSize: MainAxisSize.min,
//          children: <Widget>[
//          ],
//        ),
//      ),
//    );
//  }
//}