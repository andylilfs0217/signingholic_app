part of 'video_list_bloc.dart';

@immutable
abstract class VideoListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class VideoListFetchEvent extends VideoListEvent {
  String? search;
  int? limit;
  int? offset;
  String? sort;
  String? dir;
  int? category;

  VideoListFetchEvent(
      {this.search,
      this.category,
      this.dir,
      this.limit,
      this.offset,
      this.sort})
      : super();
}
