part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  List<VideoCommentModel> videoCommentList;
  CommentState({required this.videoCommentList});

  @override
  List<Object> get props => [videoCommentList];
}

class CommentInitialState extends CommentState {
  CommentInitialState() : super(videoCommentList: []);
}

class GettingVideoCommentListState extends CommentState {
  GettingVideoCommentListState() : super(videoCommentList: []);
}

class GetVideoCommentListSuccessState extends CommentState {
  GetVideoCommentListSuccessState(
      {required List<VideoCommentModel> videoCommentList})
      : super(videoCommentList: videoCommentList);
}

class GetVideoCommentListFailState extends CommentState {
  GetVideoCommentListFailState() : super(videoCommentList: []);
}

class SendVideoCommentLoadingState extends CommentState {
  SendVideoCommentLoadingState(
      {required List<VideoCommentModel> videoCommentList})
      : super(videoCommentList: videoCommentList);
}

class SendVideoCommentSuccessState extends CommentState {
  /// Latest comment the user just sent
  final VideoCommentModel latestComment;

  SendVideoCommentSuccessState(
      {required this.latestComment,
      required List<VideoCommentModel> videoCommentList})
      : super(videoCommentList: videoCommentList) {
    if (latestComment.parentComment == null)
      videoCommentList.insert(0, latestComment);
    else {
      videoCommentList
          .firstWhere(
              (element) => element.id == latestComment.parentComment!.id)
          .childrenComments
          ?.insert(0, latestComment);
    }
  }
}

class SendVideoCommentFailState extends CommentState {
  SendVideoCommentFailState({required List<VideoCommentModel> videoCommentList})
      : super(videoCommentList: videoCommentList);
}
