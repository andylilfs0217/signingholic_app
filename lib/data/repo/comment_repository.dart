import 'package:singingholic_app/data/models/comment/video_comment_model.dart';
import 'package:singingholic_app/providers/comment_provider.dart';

class CommentRepository {
  final CommentProvider commentProvider;

  CommentRepository({required this.commentProvider});

  Future<List<VideoCommentModel>> getVideoCommentsAndReplies(
      {required int videoId}) async {
    try {
      List<VideoCommentModel> result =
          await this.commentProvider.getVideoCommentsAndReplies(videoId);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
