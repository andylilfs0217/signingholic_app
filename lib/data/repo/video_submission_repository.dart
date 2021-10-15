import 'dart:io';

import 'package:singingholic_app/data/models/video/video_submission.dart';
import 'package:singingholic_app/providers/video_submission_provider.dart';

class VideoSubmissionRepository {
  final VideoSubmissionProvider videoSubmissionProvider;

  VideoSubmissionRepository({required this.videoSubmissionProvider});

  /// Fetch list of videos
  Future<VideoSubmissionModel> submitVideo({
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

  /// Get video submission list of a video by member
  Future<List<VideoSubmissionModel>> getVideoSubmissionByMember({
    required int memberId,
    required int parentVideoId,
  }) async {
    try {
      List<VideoSubmissionModel> result = await this
          .videoSubmissionProvider
          .getVideoSubmissionByMember(
              memberId: memberId, parentVideoId: parentVideoId);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
