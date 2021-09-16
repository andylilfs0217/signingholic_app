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

  Future<VideoCommentModel> createVideoComment(
      {required int videoId,
      required int memberId,
      required num rating,
      required String comment,
      int? parentCommentId}) async {
    try {
      Uri apiUri = PathUtils.getApiUri('/api/ecommerce/comment/video');
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      Map<String, dynamic> bodyJson = {
        'video': videoId,
        'member': memberId,
        'comment': comment,
        'stars': rating,
        'parentComment': parentCommentId,
      };
      String body = jsonEncode(bodyJson);
      final response = await http.post(apiUri, headers: headers, body: body);
      var responseBody = jsonDecode(response.body)?['payload'];
      responseBody['video'] = {'id': responseBody['video']};
      responseBody['member'] = {'id': responseBody['member']};
      if (responseBody['parentComment'] != null) {
        responseBody['parentComment'] = {'id': responseBody['parentComment']};
      }
      VideoCommentModel result = VideoCommentModel.fromJson(responseBody);

      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
