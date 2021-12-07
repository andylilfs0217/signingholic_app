import 'package:flutter/material.dart';
import 'package:singingholic_app/data/models/video/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// Build video playback area widget
class VideoPlayerContainer extends StatefulWidget {
  final VideoModel videoModel;

  const VideoPlayerContainer({Key? key, required this.videoModel})
      : super(key: key);

  @override
  _VideoPlayerContainerState createState() => _VideoPlayerContainerState();
}

class _VideoPlayerContainerState extends State<VideoPlayerContainer> {
  // Variables
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
        initialVideoId: widget.videoModel.youTubeId!,
        flags: YoutubePlayerFlags(
          autoPlay: true,
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
        ),
        builder: (context, player) {
          return Column(
            children: [player],
          );
        });
  }
}
