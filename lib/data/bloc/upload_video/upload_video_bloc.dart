import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

part 'upload_video_event.dart';
part 'upload_video_state.dart';

class UploadVideoBloc extends Bloc<UploadVideoEvent, UploadVideoState> {
  UploadVideoBloc() : super(UploadVideoInitialState()) {
    on<UploadVideoToServerEvent>((event, emit) async {
      try {
        XFile video = event.video;
        String path = video.path;
        // Compress video
        emit(CompressingVideoState());
        MediaInfo? mediaInfo = await VideoCompress.compressVideo(
          path,
          quality: VideoQuality.MediumQuality,
          deleteOrigin: false,
          includeAudio: true,
          frameRate: 24,
        );
        File? compressedFile = mediaInfo?.file;
        emit(UploadingVideoState());
        // TODO: Upload video
        await Future.delayed(Duration(seconds: 2));
        emit(UploadVideoSuccessState());
        // TODO: Allow users to upload video again
        await Future.delayed(Duration(seconds: 2));
        emit(UploadVideoInitialState());
      } catch (e) {
        emit(UploadVideoFailState());
        // TODO: Allow users to upload video again
        await Future.delayed(Duration(seconds: 2));
        emit(UploadVideoInitialState());
      }
    });
  }
}
