import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:singingholic_app/data/bloc/upload_video/upload_video_bloc.dart';
import 'package:singingholic_app/data/models/member/member.dart';
import 'package:singingholic_app/data/models/video/video.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AppVideoSelect extends StatefulWidget {
  final VideoModel parentVideo;
  final MemberModel member;
  const AppVideoSelect(
      {Key? key, required this.member, required this.parentVideo})
      : super(key: key);

  @override
  State<AppVideoSelect> createState() => _AppVideoSelectState();
}

class _AppVideoSelectState extends State<AppVideoSelect> {
  final ImagePicker _picker = ImagePicker();
  XFile? video;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        _captureVideo(),
        _selectVideo(),
      ],
    );
  }

  Widget _captureVideo() {
    return ListTile(
      leading: Icon(Icons.file_upload),
      title: Text('Capture video'),
      onTap: () async {
        video = await _picker.pickVideo(source: ImageSource.camera);
        if (video != null) {
          Navigator.pop(context);
          _showConfirmation(video!);
        }
      },
    );
  }

  Widget _selectVideo() {
    return ListTile(
      leading: Icon(Icons.perm_media),
      title: Text('Select video'),
      onTap: () async {
        video = await _picker.pickVideo(source: ImageSource.gallery);
        if (video != null) {
          _showConfirmation(video!);
        }
      },
    );
  }

  Future<void> _showConfirmation(XFile video) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Upload Video'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildVideoPlayer(video: video),
                _buildAlertText(),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  context.read<UploadVideoBloc>().add(UploadVideoToServerEvent(
                      member: widget.member,
                      parentVideo: widget.parentVideo,
                      video: video));
                  Navigator.pop(context, 'Upload');
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  Widget _buildVideoPlayer({required XFile video}) {
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.file,
      video.path,
    );
    // Better player control configuration
    BetterPlayerControlsConfiguration betterPlayerControlsConfiguration =
        BetterPlayerControlsConfiguration(enableFullscreen: false);
    // Better player general configuration
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      autoPlay: false,
      looping: false,
      fullScreenByDefault: false,
      fit: BoxFit.contain,
      autoDispose: false,
      allowedScreenSleep: false,
      autoDetectFullscreenDeviceOrientation: true,
      controlsConfiguration: betterPlayerControlsConfiguration,
    );
    // Initialize Better player controller
    BetterPlayerController _betterPlayerController = BetterPlayerController(
      betterPlayerConfiguration,
      betterPlayerDataSource: betterPlayerDataSource,
    );
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer(
        controller: _betterPlayerController,
      ),
    );
  }

  Widget _buildAlertText() {
    return Text('Do you want to upload this video?');
  }
}
