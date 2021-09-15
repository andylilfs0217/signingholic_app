import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:singingholic_app/data/models/comment/comment_model.dart';
import 'package:singingholic_app/data/models/comment/video_comment_model.dart';
import 'package:singingholic_app/data/models/member/member.dart';
import 'package:singingholic_app/data/models/video/video.dart';
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
        throw Exception(e);
      }
    }
    if (event is SendVideoComment) {
      try {
        yield SendVideoCommentLoadingState(
            videoCommentList: state.videoCommentList);
        VideoCommentModel result = await this
            .commentRepository
            .createVideoComment(
                video: event.video,
                member: event.member,
                rating: event.rating,
                comment: event.comment,
                parentComment: event.parentComment);
        result.video = event.video;
        result.member = event.member;
        yield SendVideoCommentSuccessState(
            latestComment: result, videoCommentList: state.videoCommentList);
      } catch (e) {
        yield SendVideoCommentFailState(
            videoCommentList: state.videoCommentList);
        throw Exception(e);
      }
    }
  }
}
