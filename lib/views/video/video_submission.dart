import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:singingholic_app/data/bloc/upload_video/upload_video_bloc.dart';
import 'package:singingholic_app/data/bloc/video_submission/video_submission_bloc.dart';
import 'package:singingholic_app/data/models/member/member.dart';
import 'package:singingholic_app/data/models/video/video.dart';
import 'package:singingholic_app/data/bloc/login/login_bloc.dart';
import 'package:singingholic_app/routes/app_arguments.dart';
import 'package:singingholic_app/routes/app_router.dart';
import 'package:singingholic_app/utils/app_navigator.dart';
import 'package:singingholic_app/widgets/app_circular_loading.dart';
import 'package:singingholic_app/widgets/app_video_select.dart';

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
              _buildSubmissionList(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSubmissionList() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginSuccessState) {
          MemberModel member = state.memberModel;
          context.read<VideoSubmissionBloc>().add(GetVideoSubmissionListEvent(
              member: member, parentVideo: widget.video));
          return BlocBuilder<VideoSubmissionBloc, VideoSubmissionState>(
            builder: (context, state) {
              if (state is GettingVideoSubmissionState)
                return AppCircularLoading();
              else if (state.videoSubmissionList.isNotEmpty) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: state.videoSubmissionList
                      .map((e) => _buildSubmissionItem(
                          member: e.member,
                          videoName: e.videoName,
                          time: e.updateTime))
                      .toList(),
                );
              } else {
                return _buildNoSubmissionHint();
              }
            },
          );
        } else {
          return _buildNoSubmissionHint();
        }
      },
    );
  }

  Widget _buildSubmissionItem(
      {required MemberModel member,
      required String videoName,
      required DateTime time}) {
    return InkWell(
      onTap: () {
        AppNavigator.goTo(context, AppRoute.VIDEO_SUBMISSION,
            args:
                VideoSubmissionArguments(fileName: videoName, member: member));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Member name
            Text(member.name ?? 'Submission'),
            // Submission Date
            Text(DateFormat('yyyy-MM-dd kk:mm').format(time)),
          ],
        ),
      ),
    );
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
