import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:singingholic_app/data/models/video/video.dart';
import 'package:singingholic_app/data/repo/video_repository.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  /// Video repo
  final VideoRepository videoRepository;

  VideoBloc(this.videoRepository) : super(VideoInitialState());

  @override
  Stream<VideoState> mapEventToState(
    VideoEvent event,
  ) async* {
    if (event is FetchVideoEvent) {
      try {
        yield VideoInitialState();
        // TODO: fetch video
        VideoModel videoModel = await videoRepository.fetchVideo(id: event.id);
        yield VideoFetchSuccessState(videoModel);
      } catch (e) {
        yield VideoFetchFailState();
        throw Exception(e);
      }
    }
  }
}
