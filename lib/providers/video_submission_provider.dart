import 'dart:io';
import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;
import 'package:singingholic_app/utils/path_utils.dart';

class VideoSubmissionProvider {
  VideoSubmissionProvider();

  Future<dynamic> submitVideo({
    required int memberId,
    required int parentVideoId,
    required File video,
  }) async {
    try {
      // Map<String, String> headers = {
      //   "Content-Type": "application/form-data",
      // };
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
        // headers: headers,
        data: formData,
      );
      final result = response;
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
