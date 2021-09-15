import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:singingholic_app/data/bloc/login/login_bloc.dart';
import 'package:singingholic_app/data/models/comment/video_comment_model.dart';
import 'package:singingholic_app/views/video/video_comment_dialog.dart';
import 'package:singingholic_app/views/video/video_comment_replies.dart';

/// The like and dislike status of the user
enum LikeStatus { LIKE, DISLIKE, NONE }

/// A single comment widget
class VideoComment extends StatefulWidget {
  /// Details of the comment
  final VideoCommentModel videoComment;

  /// If true, replies to the comment is allowed and reply button will be shown
  final bool allowReply;

  /// Create a single comment widget
  const VideoComment(
      {Key? key, required this.videoComment, this.allowReply = true})
      : super(key: key);

  @override
  _VideoCommentState createState() => _VideoCommentState();
}

class _VideoCommentState extends State<VideoComment> {
  /// User's current like status
  LikeStatus _likeStatus = LikeStatus.NONE;

  /// The number of replies of the comment
  late int _numOfReplies;

  @override
  void initState() {
    super.initState();
    _numOfReplies = widget.videoComment.childrenComments?.length ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCommentHeader(),
          _buildCommentRating(),
          if (widget.videoComment.comment != null &&
              widget.videoComment.comment!.isNotEmpty)
            _buildCommentText(),
          _buildCommentLikes(),
          if (_numOfReplies > 0 && widget.allowReply) _buildCommentReplies(),
        ],
      ),
    );
  }

  /// The header of a comment (contains the name who published the comment and the date on publish)
  Widget _buildCommentHeader() {
    return RichText(
        text: TextSpan(
            text: widget.videoComment.member?.name ?? 'Unknown',
            style: Theme.of(context).textTheme.subtitle2,
            children: [
          TextSpan(text: ' - '),
          TextSpan(
              text: _buildNowAndTimeDifference(
                  widget.videoComment.updateTime ?? DateTime.now())),
        ]));
  }

  /// The rating of the video by the user (5 stars in total)
  Widget _buildCommentRating() {
    return RatingBarIndicator(
      rating: widget.videoComment.stars?.toDouble() ?? 0,
      itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber),
      itemCount: 5,
      itemSize: 20,
      unratedColor: Colors.amber.shade100,
    );
  }

  /// The comment of the user
  Widget _buildCommentText() {
    return Text(widget.videoComment.comment!);
  }

  /// Button row for likes, dislikes and replies
  Widget _buildCommentLikes() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Row(
          children: [
            // Like button
            TextButton.icon(
                onPressed: () {
                  setState(() {
                    _likeStatus = _likeStatus == LikeStatus.LIKE
                        ? LikeStatus.NONE
                        : LikeStatus.LIKE;
                  });
                },
                icon: Icon(_likeStatus == LikeStatus.LIKE
                    ? Icons.thumb_up
                    : Icons.thumb_up_outlined),
                label: Text('0')),
            // Dislike button
            TextButton.icon(
                onPressed: () {
                  setState(() {
                    _likeStatus = _likeStatus == LikeStatus.DISLIKE
                        ? LikeStatus.NONE
                        : LikeStatus.DISLIKE;
                  });
                },
                icon: Icon(_likeStatus == LikeStatus.DISLIKE
                    ? Icons.thumb_down
                    : Icons.thumb_down_alt_outlined),
                label: Text('0')),
            // Reply button
            if (widget.allowReply)
              TextButton.icon(
                  onPressed: state is LoginSuccessState
                      ? () {
                          showDialog(
                              context: context,
                              builder: (_) => VideoCommentDialog(
                                    video: widget.videoComment.video!,
                                    member: widget.videoComment.member!,
                                    parentComment: widget.videoComment,
                                  )).then((value) {
                            setState(() {
                              if (value != null) _numOfReplies += value as int;
                            });
                          });
                        }
                      : null,
                  icon: Icon(Icons.reply),
                  label:
                      Text(_numOfReplies > 0 ? _numOfReplies.toString() : '')),
          ],
        );
      },
    );
  }

  /// Button which will pop up all the replies of the comment
  Widget _buildCommentReplies() {
    return TextButton(
        onPressed: () {
          showMaterialModalBottomSheet(
            context: context,
            builder: (context) =>
                VideoCommentReplies(video: widget.videoComment.video!),
          );
        },
        child: Text('SHOW $_numOfReplies REPLIES'));
  }

  /// Get the difference between now and the given time, and return a formatted string.
  String _buildNowAndTimeDifference(DateTime updateTime) {
    Duration diff = DateTime.now().difference(updateTime);
    String diffString = '';

    if (diff.inSeconds < 60)
      diffString = '${diff.inSeconds} seconds ago';
    else if (diff.inMinutes < 60)
      diffString = '${diff.inMinutes} minutes ago';
    else if (diff.inHours < 60)
      diffString = '${diff.inHours} hours ago';
    else if (diff.inDays < 60) diffString = '${diff.inDays} days ago';

    return diffString;
  }
}
