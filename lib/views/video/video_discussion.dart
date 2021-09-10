import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:singingholic_app/views/video/video_comment.dart';

/// Video Description body
class VideoDiscussion extends StatefulWidget {
  /// Video ID that all the discussions belong to
  final num videoId;

  /// Create Video discussion body
  const VideoDiscussion({Key? key, required this.videoId}) : super(key: key);

  @override
  _VideoDiscussionState createState() => _VideoDiscussionState();
}

class _VideoDiscussionState extends State<VideoDiscussion> {
  /// The controller of the comment TextField
  TextEditingController? _commentTextFieldController;

  @override
  Widget build(BuildContext context) {
    /// An indicator that shows if there is no comments in this video
    // TODO: change this variable dynamically
    bool isNoComments = false;

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildCommentTextField(),
          isNoComments ? _buildNoCommentsHint() : _buildComments(),
        ],
      ),
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
  Widget _buildComments() {
    return Column(
      children: [
        VideoComment(),
        VideoComment(),
        VideoComment(),
        VideoComment(),
      ],
    );
  }

  /// Create a text hint if there is no any comments in the video
  Widget _buildNoCommentsHint() {
    return Center(
      child: Text(
          'There is no comments yet. Be the first to join the discussion!'),
    );
  }
}
