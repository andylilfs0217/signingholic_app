part of 'video_list_bloc.dart';

@immutable
abstract class VideoListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class VideoListFetchEvent extends VideoListEvent {}
