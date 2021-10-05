import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:singingholic_app/data/models/video/video.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:singingholic_app/widgets/app_dialog.dart';

enum UploadStatus {
  NOT_UPLOADED,
  COMPRESSING,
  UPLOADING,
  UPLOADED,
}

class AppVideoSelect extends StatefulWidget {
  final VideoModel parentVideo;
  const AppVideoSelect({Key? key, required this.parentVideo}) : super(key: key);

  @override
  State<AppVideoSelect> createState() => _AppVideoSelectState();
}

class _AppVideoSelectState extends State<AppVideoSelect> {
  final ImagePicker _picker = ImagePicker();
  XFile? video;
  UploadStatus _uploadStatus = UploadStatus.NOT_UPLOADED;
  num _compressPercentage = 0;
  num _uploadPercentage = 0;

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
                _buildProgress(),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _uploadStatus = UploadStatus.COMPRESSING;
                  });
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

  Widget _buildProgressBar(num value) {
    return LinearPercentIndicator(
      width: 200,
      animation: true,
      lineHeight: 20.0,
      // animationDuration: 2500,
      percent: 0.8,
      center: Text("80.0%"),
      linearStrokeCap: LinearStrokeCap.roundAll,
      progressColor: Colors.green,
    );
  }

  Widget _buildUploadFinishText() {
    return Text('Uploaded video');
  }

  Widget _buildUploadingText() {
    return Text('Uploading video...');
  }

  Widget _buildCompressingText() {
    return Text('Compressing video...');
  }

  Widget _buildProgress() {
    if (_uploadStatus == UploadStatus.NOT_UPLOADED) {
      return Container();
    } else if (_uploadStatus == UploadStatus.COMPRESSING) {
      return Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          _buildProgressBar(_compressPercentage),
          _buildCompressingText()
        ],
      );
    } else if (_uploadStatus == UploadStatus.UPLOADING) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [_buildProgressBar(_uploadPercentage), _buildUploadingText()],
      );
    } else {
      return _buildUploadFinishText();
    }
  }
}
