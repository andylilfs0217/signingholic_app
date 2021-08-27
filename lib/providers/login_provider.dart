import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:singingholic_app/global/variables.dart';

class LoginProvider {
  LoginProvider();

  Future<dynamic> login(
      {required String email, required String password}) async {
    try {
      String apiUrl = dotenv.get('THINKSHOPS_URL') + '/public/ec/member/logon';
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      Object body = jsonEncode({
        "ctx": {'accountId': accountId},
        'body': {'email': email, 'password': password, 'type': 'email'}
      });
      final response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: body);
      var result = jsonDecode(response.body);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
