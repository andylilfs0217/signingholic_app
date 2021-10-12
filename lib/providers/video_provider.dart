import 'dart:convert';

import 'package:singingholic_app/data/models/video/video.dart';
import 'package:singingholic_app/data/models/video/video_formats.dart';
import 'package:singingholic_app/data/models/video/video_list.dart';
import 'package:http/http.dart' as http;
import 'package:singingholic_app/global/variables.dart';
import 'package:singingholic_app/utils/path_utils.dart';

class VideoProvider {
  VideoProvider();

  Future<VideoListModel> fetchVideoList(
      {String? search = '',
      int? limit,
      int? offset,
      String? sort,
      String? dir,
      int? category}) async {
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      Map<String, dynamic> query = {
        'search': search,
        'limit': limit,
        'offset': offset,
        'sort': sort,
        'dir': dir,
        'category': category,
      };
      Uri apiUri =
          PathUtils.getApiUri('/public/ec/video/list', queryParameters: query);
      Object body = jsonEncode({
        "ctx": {"accountId": accountId},
        "itemFilter": "",
        "itemSort": "",
        "itemCategories": []
      });
      final response = await http.post(apiUri, headers: headers, body: body);
      VideoListModel result =
          VideoListModel.fromJson(jsonDecode(response.body));
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<VideoModel> fetchVideo({required int id}) async {
    try {
      Uri apiUri = PathUtils.getApiUri('/public/ec/video/get/$id');
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      Object body = jsonEncode({
        "ctx": {"accountId": accountId},
        'member': null,
      });
      final response = await http.post(apiUri, headers: headers, body: body);
      VideoModel result =
          VideoModel.fromJson(jsonDecode(response.body)['payload']);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<VideoFormatModel>?> fetchVideoFormats(
      {required int id, int? memberId}) async {
    try {
      Uri apiUri = PathUtils.getApiUri('/public/ec/video/get/$id/formats');
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      Object body = jsonEncode({
        "ctx": {"accountId": accountId},
        'member': {'id': memberId},
      });
      final response = await http.post(apiUri, headers: headers, body: body);
      final responseBody = jsonDecode(response.body)['payload'];
      List<VideoFormatModel> result = [];
      if (responseBody is List) {
        result = responseBody.map((e) => VideoFormatModel.fromJson(e)).toList();
      } else
        return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
