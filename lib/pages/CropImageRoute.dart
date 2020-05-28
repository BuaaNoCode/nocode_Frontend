//import 'dart:convert';
//import 'dart:io';
//import 'dart:math';
//import 'package:dio/dio.dart' as Dio;
//import 'package:flutter/material.dart';
//import 'package:image_crop/image_crop.dart';
//import 'package:http_parser/http_parser.dart';
//import 'package:nocodefront/Global.dart';
//import 'package:nocodefront/model/ocr_result.dart';
//import 'package:nocodefront/network/ocr_client.dart';
//import 'package:nocodefront/tool.dart';
//import 'package:http/http.dart';
//import 'package:open_file/open_file.dart';
//
//class CropImageRoute extends StatefulWidget {
//  CropImageRoute(this.image);
//
//  final File image; //原始图片路径
//
//  @override
//  _CropImageRouteState createState() => new _CropImageRouteState();
//}
//
//class _CropImageRouteState extends State<CropImageRoute> {
//  double baseLeft; //图片左上角的x坐标
//  double baseTop; //图片左上角的y坐标
//  double imageWidth; //图片宽度，缩放后会变化
//  double imageScale = 1; //图片缩放比例
//  Image imageView;
//  Dio.CancelToken _cancel = new Dio.CancelToken();
//
//  int projectId;
//
//  final cropKey = GlobalKey<CropState>();
//
//  @override
//  Widget build(BuildContext context) {
//
//    MediaQueryData queryData = MediaQuery.of(context);
//
//    return Scaffold(
//        body: Container(
//          height: queryData.size.height,
//          width: queryData.size.width,
//          child: Column(
//            children: <Widget>[
//              Container(
//                height: queryData.size.height * 0.8,
//                child: Crop.file(
//                  widget.image,
//                  key: cropKey,
//                  aspectRatio: 1.0,
//                  alwaysShowGrid: true,
//                ),
//              ),
//              RaisedButton(
//                onPressed: () async {
//                  _crop(widget.image);
//                },
//                child: Text('ok'),
//              ),
//            ],
//          ),
//        ));
//  }
//
////  Future<int> _createProject(String name, String comment) async {
////    Dio.BaseOptions options = Dio.BaseOptions(
////      headers: {HttpHeaders.authorizationHeader: "Bearer " + Global.token},
////      connectTimeout: 30000,
////      sendTimeout: 30000,
////      receiveTimeout: 30000,
////    );
////    Dio.Response response;
////    Dio.Dio dio = Dio.Dio(options);
////    try {
////      showLoading(context);
////      response = await dio.post("http://114.115.205.135/ocr/project",
////        data: Dio.FormData.fromMap({
////          "name": name,
////          "comment": comment,
////        }).readAsBytes(),
////        options: Dio.Options(method: "POST", responseType: Dio.ResponseType.json),
////        cancelToken: _cancel,
////      );
////      var data = jsonDecode(response.toString());
////      print(data["id"]);
////      this.projectId = data["id"];
////      print(this.projectId);
////      print(response);
////      Navigator.pop(context);
////      return data["id"];
////    } on Dio.DioError catch(e) {
////      print(e);
////      Navigator.pop(context);
////    }
////  }
//
////  Future<void>_uploadImage(File image, int projectId) async {
////    String path = image.path;
////
////    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
////    var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
////    var file = await Dio.MultipartFile.fromFile(path,
////      filename: name,
////      contentType: MediaType("image", suffix),
////    );
////    var jsonData = utf8.encode(jsonEncode({
////      "name": "test",
////      "comment": "test comment"
////    }));
////
////    Dio.FormData formData = Dio.FormData.fromMap({
////      "json": jsonData,
////      "file": file,
////    });
////
////    print(file.toString());
////
////    Dio.BaseOptions options = Dio.BaseOptions(
////      headers: {HttpHeaders.authorizationHeader: "Bearer " + Global.token, HttpHeaders.contentTypeHeader: "Multipart/form-data"},
////      connectTimeout: 30000,
////      sendTimeout: 30000,
////      receiveTimeout: 30000,
////    );
////    Dio.Response response;
////    Dio.Dio dio = Dio.Dio(options);
////    try {
////      showLoading(context);
////      print("id " + projectId.toString() + ", path " + image.path);
////      response = await dio.post("http://114.115.205.135/ocr/project/$projectId",
////        data: formData,
////        options: Dio.Options(method: "POST", responseType: Dio.ResponseType.json),
////        cancelToken: _cancel,
////      );
////      print(response);
////      Navigator.pop(context);
////    } on Dio.DioError catch(e) {
////      print(e);
////      print("error type:${e.type},");
////      Navigator.of(context).pop();
////      if ((e.type == Dio.DioErrorType.CONNECT_TIMEOUT) ||
////          (e.type == Dio.DioErrorType.RECEIVE_TIMEOUT) ||
////          (e.type == Dio.DioErrorType.SEND_TIMEOUT)) {
////        showError(context, "网络请求超时");
////      }
////      else if (e.type == Dio.DioErrorType.RESPONSE) {
////        print(e.response);
////        Map<String, dynamic> map = jsonDecode(e.response.toString());
////        ErrorDecode error = ErrorDecode.fromJson(map);
////        if (e.response.statusCode == 409) {
////          showError(context, "用户名冲突");
////        }
////        else if (e.response.statusCode == 400){
////          showResponseError(context, error.detailCode.toString(), error.errorMsg);
////        }
////        else {
////          showError(context, "服务器错误");
////        }
////      }
////      else if (e.type == Dio.DioErrorType.CANCEL) {
////        showError(context, "请求取消");
////      }
////      else {
////        showError(context, "未知错误");
////      }
////    }
////  }
//
//  Future<void> _OCRGen(File file) async {
//    try {
////      var snackBar = SnackBar(
////        content: Text('上传成功，正在识别。。。'),
////      );
//      showLoading(context);
//      OcrClient _ocrClient = OcrClient();
//      Response response = await _ocrClient.request(imagePath: file.path);
//      OcrResult _ocrResult = OcrResult(json.decode(response.body));
//      String path = await _ocrResult.csv;
//      print(path);
//      var result = await OpenFile.open(path);
//      print("type=${result.type}  message=${result.message}");
//    } catch(e) {
//      print(e);
//      final snackBar = SnackBar(
//        content: Text('识别错误！！！'),
//      );
//    } finally {
//      Navigator.pop(context);
//    }
//  }
//
//  Future<void> _crop(File originalFile) async {
//    final crop = cropKey.currentState;
//    final area = crop.area;
//    if (area == null) {
//      print('裁剪不成功');
//    }
//    await ImageCrop.requestPermissions().then((value) {
//      if (value) {
//        ImageCrop.cropImage(
//          file: originalFile,
//          area: crop.area,
//        ).then((value) {
//          print(value.path);
//          _OCRGen(value);
//        }).catchError((e) {
//          print(e);
//        });
//      } else {
//
//      }
//    });
//  }
//}