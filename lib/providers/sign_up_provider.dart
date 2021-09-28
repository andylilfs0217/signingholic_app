import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:singingholic_app/global/variables.dart';
import 'package:singingholic_app/utils/path_utils.dart';

class SignUpProvider {
  SignUpProvider();

  Future<dynamic> registerMember(
      {required String name,
      required String email,
      required Map inputFields,
      required String password,
      required String password2}) async {
    try {
      Uri apiUri = PathUtils.getApiUri('/public/ec/member/signup');
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      Map body = {
        'name': name,
        'email': email,
        'data': '{}',
        'password': password,
        'password2': password2,
      };
      for (var inputField in inputFields.entries) {
        var field = inputField.key;
        var value = inputField.value;
        body[field] = value;
      }
      Object requestBody = jsonEncode({
        "ctx": {'accountId': accountId},
        'body': body
      });
      final response =
          await http.post(apiUri, headers: headers, body: requestBody);

      var result = jsonDecode(response.body);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> getMemberRegistrationConfig() async {
    try {
      Uri apiUri = PathUtils.getApiUri('/public/site/info');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      Object body = jsonEncode({'company': APP_CODE});
      final response = await http.post(apiUri, headers: headers, body: body);
      var result = jsonDecode(response.body);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
