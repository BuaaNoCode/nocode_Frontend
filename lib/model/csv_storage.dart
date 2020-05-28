import 'dart:io';

import 'package:csv/csv.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CSVStorage {
  Future<String> get _localPath async {
    await Permission.storage.request();
    Directory directory = await DownloadsPathProvider.downloadsDirectory;
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/ocr.csv').create(recursive: true);
  }

  Future<List<List<dynamic>>> readCSV() async {
    final file = await _localFile;
    String csv = await file.readAsString();
    return CsvToListConverter().convert(csv);
  }

  Future<String> writeCSV(List<List<dynamic>> table) async {
    final file = await _localFile;
    String csv = ListToCsvConverter().convert(table);
    await file.writeAsString(csv);
    return file.path;
  }
}
