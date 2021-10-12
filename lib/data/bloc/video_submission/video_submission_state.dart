part of 'video_submission_bloc.dart';

abstract class VideoSubmissionState extends Equatable {
  final List<VideoSubmissionModel> videoSubmissionList;
  const VideoSubmissionState({required this.videoSubmissionList});

  @override
  List<Object> get props => [videoSubmissionList];
}

class VideoSubmissionInitialState extends VideoSubmissionState {
  VideoSubmissionInitialState() : super(videoSubmissionList: []);
}

class GettingVideoSubmissionState extends VideoSubmissionState {
  GettingVideoSubmissionState() : super(videoSubmissionList: []);
}

class GetVideoSubmissionSuccessState extends VideoSubmissionState {
  final List<VideoSubmissionModel> videoSubmissionList;
  GetVideoSubmissionSuccessState({required this.videoSubmissionList})
      : super(videoSubmissionList: videoSubmissionList);
}

class GetVideoSubmissionFailState extends VideoSubmissionState {
  GetVideoSubmissionFailState() : super(videoSubmissionList: []);
}
