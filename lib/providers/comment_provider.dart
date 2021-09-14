import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:singingholic_app/data/models/comment/video_comment_model.dart';
import 'package:singingholic_app/utils/path_utils.dart';

class CommentProvider {
  CommentProvider();

  Future<List<VideoCommentModel>> getVideoCommentsAndReplies(
      int videoId) async {
    try {
      Uri apiUri = PathUtils.getApiUri(
          '/api/ecommerce/comment/video/list-and-replies/$videoId');
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      final response = await http.get(apiUri, headers: headers);

      var responseBody = jsonDecode(response.body)?['payload']?[0] ?? [];
      List<VideoCommentModel> result = responseBody
              .map<VideoCommentModel>((e) => VideoCommentModel.fromJson(e))
              .toList() ??
          [];

      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
