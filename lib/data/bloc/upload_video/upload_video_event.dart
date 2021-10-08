part of 'upload_video_bloc.dart';

/// Upload video event
abstract class UploadVideoEvent extends Equatable {
  // The video file which is going to be uploaded
  final XFile video;

  const UploadVideoEvent({required this.video});

  @override
  List<Object> get props => [video];
}

class UploadVideoToServerEvent extends UploadVideoEvent {
  final XFile video;

  const UploadVideoToServerEvent({required this.video}) : super(video: video);
}
