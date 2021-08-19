import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:singingholic_app/data/bloc/video_list/video_list_bloc.dart';
import 'package:singingholic_app/routes/app_arguments.dart';
import 'package:singingholic_app/routes/app_router.dart';
import 'package:singingholic_app/utils/path_utils.dart';
import 'package:singingholic_app/widgets/app_appBar.dart';
import 'package:singingholic_app/widgets/app_circular_loading.dart';
import 'package:singingholic_app/widgets/app_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:singingholic_app/widgets/item_card.dart';

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

  @override
  void dispose() {
    context.read<VideoListBloc>().close();
    super.dispose();
  }

  /// Build page body
  Widget _buildBody() {
    return BlocBuilder<VideoListBloc, VideoListState>(
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
          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 9 / 12,
            primary: true,
            children: state.videoList.results
                .map((e) => _buildItemCard(
                    title: e.name ?? 'Title not found',
                    imageUrl: PathUtils.getImagePath(
                        52, 'video', e.id, e.imagePaths?[0]),
                    categories: e.categories?.map((e) => e.name).toList(),
                    tags: e.tags,
                    imageRatio: 1 / 1,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoute.VIDEO,
                          arguments: VideoArguments(id: e.id));
                    }))
                .toList(),
          );
        } else {
          // Video List fetching success but the list is empty
          return Center(
            child: Text('The video list is empty'),
          );
        }
      },
    );
  }

  /// Create item card
  Widget _buildItemCard({
    double imageRatio = 16 / 9,
    String? imageUrl,
    List? categories,
    required String title,
    String? subtitle,
    List? tags,
    int categoryMaxLine = 1,
    int titleMaxLine = 1,
    Function()? onTap,
  }) {
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
    );
  }
}
