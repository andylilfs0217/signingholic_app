import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:singingholic_app/data/bloc/video_list/video_list_bloc.dart';
import 'package:singingholic_app/global/variables.dart';
import 'package:singingholic_app/routes/app_arguments.dart';
import 'package:singingholic_app/routes/app_router.dart';
import 'package:singingholic_app/utils/path_utils.dart';
import 'package:singingholic_app/widgets/app_appBar.dart';
import 'package:singingholic_app/widgets/app_circular_loading.dart';
import 'package:singingholic_app/widgets/app_footer.dart';
import 'package:singingholic_app/widgets/app_scaffold.dart';
import 'package:singingholic_app/widgets/item_card.dart';

/// Home page
class HomePage extends StatefulWidget {
  /// Create Home Page
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        title: 'Home Page',
      ),
      body: _buildBody(),
    );
  }

  @override
  void dispose() {
    context.read<VideoListBloc>().close();
    super.dispose();
  }

  /// Create home page body
  Widget _buildBody() {
    String title = 'Recent Online Class';
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _buildLogo(),
        _buildHorizontalList(
            title: title,
            seeAll: () {
              Navigator.of(context).pushNamed(AppRoute.VIDEO_LIST,
                  arguments: VideoListArguments(title: title));
            },
            imageRatio: 16 / 9),
        _buildGridView(title: 'About Us', imageRatio: 1 / 1),
        AppFooter(),
      ],
    );
  }

  /// Create logo container
  Widget _buildLogo() {
    return Container(
      width: double.infinity,
      height: 100,
      alignment: Alignment.center,
      child: Image(
        image: AssetImage(LOGO_PATH),
      ),
    );
  }

  /// Create horizontal list of cards
  Widget _buildHorizontalList(
      {String title = '', Function()? seeAll, double imageRatio = 16 / 9}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(title: title, seeAll: seeAll),
        _buildCardList(imageRatio: imageRatio),
      ],
    );
  }

  /// Create header of the horizontal list
  Widget _buildHeader({required String title, Function()? seeAll}) {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        )),
        if (seeAll != null)
          TextButton(
            onPressed: seeAll,
            child: Text('See All'),
          ),
      ],
    );
  }

  /// Create card list of the horizontal list
  Widget _buildCardList({double imageRatio = 16 / 9}) {
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
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: state.videoList.results
                  .map((e) => _buildItemCard(
                      title: e.name ?? 'Title not found',
                      imageUrl: PathUtils.getImagePath(
                          52, 'video', e.id, e.imagePaths?[0]),
                      categories: e.categories?.map((e) => e.name).toList(),
                      tags: e.tags,
                      imageRatio: imageRatio,
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoute.VIDEO,
                            arguments: VideoArguments(id: e.id));
                      }))
                  .toList(),
            ),
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

  Widget _buildGridView(
      {required String title, double imageRatio = 1 / 1, Function()? seeAll}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(title: title, seeAll: seeAll),
        _buildCardGrid(imageRatio: imageRatio),
      ],
    );
  }

  Widget _buildCardGrid({double imageRatio = 1 / 1}) {
    return GridView.count(
      primary: false,
      crossAxisCount: 2,
      childAspectRatio: 9 / 12,
      shrinkWrap: true,
      children: <Widget>[
        _buildItemCard(
          title: 'Kan Lam',
          imageRatio: imageRatio,
          imageUrl: 'https://picsum.photos/id/237/200/200',
          subtitle: 'Singing Tutor',
        ),
        _buildItemCard(
          title: 'Joyce Lee',
          imageRatio: imageRatio,
          imageUrl: 'https://picsum.photos/id/238/200/200',
          subtitle: 'Singing Tutor',
        ),
        _buildItemCard(
          title: 'Andy Li',
          imageRatio: imageRatio,
          imageUrl: 'https://picsum.photos/id/239/200/200',
          subtitle: 'Singing Tutor',
        ),
      ],
    );
  }
}
