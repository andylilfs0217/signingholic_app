import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:singingholic_app/assets/app_theme.dart';
import 'package:singingholic_app/data/bloc/cart/cart_bloc.dart';
import 'package:singingholic_app/data/bloc/login/login_bloc.dart';
import 'package:singingholic_app/data/bloc/video/video_bloc.dart';
import 'package:singingholic_app/data/models/video/video.dart';
import 'package:singingholic_app/data/models/video/video_cart.dart';
import 'package:singingholic_app/data/models/video/video_cart_item.dart';
import 'package:singingholic_app/data/models/video/video_category.dart';
import 'package:singingholic_app/data/models/video/video_formats.dart';
import 'package:singingholic_app/global/variables.dart';
import 'package:singingholic_app/utils/path_utils.dart';
import 'package:singingholic_app/views/video/video_discussion.dart';
import 'package:singingholic_app/views/video/video_player.dart';
import 'package:singingholic_app/widgets/app_appBar.dart';
import 'package:singingholic_app/widgets/app_circular_loading.dart';
import 'package:singingholic_app/widgets/app_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:singingholic_app/widgets/image_not_found.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        int? memberId;
        if (state is LoginSuccessState) {
          memberId = state.memberModel.id;
        }
        // Create video list fetch event
        context
            .read<VideoBloc>()
            .add(FetchVideoEvent(id: widget.id, memberId: memberId));
        return AppScaffold(
          appBar: AppAppBar(appBar: AppBar()),
          body: _buildBody(),
          hasDrawer: false,
        );
      },
    );
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
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: AppThemeSize.defaultItemVerticalPaddingSize),
                      _buildVideoPlayer(
                          videoModel: state.videoModel,
                          videoFormats: state.videoFormatModel),
                      _buildCategory(categories: state.videoModel.categories),
                      _buildTitle(title: state.videoModel.name),
                      _buildStatus(videoModel: state.videoModel),
                      _buildTabBarController(videoModel: state.videoModel),
                    ],
                  ),
                ),
              ),
              if (state.videoFormatModel == null ||
                  state.videoFormatModel!.length == 0)
                _buildButtonBar(videoModel: state.videoModel),
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
  Widget _buildVideoPlayer(
      {List<VideoFormatModel>? videoFormats, required VideoModel videoModel}) {
    if (videoFormats == null || videoFormats.length == 0) {
      return _buildVideoLocked(
          thumbnail: PathUtils.getImagePathWithId(
              accountId, 'video', videoModel.id, videoModel.imagePaths?[0]));
    } else {
      VideoFormatModel videoFormat = videoFormats.last;
      String videoUrl = videoFormat.url;
      return VideoPlayerContainer(
        videoUrl: videoUrl,
      );
    }
  }

  /// Create Item category text
  Widget _buildCategory({List? categories}) {
    return Padding(
      padding:
          const EdgeInsets.all(AppThemeSize.defaultItemVerticalPaddingSize / 2),
      child: RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .apply(color: AppThemeColor.appPrimaryColor, fontSizeDelta: -1),
          children:
              categories?.map((e) => TextSpan(text: '${e.name} ')).toList(),
        ),
      ),
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
        style: TextStyle(fontSize: 14, color: Color(0xFF707070)),
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
    return Container(
      height: 500,
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

  /// Create tab view of discussion
  Widget _buildDiscussion() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppThemeSize.defaultItemVerticalPaddingSize),
      child: VideoDiscussion(videoId: widget.id),
    );
  }

  /// Create video lock container
  Widget _buildVideoLocked({required String thumbnail}) {
    return CachedNetworkImage(
      imageUrl: thumbnail,
      placeholder: (context, url) => AppCircularLoading(),
      errorWidget: (context, url, error) => ImageNotFound(),
      imageBuilder: (context, imageProvider) => Container(
        height: 250,
        child: Center(
            child: Icon(
          Icons.lock,
          size: 100,
          color: Colors.white54,
        )),
        decoration: BoxDecoration(
          color: Colors.grey,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.dstATop),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonBar({VideoModel? videoModel}) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        // Check if the current video is added into the shopping cart
        bool isAdded = false;
        if (state is LoginSuccessState) {
          var currentVideoItems = state.memberModel.videoCart?.items ?? [];
          var currentVideoItemIds = currentVideoItems.map((e) => e.video?.id);
          var currentVideoId = videoModel!.id;
          isAdded = currentVideoItemIds.contains(currentVideoId);
        }

        return Column(
          children: [
            Divider(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                  onPressed: state is LoginSuccessState && !isAdded
                      ? () {
                          setState(() {
                            // Put the current video into video cart
                            var videoCart = state.memberModel.videoCart!;
                            var id = videoCart.items?.length ?? 0;
                            var qty = 1;
                            var unit = videoModel?.price ?? 0;
                            var unitDiscounted =
                                unit - (videoModel?.discountPc ?? 0);
                            var total = unitDiscounted * qty;
                            var discount = unitDiscounted * qty;
                            var videoCartItem = VideoCartItemModel(
                                id: id,
                                qty: qty,
                                total: total,
                                discount: discount,
                                unit: unit,
                                unitDiscounted: unitDiscounted,
                                video: VideoModel(id: videoModel!.id));
                            videoCart.items!.add(videoCartItem);
                            // Update item total of video cart
                            var videoCartJson = videoCart.toJson();
                            videoCartJson['itemTotal'] += total;
                            videoCart =
                                new VideoCartModel.fromJson(videoCartJson);

                            // state.memberModel.videoCart = videoCart;
                            context.read<LoginBloc>().add(
                                LoginUpdateVideoCartEvent(
                                    videoCartModel: videoCart));

                            context.read<CartBloc>().add(UpdateVideoCartEvent(
                                videoCartModel: videoCart));
                          });
                        }
                      : null,
                  icon: Icon(Icons.shopping_cart),
                  label: Text(!(state is LoginSuccessState)
                      ? 'Please log in first'
                      : isAdded
                          ? 'Already in shopping cart'
                          : 'Add to cart')),
            ),
            SizedBox(height: 10),
          ],
        );
      },
    );
  }
}
