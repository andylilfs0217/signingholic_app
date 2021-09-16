import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:singingholic_app/assets/app_theme.dart';
import 'package:singingholic_app/data/bloc/login/login_bloc.dart';
import 'package:singingholic_app/data/models/comment/video_comment_model.dart';
import 'package:singingholic_app/data/models/video/video.dart';
import 'package:singingholic_app/views/video/video_comment.dart';
import 'package:singingholic_app/views/video/video_comment_dialog.dart';

class VideoCommentReplies extends StatefulWidget {
  /// If true, the video is purchased
  final bool isPurchased;

  /// Video model
  final VideoModel video;

  /// Parent comment
  final VideoCommentModel parentComment;

  const VideoCommentReplies(
      {Key? key,
      this.isPurchased = true,
      required this.video,
      required this.parentComment})
      : super(key: key);

  @override
  _VideoCommentRepliesState createState() => _VideoCommentRepliesState();
}

class _VideoCommentRepliesState extends State<VideoCommentReplies> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(),
        _buildAddReply(),
        _buildReplies(),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerRight,
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.close),
      ),
    );
  }

  Widget _buildAddReply() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Container(
        width: double.infinity,
        child: TextButton.icon(
            onPressed: state is LoginSuccessState && widget.isPurchased
                ? () {
                    showDialog(
                        context: context,
                        builder: (_) => VideoCommentDialog(
                              video: widget.video,
                              member: state.memberModel,
                              parentComment: widget.parentComment,
                            ));
                  }
                : null,
            icon: Icon(Icons.add_comment),
            label: Text(state is! LoginSuccessState
                ? 'Log in to leave a comment'
                : !widget.isPurchased
                    ? 'Purchase the video to leave a comment'
                    : 'Leave a comment')),
      );
    });
  }

  Widget _buildReplies() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: AppThemeSize.defaultItemHorizontalPaddingSize),
      child: SingleChildScrollView(
        child: Column(
          children: widget.parentComment.childrenComments!
              .map((e) => VideoComment(
                    videoComment: e,
                    allowReply: false,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
