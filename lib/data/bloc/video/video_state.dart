part of 'video_bloc.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoInitialState extends VideoState {}

class VideoFetchSuccessState extends VideoState {
  final VideoModel videoModel;
  final List<VideoFormatModel>? videoFormatModel;
  VideoFetchSuccessState(this.videoModel, this.videoFormatModel);
}

class VideoFetchFailState extends VideoState {}
