import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:singingholic_app/data/models/member/member.dart';
import 'package:singingholic_app/data/models/video/video.dart';
import 'package:singingholic_app/data/models/video/video_submission.dart';
import 'package:singingholic_app/data/repo/video_submission_repository.dart';

part 'video_submission_event.dart';
part 'video_submission_state.dart';

class VideoSubmissionBloc
    extends Bloc<VideoSubmissionEvent, VideoSubmissionState> {
  final VideoSubmissionRepository videoSubmissionRepository;
  VideoSubmissionBloc({required this.videoSubmissionRepository})
      : super(VideoSubmissionInitialState()) {
    on<GetVideoSubmissionListEvent>((event, emit) async {
      try {
        emit(VideoSubmissionInitialState());
        emit(GettingVideoSubmissionState());
        List<VideoSubmissionModel> videoSubmissionList = await this
            .videoSubmissionRepository
            .getVideoSubmissionByMember(
                memberId: event.member.id, parentVideoId: event.parentVideo.id);
        emit(GetVideoSubmissionSuccessState(
            videoSubmissionList: videoSubmissionList));
      } catch (e) {
        emit(GetVideoSubmissionFailState());
      }
    });
  }
}
