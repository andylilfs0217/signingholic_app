import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'upload_video_event.dart';
part 'upload_video_state.dart';

class UploadVideoBloc extends Bloc<UploadVideoEvent, UploadVideoState> {
  UploadVideoBloc() : super(UploadVideoInitialState()) {
    on<UploadVideoEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
