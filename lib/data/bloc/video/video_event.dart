part of 'video_bloc.dart';

abstract class VideoEvent extends Equatable {
  /// Video ID
  final int id;
  const VideoEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class FetchVideoEvent extends VideoEvent {
  /// Member ID
  final int? memberId;
  FetchVideoEvent({required id, this.memberId}) : super(id: id);
}
