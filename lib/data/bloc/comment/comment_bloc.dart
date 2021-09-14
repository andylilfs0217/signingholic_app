import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:singingholic_app/data/models/comment/video_comment_model.dart';
import 'package:singingholic_app/data/repo/comment_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository commentRepository;
  CommentBloc({required this.commentRepository}) : super(CommentInitialState());

  @override
  Stream<CommentState> mapEventToState(
    CommentEvent event,
  ) async* {
    if (event is GetVideoCommentsAndRepliesEvent) {
      try {
        yield GettingVideoCommentListState();
        List<VideoCommentModel> result = await this
            .commentRepository
            .getVideoCommentsAndReplies(videoId: event.videoId);
        yield GetVideoCommentListSuccessState(videoCommentList: result);
      } catch (e) {
        yield GetVideoCommentListFailState();
        throw e;
      }
    }
  }
}
