import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:singingholic_app/data/models/video/video_formats.dart';

/// Build video playback area widget
class VideoPlayerContainer extends StatefulWidget {
  final List<VideoFormatModel> videoFormats;

  const VideoPlayerContainer({Key? key, required this.videoFormats})
      : super(key: key);

  @override
  _VideoPlayerContainerState createState() => _VideoPlayerContainerState();
}

class _VideoPlayerContainerState extends State<VideoPlayerContainer> {
  // Variables
  late BetterPlayerController _betterPlayerController;
  GlobalKey _betterPlayerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    this.initializePlayer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer(
        controller: _betterPlayerController,
        key: _betterPlayerKey,
      ),
    );
  }

  void initializePlayer() {
    // Better player data source configuration
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.videoFormats.last.url,
      resolutions: Map.fromIterable(widget.videoFormats,
          key: (e) => e.qualityLabel, value: (e) => e.url),
    );
    // Better player general configuration
    // TODO: Fix the bug that cannot enter full screen
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      autoPlay: true,
      looping: false,
      fullScreenByDefault: false,
      fit: BoxFit.contain,
      autoDispose: false,
      allowedScreenSleep: false,
      autoDetectFullscreenDeviceOrientation: true,
    );
    // Initialize Better player controller
    _betterPlayerController = BetterPlayerController(
      betterPlayerConfiguration,
      betterPlayerDataSource: betterPlayerDataSource,
    );
    _betterPlayerController.enablePictureInPicture(_betterPlayerKey);
  }
}
