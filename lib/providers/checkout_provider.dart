import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:singingholic_app/utils/path_utils.dart';

class CheckoutProvider {
  CheckoutProvider();

  Future<dynamic> createStripePaymentSheet(Map<String, dynamic> mapBody) async {
    try {
      Uri apiUri = PathUtils.getApiUri('/public/ec/order/stripe');
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      Object body = jsonEncode(mapBody);
      final response = await http.post(apiUri, headers: headers, body: body);
      var result = jsonDecode(response.body);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> verifyPayment(Map<String, dynamic> mapBody) async {
    try {
      Uri apiUri = PathUtils.getApiUri('/public/ec/order/payment/verify');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      Object body = jsonEncode(mapBody);
      final response = await http.post(apiUri, headers: headers, body: body);
      var result = jsonDecode(response.body);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
