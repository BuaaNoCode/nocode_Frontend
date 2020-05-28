import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'ali_ocr.dart';

class OcrClient {
  static const String _ali_ocr_api_authorization =
      'APPCODE b317f411118f40508d52b7a5a4af3cc8';
  final AliOcr _aliOcr = AliOcr(_ali_ocr_api_authorization);

  Future<Response> request({@required String imagePath, String apiType}) async {
    return _aliOcr.request(imagePath: imagePath);
  }
}
