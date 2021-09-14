import 'package:singingholic_app/data/models/comment/comment_model.dart';
import 'package:singingholic_app/data/models/video/video.dart';

class VideoCommentModel extends CommentModel {
  VideoModel video;
  covariant VideoCommentModel? parentComment;
  List? childrenComments;

  VideoCommentModel(
      {required id,
      required member,
      required comment,
      required this.video,
      this.parentComment,
      this.childrenComments,
      stars,
      required createTime,
      required updateTime})
      : super(
            id: id,
            member: member,
            comment: comment,
            stars: stars,
            createTime: createTime,
            updateTime: updateTime);

  VideoCommentModel.fromJson(Map<String, dynamic> json)
      : video = VideoModel.fromJson(json['video']),
        parentComment = json['parentComment'] != null
            ? VideoCommentModel.fromJson(json['parentComment'])
            : null,
        childrenComments = json['childrenComments']
            ?.map((e) => VideoCommentModel.fromJson(e))
            .toList(),
        super.fromJson(json);

  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'videoId': video.toJson(),
        'parentComment': parentComment?.toJson(),
        'childrenComments': childrenComments?.map((e) => e.toJson()).toList()
      };
}
