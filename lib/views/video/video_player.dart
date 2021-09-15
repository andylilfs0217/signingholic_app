import 'package:chewie/chewie.dart';
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
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    // Get video for playback
    videoController = VideoPlayerController.network(
      widget.videoUrl,
    );
    initializeVideoPlayerFuture = videoController.initialize();
    chewieController = ChewieController(
        videoPlayerController: videoController,
        autoPlay: false,
        looping: false);
  }

  @override
  void dispose() {
    videoController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                  color: Colors.black,
                  child: Chewie(controller: chewieController)));
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
}
