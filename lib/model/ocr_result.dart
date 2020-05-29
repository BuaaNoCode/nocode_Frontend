import 'csv_storage.dart';

class OcrResult {
  final CSVStorage storage = CSVStorage();
  List<List<dynamic>> table = List<List<dynamic>>();
  Future<String> _csv;

  Future<String> get csv {
    if (_csv == null)
      _csv = storage.writeCSV(table);
    return _csv;
  }

  OcrResult(Map<String, dynamic> result) {
    try {
      dynamic res = result['tables'][0];
      res.removeAt(0);
      res.removeLast();
      for (var row in res) {
        List<dynamic> r = List<dynamic>();
        for (var column in row) {
          if (column['text'] != null)
            r.add(column['text'][0]);
          else
            r.add('');
        }
        table.add(r);
      }
    } catch (e) {
      throw e;
    }
  }
}