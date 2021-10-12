part of 'video_list_bloc.dart';

@immutable
abstract class VideoListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class VideoListFetchEvent extends VideoListEvent {
  final String? search;
  final int? limit;
  final int? offset;
  final String? sort;
  final String? dir;
  final int? category;

  VideoListFetchEvent(
      {this.search,
      this.category,
      this.dir,
      this.limit,
      this.offset,
      this.sort})
      : super();
}
