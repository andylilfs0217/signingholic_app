import 'package:singingholic_app/data/models/comment/comment_model.dart';
import 'package:singingholic_app/data/models/video/video.dart';

class VideoCommentModel extends CommentModel {
  VideoModel? video;
  VideoCommentModel? parentComment;
  List? childrenComments;

  VideoCommentModel(
      {required id,
      member,
      comment,
      this.video,
      this.parentComment,
      this.childrenComments,
      stars,
      createTime,
      updateTime})
      : super(
            id: id,
            member: member,
            comment: comment,
            stars: stars,
            createTime: createTime,
            updateTime: updateTime);

  VideoCommentModel.fromJson(Map<String, dynamic> json)
      : video =
            json['video'] != null ? VideoModel.fromJson(json['video']) : null,
        parentComment = json['parentComment'] != null
            ? VideoCommentModel.fromJson(json['parentComment'])
            : null,
        childrenComments = json['childrenComments']
            ?.map((e) => VideoCommentModel.fromJson(e))
            .toList(),
        super.fromJson(json);

  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'videoId': video?.toJson(),
        'parentComment': parentComment?.toJson(),
        'childrenComments': childrenComments?.map((e) => e.toJson()).toList()
      };
}
