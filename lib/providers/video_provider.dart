import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:singingholic_app/data/models/video/video.dart';
import 'package:singingholic_app/data/models/video/video_list.dart';
import 'package:http/http.dart' as http;

class VideoProvider {
  VideoProvider();

  Future<VideoListModel> fetchVideoList() async {
    try {
      String apiUrl = dotenv.get('THINKSHOPS_URL') +
          '/public/ec/video/list?search&limit=30&offset=0&sort&dir=asc&category=0';
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      Object body = jsonEncode({
        "ctx": {"accountId": 52},
        "itemFilter": "",
        "itemSort": "",
        "itemCategories": []
      });
      final response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: body);
      VideoListModel result =
          VideoListModel.fromJson(jsonDecode(response.body));
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<VideoModel> fetchVideo({required int id}) async {
    try {
      String apiUrl = dotenv.get('THINKSHOPS_URL') + '/public/ec/video/get/$id';
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      Object body = jsonEncode({
        "ctx": {"accountId": 52},
        'member': null,
      });
      final response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: body);
      VideoModel result =
          VideoModel.fromJson(jsonDecode(response.body)['payload']);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
