import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:singingholic_app/data/models/product/product_cart.dart';
import 'package:singingholic_app/data/models/video/video_cart.dart';
import 'package:singingholic_app/global/variables.dart';
import 'package:singingholic_app/utils/path_utils.dart';

class CartProvider {
  CartProvider();

  Future<dynamic> getProductCartDetails(
      ProductCartModel productCartModel) async {
    try {
      Uri apiUri = PathUtils.getApiUri('/public/ec/cart/update');
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      Object body = jsonEncode(productCartModel.toJson());
      final response = await http.post(apiUri, headers: headers, body: body);
      var result = jsonDecode(response.body);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> getVideoCartDetails(VideoCartModel videoCartModel) async {
    try {
      Uri apiUri = PathUtils.getApiUri('/public/ec/cart/update');
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      Object body = jsonEncode(videoCartModel.toJson());
      final response = await http.post(apiUri, headers: headers, body: body);
      var result = jsonDecode(response.body);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> changeVideoCart(VideoCartModel videoCartModel) async {
    try {
      var storage = FlutterSecureStorage();
      var xsession = await storage.read(key: 'xsession');
      Uri apiUri = PathUtils.getApiUri('/public/ec/member/cart/video');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Cookie": "xsession=$xsession;"
      };
      Object body = jsonEncode({
        'ctx': {'accountId': accountId},
        'body': videoCartModel.toJson()
      });
      final response = await http.post(apiUri, headers: headers, body: body);
      var result = jsonDecode(response.body);
      if (!result['succeed']) {
        throw Exception('Update video cart failed');
      }
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
