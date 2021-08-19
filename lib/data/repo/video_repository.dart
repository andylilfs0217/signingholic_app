import 'package:singingholic_app/data/models/video/video.dart';
import 'package:singingholic_app/data/models/video/video_formats.dart';
import 'package:singingholic_app/data/models/video/video_list.dart';
import 'package:singingholic_app/providers/video_provider.dart';

class VideoRepository {
  final VideoProvider videoProvider;

  VideoRepository({required this.videoProvider});

  /// Fetch list of videos
  Future<VideoListModel> fetchVideoList() async {
    try {
      final VideoListModel videoListModel =
          await this.videoProvider.fetchVideoList();
      return videoListModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Fetch a specific video
  Future<VideoModel> fetchVideo({required int id}) async {
    try {
      final VideoModel videoModel = await this.videoProvider.fetchVideo(id: id);
      return videoModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Fetch formats of a specific video
  Future<List<VideoFormatModel>?> fetchVideoFormats({required int id}) async {
    try {
      final List<VideoFormatModel>? videoFormat =
          await this.videoProvider.fetchVideoFormats(id: id);
      return videoFormat;
    } catch (e) {
      throw Exception(e);
    }
  }
}
