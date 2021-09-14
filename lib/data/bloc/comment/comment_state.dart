part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentInitialState extends CommentState {}

class GettingVideoCommentListState extends CommentState {}

class GetVideoCommentListSuccessState extends CommentState {
  final List<VideoCommentModel> videoCommentList;

  const GetVideoCommentListSuccessState({required this.videoCommentList})
      : super();
}

class GetVideoCommentListFailState extends CommentState {}
