import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:singingholic_app/data/bloc/upload_video/upload_video_bloc.dart';
import 'package:singingholic_app/data/models/video/video.dart';
import 'package:singingholic_app/data/bloc/login/login_bloc.dart';
import 'package:singingholic_app/widgets/app_video_select.dart';
import 'package:video_compress/video_compress.dart';

class VideoSubmission extends StatefulWidget {
  final VideoModel video;
  final bool isPurchased;

  const VideoSubmission({
    Key? key,
    required this.video,
    required this.isPurchased,
  }) : super(key: key);

  @override
  _VideoSubmissionState createState() => _VideoSubmissionState();
}

class _VideoSubmissionState extends State<VideoSubmission>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadVideoBloc, UploadVideoState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              state is UploadVideoInitialState
                  ? _buildSubmitButton()
                  : _buildSubmitProgress(),
              true ? _buildNoSubmissionHint() : _buildSubmissionList(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSubmissionList() {
    return Column();
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextButton.icon(
            onPressed: state is LoginSuccessState && widget.isPurchased
                ? () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return AppVideoSelect(
                              member: state.memberModel,
                              parentVideo: widget.video);
                        });
                  }
                : null,
            icon: Icon(Icons.video_call),
            label: Text(state is! LoginSuccessState
                ? 'Log in to submit your video'
                : !widget.isPurchased
                    ? 'Purchase the video to submit your video'
                    : 'Submit your video'));
      },
    );
  }

  Widget _buildNoSubmissionHint() {
    return Text('You don\'t have any submission.');
  }

  Widget _buildSubmitProgress() {
    return BlocConsumer<UploadVideoBloc, UploadVideoState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is CompressingVideoState) {
          return Column(
            children: [Text('Compressing video'), LinearProgressIndicator()],
          );
        } else if (state is UploadingVideoState) {
          return Column(
            children: [Text('Uploading video'), LinearProgressIndicator()],
          );
        } else if (state is UploadVideoSuccessState) {
          return Text('Upload success');
        } else if (state is UploadVideoFailState) {
          return Text('Upload failed');
        } else {
          return Container();
        }
      },
    );
  }
}
