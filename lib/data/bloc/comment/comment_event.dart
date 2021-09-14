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
