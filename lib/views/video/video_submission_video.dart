import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:singingholic_app/data/models/member/member.dart';
import 'package:singingholic_app/data/models/video/video.dart';
import 'package:singingholic_app/utils/path_utils.dart';
import 'package:singingholic_app/widgets/app_appBar.dart';

class VideoSubmissionVideoPage extends StatefulWidget {
  final String fileName;
  final MemberModel member;
  final VideoModel parentVideo;
  const VideoSubmissionVideoPage({
    Key? key,
    required this.member,
    required this.fileName,
    required this.parentVideo,
  }) : super(key: key);

  @override
  _VideoSubmissionVideoPageState createState() =>
      _VideoSubmissionVideoPageState();
}

class _VideoSubmissionVideoPageState extends State<VideoSubmissionVideoPage> {
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
    return Scaffold(
      appBar: AppAppBar(
        appBar: AppBar(),
        hasCart: false,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer(
        controller: _betterPlayerController,
        key: _betterPlayerKey,
      ),
    );
  }

  void initializePlayer() {
    // Video path
    String path = PathUtils.getVideoSubmissionPath(
      int.parse(dotenv.get('ACCOUNT_ID')),
      widget.member.id,
      widget.parentVideo.id,
      widget.fileName,
    );
    // Better player data source configuration
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      path,
    );
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
    );
    // Initialize Better player controller
    _betterPlayerController = BetterPlayerController(
      betterPlayerConfiguration,
      betterPlayerDataSource: betterPlayerDataSource,
    );
  }
}
