import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:singingholic_app/global/variables.dart';
import 'package:singingholic_app/utils/path_utils.dart';

class SignUpProvider {
  SignUpProvider();

  Future<dynamic> registerMember(
      {required String name,
      required String email,
      required String mobile,
      required String password,
      required String password2}) async {
    try {
      Uri apiUri = PathUtils.getApiUri('/public/ec/member/signup');
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      Object body = jsonEncode({
        "ctx": {'accountId': accountId},
        'body': {
          'name': name,
          'email': email,
          'mobile': mobile,
          'data': '{}',
          'password': password,
          'password2': password2,
        }
      });
      final response = await http.post(apiUri, headers: headers, body: body);

      var result = jsonDecode(response.body);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
