import 'package:singingholic_app/data/models/comment/video_comment_model.dart';
import 'package:singingholic_app/data/models/video/video.dart';
import 'package:singingholic_app/data/models/member/member.dart';
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

  Future<VideoCommentModel> createVideoComment(
      {required VideoModel video,
      required MemberModel member,
      num? rating,
      required String comment,
      VideoCommentModel? parentComment}) async {
    try {
      VideoCommentModel result = await this.commentProvider.createVideoComment(
          videoId: video.id,
          memberId: member.id,
          rating: rating,
          comment: comment,
          parentCommentId: parentComment?.id);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
