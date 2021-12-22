import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singingholic_app/global/variables.dart';
import 'package:singingholic_app/utils/path_utils.dart';

class LoginProvider {
  LoginProvider();

  Future<dynamic> login(
      {required String email, required String password}) async {
    try {
      Uri apiUri = PathUtils.getApiUri('/public/ec/member/logon');
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      Object body = jsonEncode({
        "ctx": {'accountId': accountId},
        'body': {'email': email, 'password': password, 'type': 'email'}
      });
      final response = await http.post(apiUri, headers: headers, body: body);

      // Store xsession in the cookies
      final cookiesString = response.headers['set-cookie'];
      if (cookiesString == null) throw Exception('No token available');
      final cookies = Cookie.fromSetCookieValue(cookiesString);
      final xsession = cookies.value;
      var storage = FlutterSecureStorage();
      await storage.write(key: 'xsession', value: xsession);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('xsession', xsession);

      var result = jsonDecode(response.body);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> logout() async {
    try {
      var storage = FlutterSecureStorage();
      var xsession = await storage.read(key: 'xsession');
      Uri apiUri = PathUtils.getApiUri('/public/ec/member/logout');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Cookie": "xsession=$xsession",
      };
      final response = await http.post(apiUri, headers: headers);

      await storage.delete(key: 'xsession');

      var result = jsonDecode(response.body);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
