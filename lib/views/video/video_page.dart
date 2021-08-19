import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:singingholic_app/assets/app_theme.dart';
import 'package:singingholic_app/data/bloc/video/video_bloc.dart';
import 'package:singingholic_app/data/models/video/video.dart';
import 'package:singingholic_app/views/video/video_player.dart';
import 'package:singingholic_app/widgets/app_appBar.dart';
import 'package:singingholic_app/widgets/app_circular_loading.dart';
import 'package:singingholic_app/widgets/app_scaffold.dart';
import 'package:provider/provider.dart';

/// Video page
class VideoPage extends StatefulWidget {
  /// ID of the video
  final int id;

  /// Create Video page
  const VideoPage({Key? key, required this.id}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  void initState() {
    super.initState();
    // Create video list fetch event
    context.read<VideoBloc>().add(FetchVideoEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppAppBar(appBar: AppBar()),
      body: _buildBody(),
      hasDrawer: false,
    );
  }

  @override
  void dispose() {
    context.read<VideoBloc>().close();
    super.dispose();
  }

  /// Create page body
  Widget _buildBody() {
    return BlocBuilder<VideoBloc, VideoState>(
      builder: (context, state) {
        if (state is VideoInitialState) {
          // If getting video
          return Center(child: AppCircularLoading());
        } else if (state is VideoFetchSuccessState) {
          // If get video success
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildVideoPlayer(),
              _buildTitle(title: state.videoModel.name),
              _buildStatus(videoModel: state.videoModel),
              Expanded(
                  child: _buildTabBarController(videoModel: state.videoModel)),
            ],
          );
        } else {
          // If there is an error when getting the video
          return Container(
            height: 100,
            color: Colors.red,
          );
        }
      },
    );
  }

  /// Create video player
  Widget _buildVideoPlayer() {
    return VideoPlayerContainer(
      videoUrl:
          'https://data.mymp3app.com/720/rick-astley-never-gonna-give-you-up-(720p).mp4',
    );
  }

  /// Create video title
  Widget _buildTitle({String? title}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: AppThemeSize.defaultItemVerticalPaddingSize),
      child: Text(
        title ?? 'Title not found',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  /// Create video status
  Widget _buildStatus({required VideoModel videoModel}) {
    String status = '';
    // TODO: check if the video is purchased
    if (videoModel.free ?? false) {
      status = 'Free';
    } else if (videoModel.price != null) {
      status = '\$${videoModel.price}';
    }
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: AppThemeSize.defaultItemVerticalPaddingSize),
      child: Text(
        status,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }

  /// Create tab bar controller
  Widget _buildTabBarController({required VideoModel videoModel}) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTabBar(),
          _buildTabBarView(videoModel: videoModel),
        ],
      ),
    );
  }

  /// Create tab bar
  Widget _buildTabBar() {
    return TabBar(tabs: [
      Tab(text: 'Description'),
      Tab(text: 'Discussion'),
    ]);
  }

  /// Create view for each tab
  Widget _buildTabBarView({required VideoModel videoModel}) {
    return Expanded(
      child: TabBarView(children: [
        _buildDescription(videoModel: videoModel),
        _buildDiscussion(),
      ]),
    );
  }

  /// Create tab view of description
  Widget _buildDescription({required VideoModel videoModel}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppThemeSize.defaultItemVerticalPaddingSize),
      child: Text(videoModel.description ?? ''),
    );
  }

  /// TODO: Create tab view of discussion
  Widget _buildDiscussion() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppThemeSize.defaultItemVerticalPaddingSize),
      child: Text(
        'To be implemented',
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
