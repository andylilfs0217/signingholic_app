import 'package:flutter/material.dart';
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

class _VideoPlayerContainerState extends State<VideoPlayerContainer> {
  // Variables
  late VideoPlayerController videoController;
  late Future<void> initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    // Get video for playback
    videoController = VideoPlayerController.network(
      widget.videoUrl,
    );
    initializeVideoPlayerFuture = videoController.initialize();
    videoController.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the VideoPlayerController has finished initialization, use
          // the data it provides to limit the aspect ratio of the video.
          return Column(
            children: [
              AspectRatio(
                aspectRatio: videoController.value.aspectRatio,
                child: Stack(children: [
                  VideoPlayer(videoController),
                  // ClosedCaption(text: videoController.value.caption.text),
                  ControlsOverlay(controller: videoController),
                ]),
              ),
              VideoProgressIndicator(
                videoController,
                allowScrubbing: true,
                padding: EdgeInsets.all(0),
              ),
            ],
          );
        } else {
          // If the VideoPlayerController is still initializing, show a
          // loading spinner.
          return const Center(
            child: AppCircularLoading(),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
  }
}

/// Controls Overlay (Play button)
class ControlsOverlay extends StatefulWidget {
  final VideoPlayerController controller;
  const ControlsOverlay({Key? key, required this.controller}) : super(key: key);

  @override
  _ControlsOverlayState createState() => _ControlsOverlayState();
}

class _ControlsOverlayState extends State<ControlsOverlay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: widget.controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 70.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              widget.controller.value.isPlaying
                  ? widget.controller.pause()
                  : widget.controller.play();
            });
          },
        ),
      ],
    );
  }
}
