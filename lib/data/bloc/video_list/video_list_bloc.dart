import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:singingholic_app/data/models/video/video_list.dart';
import 'package:singingholic_app/data/repo/video_repository.dart';

part 'video_list_event.dart';
part 'video_list_state.dart';

class VideoListBloc extends Bloc<VideoListEvent, VideoListState> {
  VideoListBloc(this.videoRepository) : super(VideoListInitialState());

  final VideoRepository videoRepository;

  @override
  Stream<VideoListState> mapEventToState(
    VideoListEvent event,
  ) async* {
    if (event is VideoListFetchEvent) {
      try {
        yield VideoListInitialState();
        // Fetch Video list
        VideoListModel videoList = await videoRepository.fetchVideoList(
            search: event.search,
            limit: event.limit,
            offset: event.offset,
            sort: event.sort,
            dir: event.dir,
            category: event.category);
        if (videoList.count != 0 && videoList.results.length != 0) {
          // If video list is not empty
          yield VideoListFetchSuccessState(videoList);
        } else {
          // If video list is empty
          yield VideoListEmptyState(videoList);
        }
      } catch (e) {
        yield VideoListFetchFailedState();
        throw Exception(e);
      }
    }
  }
}
