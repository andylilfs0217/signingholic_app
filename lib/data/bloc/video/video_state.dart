part of 'video_bloc.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoInitialState extends VideoState {}

class VideoFetchSuccessState extends VideoState {
  final VideoModel videoModel;
  VideoFetchSuccessState(this.videoModel);
}

class VideoFetchFailState extends VideoState {}
