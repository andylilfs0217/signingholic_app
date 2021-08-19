part of 'video_list_bloc.dart';

@immutable
abstract class VideoListState extends Equatable {
  @override
  List<Object> get props => [];
}

class VideoListInitialState extends VideoListState {}

class VideoListFetchSuccessState extends VideoListState {
  final VideoListModel videoList;
  VideoListFetchSuccessState(this.videoList);
}

class VideoListEmptyState extends VideoListState {
  final VideoListModel videoList;
  VideoListEmptyState(this.videoList);
}

class VideoListFetchFailedState extends VideoListState {}
