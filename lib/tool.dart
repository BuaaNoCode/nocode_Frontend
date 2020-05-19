import 'package:flutter/material.dart';

class ErrorDecode {
  final int code;
  final int detailCode;
  final String errorMsg;

  ErrorDecode(this.code, this.detailCode, this.errorMsg);

  ErrorDecode.fromJson(Map<String, dynamic> json)
    : code = json['code'],
      detailCode = json['detailed_error_code'],
      errorMsg = json['error_msg'];

  Map<String, dynamic> toJson() => {
    'code': code,
    'detailed_error_code': detailCode,
    'error_msg': errorMsg,
  };
}

void showResponseError(context, String errorCode, String errorMsg) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          titlePadding: EdgeInsets.only(bottom: 0.0, top: 10.0),
          contentPadding: EdgeInsets.all(20.0),
          title: Text(
            '报错',
            textAlign: TextAlign.center,
          ),
          children: <Widget>[
            Text(
              "Code: " + errorCode,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            Text(
              errorMsg,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            )
          ],
        );
      });
}

void showError(context, String str) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            '报错',
            textAlign: TextAlign.center,
          ),
          children: <Widget>[
            Text(
              str,
              textAlign: TextAlign.center,
            ),
          ],
        );
      });
}

void showLoading(context, [String text]) {
  text = text ?? "Loading...";
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.0),
                  boxShadow: [
                    //阴影
                    BoxShadow(
                      color: Colors.black12,
                      //offset: Offset(2.0,2.0),
                      blurRadius: 10.0,
                    )
                  ]),
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(16),
              constraints: BoxConstraints(minHeight: 120, minWidth: 180),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          onWillPop: () {
            return new Future.value(false);
          },
        );
      });
}