import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:singingholic_app/data/models/video/video_submission.dart';

import 'package:singingholic_app/utils/path_utils.dart';

class VideoSubmissionProvider {
  VideoSubmissionProvider();

  Future<VideoSubmissionModel> submitVideo({
    required int memberId,
    required int parentVideoId,
    required File video,
  }) async {
    try {
      Uri apiUri = PathUtils.getApiUri('/public/ec/video-submission');
      Dio dio = Dio(BaseOptions(baseUrl: apiUri.origin));
      Map<String, dynamic> body = {
        "memberId": memberId,
        "parentVideoId": parentVideoId,
        "video": await MultipartFile.fromFile(video.path)
      };
      FormData formData = FormData.fromMap(body);
      final response = await dio.post(
        '/public/ec/video-submission',
        data: formData,
      );
      final responseData = response.data;
      if (!responseData['succeed'])
        throw Exception('Upload video submission failed');
      final payload = responseData['payload'];
      VideoSubmissionModel result = VideoSubmissionModel.fromJson(payload);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<VideoSubmissionModel>> getVideoSubmissionByMember({
    required int memberId,
    required int parentVideoId,
  }) async {
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      Uri apiUri = PathUtils.getApiUri(
          '/public/ec/video-submission/member/$memberId/video/$parentVideoId');
      final response = await http.get(apiUri, headers: headers);
      final payload = jsonDecode(response.body)['payload'];
      List<VideoSubmissionModel> result = payload
          .map<VideoSubmissionModel>((videoSubmission) =>
              VideoSubmissionModel.fromJson(videoSubmission))
          .toList();
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
