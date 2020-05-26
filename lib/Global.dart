import 'package:shared_preferences/shared_preferences.dart';

class Global{
  static SharedPreferences _sp;
  static bool _isLogin = false;
  static String _token = null;
  /*sp中需要保存的用户信息
  static String account; 账号
  static String password; 密码
   */
  static init() async {
    _sp = await SharedPreferences.getInstance();
  }

  //是否登陆
  static setIsLogin(bool value) async {
    _sp.setBool('isLogin', value);
  }

  static bool get isLogin {
    return _sp.getBool('isLogin') ?? _isLogin;
  }

  //登录时，记录用户信息
  static setUser(String accountValue, String passwordValue,
      String studentIDValue, String takenValue) async {
    _sp.setString('account', accountValue);
    _sp.setString('password', passwordValue);
    _sp.setString('studentID', studentIDValue);
    _sp.setString('taken', takenValue);
  }

  static String get account {
    return _sp.getString('account');
  }

  static String get token {
    return _token;
  }
  static String get password {
    return _sp.getString('password');
  }
}