import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class AliOcr {
  static const String _baseUrl = 'https://form.market.alicloudapi.com/api/predict/ocr_table_parse';
  final String _authorization;

  AliOcr(this._authorization);

  Future<Response> request({@required String imagePath}) async {
    final bytes = await File(imagePath).readAsBytes();
    final response = await post(
        _baseUrl,
        headers: <String, String>{
          'Authorization': _authorization,
        },
        body: jsonEncode(<String, dynamic>{
          'image': base64Encode(bytes),
          'configure': {
            'format': 'json',
            'finance': false,
            'dir_assure': false
          }
        }));

    if (response.statusCode == 200) {
      print("Success!");
      return response;
    } else {
      throw Exception('Failed to load album');
    }
  }
}