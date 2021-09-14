import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:singingholic_app/data/bloc/comment/comment_bloc.dart';
import 'package:singingholic_app/data/models/comment/video_comment_model.dart';
import 'package:singingholic_app/views/video/video_comment.dart';
import 'package:provider/provider.dart';
import 'package:singingholic_app/widgets/app_circular_loading.dart';

/// Video Description body
class VideoDiscussion extends StatefulWidget {
  /// Video ID that all the discussions belong to
  final int videoId;

  /// Create Video discussion body
  const VideoDiscussion({Key? key, required this.videoId}) : super(key: key);

  @override
  _VideoDiscussionState createState() => _VideoDiscussionState();
}

class _VideoDiscussionState extends State<VideoDiscussion>
    with AutomaticKeepAliveClientMixin {
  /// The controller of the comment TextField
  TextEditingController? _commentTextFieldController;

  @override
  void initState() {
    super.initState();
    context
        .read<CommentBloc>()
        .add(GetVideoCommentsAndRepliesEvent(videoId: widget.videoId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        /// An indicator that shows if there is no comments in this video
        bool isNoComments = state is GetVideoCommentListSuccessState &&
                state.videoCommentList.length > 0
            ? false
            : true;

        if (state is GettingVideoCommentListState) {
          return AppCircularLoading();
        } else if (state is GetVideoCommentListSuccessState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildCommentTextField(),
                isNoComments
                    ? _buildNoCommentsHint()
                    : _buildComments(state.videoCommentList),
              ],
            ),
          );
        } else {
          return _buildCommentUnavailable();
        }
      },
    );
  }

  /// A TextField which allows users to submit their comment
  Widget _buildCommentTextField() {
    return TextField(
      controller: _commentTextFieldController,
      decoration: InputDecoration(
        hintText: 'Leave a comment of this video...',
        suffixIcon: IconButton(
            onPressed: () {
              print('sent comment');
            },
            icon: Icon(Icons.send)),
      ),
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

  Widget _buildCommentUnavailable() {
    return Center(
      child: Text(
          'Comment function is currently unavailable. Please come back later'),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
