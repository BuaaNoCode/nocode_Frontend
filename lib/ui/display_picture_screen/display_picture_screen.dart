import 'dart:convert';
import 'dart:io';
import 'package:nocodefront/network/ocr_client.dart';
import 'package:nocodefront/model/ocr_result.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nocodefront/tool.dart';
import 'package:open_file/open_file.dart';

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final OcrClient _ocrClient = OcrClient();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () async {
          try {
            final snackBar = SnackBar(
              content: Text('上传成功，正在识别。。。'),
            );
            _scaffoldKey.currentState.showSnackBar(snackBar);
            final Response response = await _ocrClient.request(imagePath: imagePath);
            final OcrResult _ocrResult = OcrResult(json.decode(response.body));
            String path = await _ocrResult.csv;
            print(path);
            final result = await OpenFile.open(path);
            print("type=${result.type}  message=${result.message}");
            Navigator.pop(context);
          } catch(e) {
            print(e);
            Navigator.pop(context);
//            final snackBar = SnackBar(
//              content: Text('识别错误！！！'),
//            );
            showError(context, "识别失败，请重新拍照");
//            _scaffoldKey.currentState.showSnackBar(snackBar);
          }
        }
      ),
    );
  }
}