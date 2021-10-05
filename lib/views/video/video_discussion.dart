import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:singingholic_app/data/bloc/comment/comment_bloc.dart';
import 'package:singingholic_app/data/bloc/login/login_bloc.dart';
import 'package:singingholic_app/data/models/comment/video_comment_model.dart';
import 'package:singingholic_app/data/models/video/video.dart';
import 'package:singingholic_app/views/video/video_comment.dart';
import 'package:provider/provider.dart';
import 'package:singingholic_app/views/video/video_comment_dialog.dart';
import 'package:singingholic_app/widgets/app_circular_loading.dart';

/// Video Description body
class VideoDiscussion extends StatefulWidget {
  /// Video ID that all the discussions belong to
  final VideoModel video;

  /// If true, the video is purchased
  final bool isPurchased;

  /// Create Video discussion body
  const VideoDiscussion(
      {Key? key, required this.video, this.isPurchased = false})
      : super(key: key);

  @override
  _VideoDiscussionState createState() => _VideoDiscussionState();
}

class _VideoDiscussionState extends State<VideoDiscussion>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context
        .read<CommentBloc>()
        .add(GetVideoCommentsAndRepliesEvent(videoId: widget.video.id));
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        if (state is GettingVideoCommentListState) {
          return AppCircularLoading();
        } else if (state is GetVideoCommentListFailState) {
          return _buildCommentUnavailable();
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildCommentTextField(),
                state.videoCommentList.isEmpty
                    ? _buildNoCommentsHint()
                    : _buildComments(state.videoCommentList),
              ],
            ),
          );
        }
      },
    );
  }

  /// A TextField which allows users to submit their comment
  Widget _buildCommentTextField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextButton.icon(
            onPressed: state is LoginSuccessState && widget.isPurchased
                ? () {
                    showDialog(
                        context: context,
                        builder: (_) => VideoCommentDialog(
                            video: widget.video, member: state.memberModel));
                  }
                : null,
            icon: Icon(Icons.add_comment),
            label: Text(state is! LoginSuccessState
                ? 'Log in to leave a comment'
                : !widget.isPurchased
                    ? 'Purchase the video to leave a comment'
                    : 'Leave a comment'));
      },
    );
  }

  /// Create a list of comments of the video
  Widget _buildComments(List<VideoCommentModel> videoCommentList) {
    return Column(
      children:
          videoCommentList.map((e) => VideoComment(videoComment: e)).toList(),
    );
  }

  /// Create a text hint if there is no any comments in the video
  Widget _buildNoCommentsHint() {
    return Center(
      child: Text(
          'There is no comments yet. Be the first to join the discussion!'),
    );
  }

  /// A message to show that the discussion session is currently unavailable
  Widget _buildCommentUnavailable() {
    return Center(
      child: Text(
          'Comment function is currently unavailable. Please come back later'),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
