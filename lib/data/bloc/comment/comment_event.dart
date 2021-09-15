part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class GetVideoCommentsAndRepliesEvent extends CommentEvent {
  final int videoId;

  const GetVideoCommentsAndRepliesEvent({required this.videoId}) : super();
}

/// And event that will be triggered when leaving a comment to a video
class SendVideoComment extends CommentEvent {
  final VideoModel video;
  final MemberModel member;
  final String comment;
  final num rating;
  final VideoCommentModel? parentComment;

  const SendVideoComment(
      {required this.video,
      required this.member,
      required this.comment,
      required this.rating,
      this.parentComment})
      : super();
}
