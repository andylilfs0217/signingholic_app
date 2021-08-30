import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:singingholic_app/data/models/product/product_cart.dart';
import 'package:singingholic_app/data/models/video/video_cart.dart';
import 'package:singingholic_app/global/variables.dart';

class CartProvider {
  CartProvider();

  Future<dynamic> getProductCartDetails(
      ProductCartModel productCartModel) async {
    try {
      String apiUrl = dotenv.get('THINKSHOPS_URL') + '/public/ec/cart/update';
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      Object body = jsonEncode(productCartModel.toJson());
      final response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: body);
      var result = jsonDecode(response.body);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> getVideoCartDetails(VideoCartModel videoCartModel) async {
    try {
      String apiUrl = dotenv.get('THINKSHOPS_URL') + '/public/ec/cart/update';
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      Object body = jsonEncode(videoCartModel.toJson());
      final response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: body);
      var result = jsonDecode(response.body);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> changeVideoCart(VideoCartModel videoCartModel) async {
    try {
      String apiUrl =
          dotenv.get('THINKSHOPS_URL') + '/public/ec/member/cart/video';
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      Object body = jsonEncode({
        'ctx': {'accountId': accountId},
        'body': videoCartModel.toJson()
      });
      final response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: body);
      var result = jsonDecode(response.body);
      // if (!result['succeed']) {
      //   throw Exception('Update video cart failed');
      // }
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
