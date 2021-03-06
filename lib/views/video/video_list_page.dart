import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:singingholic_app/assets/app_theme.dart';
import 'package:singingholic_app/data/bloc/video_list/video_list_bloc.dart';
import 'package:singingholic_app/global/variables.dart';
import 'package:singingholic_app/routes/app_arguments.dart';
import 'package:singingholic_app/routes/app_router.dart';
import 'package:singingholic_app/utils/app_navigator.dart';
import 'package:singingholic_app/utils/path_utils.dart';
import 'package:singingholic_app/utils/video_utils.dart';
import 'package:singingholic_app/widgets/app_appBar.dart';
import 'package:singingholic_app/widgets/app_circular_loading.dart';
import 'package:singingholic_app/widgets/app_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:singingholic_app/widgets/app_video_search_bar.dart';
import 'package:singingholic_app/widgets/item_card.dart';
import 'package:singingholic_app/data/models/video/video.dart';

/// Video list page that show all the videos in grid
class VideoListPage extends StatefulWidget {
  /// Title of the app bar
  final String? title;

  /// Create video list page
  const VideoListPage({Key? key, this.title}) : super(key: key);

  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  @override
  void initState() {
    super.initState();
    // Create video list fetch event
    context.read<VideoListBloc>().add(VideoListFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppAppBar(
        appBar: AppBar(),
        title: widget.title ?? '',
      ),
      body: _buildBody(),
      hasDrawer: false,
    );
  }

  /// Build page body
  Widget _buildBody() {
    return Column(
      children: [
        _buildSearchBar(),
        BlocBuilder<VideoListBloc, VideoListState>(
          builder: (context, state) {
            if (state is VideoListFetchFailedState) {
              // Video List fetching failed
              return Center(
                child: Text('Video list cannot be fetched'),
              );
            } else if (state is VideoListInitialState) {
              // Video List fetching
              return AppCircularLoading();
            } else if (state is VideoListFetchSuccessState) {
              // Video List fetching success and the list is not empty
              return _buildGrid(state, context);
            } else {
              // Video List fetching success but the list is empty
              return Center(
                child: Text('The video list is empty'),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildGrid(VideoListFetchSuccessState state, BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 9 / 14,
        primary: true,
        children: state.videoList.results.map((VideoModel e) {
          // Add a tag "FREE" if the video is free
          // Add a price if the video is not free
          List tags = e.tags ?? [];
          String? subtitle;
          if (VideoUtils.isVideoFree(e)) {
            if (!tags.contains('FREE')) {
              tags.add('FREE');
            }
          } else if (e.price != null && e.price! > 0) {
            subtitle = '\$${e.price}';
          }
          return _buildItemCard(
              title: e.name ?? 'Title not found',
              imageUrl: PathUtils.getImagePathWithId(
                  accountId, 'video', e.id, e.imagePaths?[0]),
              categories: e.categories?.map((e) => e.name).toList(),
              tags: e.tags,
              subtitle: subtitle,
              imageRatio: 1 / 1,
              onTap: () {
                AppNavigator.goTo(context, AppRoute.VIDEO,
                    args: VideoArguments(id: e.id), then: () {
                  setState(() {});
                });
              },
              videoModel: e);
        }).toList(),
      ),
    );
  }

  /// Create item card
  Widget _buildItemCard(
      {double imageRatio = 16 / 9,
      String? imageUrl,
      List? categories,
      required String title,
      String? subtitle,
      List? tags,
      int categoryMaxLine = 1,
      int titleMaxLine = 1,
      Function()? onTap,
      VideoModel? videoModel}) {
    return ItemCard(
      imageRatio: imageRatio,
      fit: BoxFit.cover,
      imageUrl: imageUrl,
      categories: categories,
      title: title,
      subtitle: subtitle,
      tags: tags,
      categoryMaxLine: categoryMaxLine,
      titleMaxLine: titleMaxLine,
      onTap: onTap,
      videoModel: videoModel,
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: AppThemeSize.defaultItemVerticalPaddingSize),
      child: AppVideoSearchBar(),
    );
  }
}
