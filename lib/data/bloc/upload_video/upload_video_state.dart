part of 'upload_video_bloc.dart';

abstract class UploadVideoState extends Equatable {
  const UploadVideoState();

  @override
  List<Object> get props => [];
}

class UploadVideoInitialState extends UploadVideoState {}

class CompressingVideoState extends UploadVideoState {}

class UploadingVideoState extends UploadVideoState {}

class UploadVideoSuccessState extends UploadVideoState {}

class UploadVideoFailState extends UploadVideoState {}
