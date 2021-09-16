// import 'package:better_player/better_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:singingholic_app/assets/app_theme.dart';
import 'package:singingholic_app/widgets/app_circular_loading.dart';
import 'package:video_player/video_player.dart';

/// Build video playback area widget
class VideoPlayerContainer extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerContainer({Key? key, required this.videoUrl})
      : super(key: key);

  @override
  _VideoPlayerContainerState createState() => _VideoPlayerContainerState();
}

class _VideoPlayerContainerState extends State<VideoPlayerContainer>
    with AutomaticKeepAliveClientMixin {
  // Variables
  late VideoPlayerController videoController;
  ChewieController? chewieController;
  bool _isVisible = false;

  // late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();
    this.initializePlayer();
  }

  @override
  void dispose() {
    if (chewieController != null && !chewieController!.isFullScreen) {
      videoController.dispose();
      chewieController?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return chewieController != null &&
            chewieController!.videoPlayerController.value.isInitialized
        ? AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: Colors.black,
              child: Chewie(
                controller: chewieController!,
              ),
              // child: BetterPlayer(
              //   controller: _betterPlayerController,
              // ),
            ))
        : AppCircularLoading();
  }

  Future<void> initializePlayer() async {
    videoController = VideoPlayerController.network(
      // "https://ia801602.us.archive.org/11/items/Rick_Astley_Never_Gonna_Give_You_Up/Rick_Astley_Never_Gonna_Give_You_Up.mp4",
      widget.videoUrl,
    );
    await Future.wait([videoController.initialize()]);
    _createChewieController();
    setState(() {});

    // BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
    //     BetterPlayerDataSourceType.network, widget.videoUrl);
    // BetterPlayerConfiguration betterPlayerConfiguration =
    //     _createBetterPlayerConfiguration();
    // _betterPlayerController = BetterPlayerController(betterPlayerConfiguration,
    //     betterPlayerDataSource: betterPlayerDataSource);
  }

  // BetterPlayerConfiguration _createBetterPlayerConfiguration() {
  //   return BetterPlayerConfiguration(
  //       autoPlay: true, looping: true, fullScreenByDefault: false);
  // }

  void _createChewieController() {
    chewieController = ChewieController(
      videoPlayerController: videoController,
      autoPlay: true,
      looping: true,
      // deviceOrientationsOnEnterFullScreen: [DeviceOrientation.portraitUp],
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      materialProgressColors: ChewieProgressColors(
          playedColor: AppThemeColor.appPrimaryColor,
          bufferedColor: AppThemeColor.appPrimaryColor.withOpacity(0.3)),
    );

    // chewieController!.addListener(() {
    //   print('!chewieController!.isFullScreen');
    //   if (!chewieController!.isFullScreen) {
    //     Navigator.of(context).pop();
    //   }
    // });
  }

  @override
  bool get wantKeepAlive => _isVisible;
}
