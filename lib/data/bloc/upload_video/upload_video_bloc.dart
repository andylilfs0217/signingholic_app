import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:singingholic_app/data/models/member/member.dart';
import 'package:singingholic_app/data/models/video/video.dart';
import 'package:singingholic_app/data/repo/video_submission_repository.dart';
import 'package:video_compress/video_compress.dart';

part 'upload_video_event.dart';
part 'upload_video_state.dart';

class UploadVideoBloc extends Bloc<UploadVideoEvent, UploadVideoState> {
  /// Video repo
  final VideoSubmissionRepository videoSubmissionRepository;
  UploadVideoBloc({required this.videoSubmissionRepository})
      : super(UploadVideoInitialState()) {
    on<UploadVideoToServerEvent>((event, emit) async {
      try {
        File? video = File(event.video.path);
        String path = video.path;
        // Compress video
        // emit(CompressingVideoState());
        // MediaInfo? mediaInfo = await VideoCompress.compressVideo(
        //   path,
        //   quality: VideoQuality.MediumQuality,
        //   deleteOrigin: false,
        //   includeAudio: true,
        //   frameRate: 24,
        // );
        // video = mediaInfo?.file;
        // if (video == null) throw Exception('Cannot compress video');
        // Upload video
        emit(UploadingVideoState());
        final uploadedVideo = await this.videoSubmissionRepository.submitVideo(
            memberId: event.member.id,
            parentVideoId: event.parentVideo.id,
            video: video);
        emit(UploadVideoSuccessState());
        // Allow users to upload video again
        await Future.delayed(Duration(seconds: 2));
        emit(UploadVideoInitialState());
      } catch (e) {
        emit(UploadVideoFailState());
        // Allow users to upload video again
        await Future.delayed(Duration(seconds: 2));
        emit(UploadVideoInitialState());
      }
    });
  }
}
