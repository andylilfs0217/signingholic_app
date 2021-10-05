import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:singingholic_app/assets/app_theme.dart';
import 'package:singingholic_app/data/bloc/comment/comment_bloc.dart';
import 'package:singingholic_app/data/models/comment/video_comment_model.dart';
import 'package:singingholic_app/data/models/member/member.dart';
import 'package:singingholic_app/data/models/video/video.dart';
import 'package:singingholic_app/widgets/app_circular_loading.dart';
import 'package:singingholic_app/widgets/app_dialog.dart';
import 'package:provider/provider.dart';

class VideoCommentDialog extends StatefulWidget {
  /// The video that the user is commenting
  final VideoModel video;

  /// The user who is commenting
  final MemberModel member;

  /// If not null, the user is replying another comment
  final VideoCommentModel? parentComment;

  const VideoCommentDialog(
      {Key? key, required this.video, required this.member, this.parentComment})
      : super(key: key);

  @override
  VideoCommentDialogState createState() => VideoCommentDialogState();
}

class VideoCommentDialogState extends State<VideoCommentDialog> {
  /// Rating of the video/comment
  num rating = 3;

  /// Comment controller
  TextEditingController _commentController = TextEditingController();

  /// Form key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return BlocConsumer<CommentBloc, CommentState>(
      listener: (context, state) {
        if (state is SendVideoCommentSuccessState) {
          Navigator.of(context).pop(1);
          Fluttertoast.showToast(
            msg: 'Sent comment successfully',
            textColor: Colors.white,
            backgroundColor: AppThemeColor.appPrimaryColor,
          );
        }
        if (state is SendVideoCommentFailState) {
          Fluttertoast.showToast(
            msg: 'Send comment failed',
          );
        }
      },
      builder: (context, state) {
        return AppDialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              if (state is SendVideoCommentLoadingState) AppCircularLoading(),
              if (state is! SendVideoCommentLoadingState) ...[
                if (widget.parentComment == null) ...[
                  _buildRating(),
                  Divider(endIndent: 0),
                ],
                _buildComment(),
              ]
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Close button
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close)),
        // Header title
        Text('Leave a comment'),
        // Send button
        IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate())
                context.read<CommentBloc>().add(SendVideoComment(
                    video: widget.video,
                    member: widget.member,
                    comment: _commentController.text,
                    rating: widget.parentComment == null ? rating : null,
                    parentComment: widget.parentComment));
            },
            icon: Icon(Icons.send, color: AppThemeColor.appPrimaryColor))
      ],
    );
  }

  Widget _buildRating() {
    return RatingBar.builder(
      itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
      onRatingUpdate: (rating) {
        this.rating = rating;
      },
      allowHalfRating: true,
      minRating: 1,
      maxRating: 5,
      itemCount: 5,
      initialRating: 3,
      unratedColor: Colors.amber.shade100,
      glowColor: Colors.amber.shade200,
    );
  }

  Widget _buildComment() {
    return Container(
      padding: EdgeInsets.all(AppThemeSize.screenPaddingSize),
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: _commentController,
          validator: (val) =>
              widget.parentComment != null && (val == null || val.isEmpty)
                  ? 'Comment must not be empty'
                  : null,
          keyboardType: TextInputType.multiline,
          maxLines: 10,
          autofocus: true,
          decoration: InputDecoration(
              hintText:
                  'Comment ${widget.parentComment == null ? "(Optional)" : ""}',
              border: InputBorder.none),
        ),
      ),
    );
  }
}
