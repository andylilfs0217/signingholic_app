import 'package:singingholic_app/data/models/video/video_formats.dart';
import 'package:singingholic_app/data/models/video/video.dart';

class VideoUtils {
  /// Check if the video is free.
  static bool isVideoFree(VideoModel videoModel) {
    return videoModel.free != null && videoModel.free!;
  }

  /// Check if the video is purchased by the member.
  static bool isVideoPurchased(
      VideoModel? videoModel, List<VideoFormatModel>? videoFormats) {
    return videoModel != null &&
        (isVideoFree(videoModel) ||
            (videoFormats != null && videoFormats.length > 0));
  }
}
