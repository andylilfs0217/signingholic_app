import 'dart:io';

import 'package:singingholic_app/providers/video_submission_provider.dart';

class VideoSubmissionRepository {
  final VideoSubmissionProvider videoSubmissionProvider;

  VideoSubmissionRepository({required this.videoSubmissionProvider});

  /// Fetch list of videos
  Future<dynamic> submitVideo({
    required int memberId,
    required int parentVideoId,
    required File video,
  }) async {
    try {
      final result = this.videoSubmissionProvider.submitVideo(
          memberId: memberId, parentVideoId: parentVideoId, video: video);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
