part of 'video_submission_bloc.dart';

abstract class VideoSubmissionEvent extends Equatable {
  const VideoSubmissionEvent();

  @override
  List<Object> get props => [];
}

class GetVideoSubmissionListEvent extends VideoSubmissionEvent {
  final MemberModel member;
  final VideoModel parentVideo;
  const GetVideoSubmissionListEvent(
      {required this.member, required this.parentVideo})
      : super();
}
