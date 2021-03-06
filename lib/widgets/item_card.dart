import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:singingholic_app/assets/app_theme.dart';
import 'package:singingholic_app/data/bloc/login/login_bloc.dart';
import 'package:singingholic_app/data/bloc/video/video_bloc.dart';
import 'package:singingholic_app/utils/video_utils.dart';
import 'package:singingholic_app/widgets/app_circular_loading.dart';
import 'package:singingholic_app/widgets/image_not_found.dart';
import 'package:singingholic_app/widgets/tag_chip.dart';
import 'package:singingholic_app/data/models/video/video.dart';

/// Item card
class ItemCard extends StatefulWidget {
  /// Aspect ratio of image
  final double imageRatio;

  /// How the image fits with the size
  final BoxFit? fit;

  /// URL of the required image (If [assetImagePath] is not null, [imageUrl] will be ignored.)
  final String? imageUrl;

  /// Path of the asset image
  final String? assetImagePath;

  /// Category of the item
  final List? categories;

  /// Title of the item
  final String title;

  /// Subtitle of the item
  final String? subtitle;

  /// List of tags of the item
  final List? tags;

  /// Width of the card
  final double width;

  /// Max Line for displaying categories
  final int categoryMaxLine;

  /// Max Line for displaying title
  final int titleMaxLine;

  /// On tap function
  final Function()? onTap;

  /// Video model
  final VideoModel? videoModel;

  /// Create item card
  const ItemCard(
      {Key? key,
      this.imageRatio = 16 / 9,
      this.fit = BoxFit.cover,
      this.imageUrl,
      this.assetImagePath,
      this.categories,
      required this.title,
      this.tags,
      this.subtitle,
      this.width = 250,
      this.categoryMaxLine = 1,
      this.titleMaxLine = 1,
      this.onTap,
      this.videoModel})
      : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  void initState() {
    super.initState();
    if (widget.videoModel != null) {
      int? memberId;
      if (BlocProvider.of<LoginBloc>(context).state is LoginSuccessState) {
        memberId = BlocProvider.of<LoginBloc>(context).state.memberModel!.id;
      }
      context
          .read<VideoBloc>()
          .add(FetchVideoEvent(id: widget.videoModel!.id, memberId: memberId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          width: widget.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.imageUrl != null || widget.assetImagePath != null)
                _buildImage(),
              if (widget.categories != null) _buildCategory(),
              _buildTitle(),
              if (widget.subtitle != null) _buildSubtitle(),
              if (widget.tags != null) _buildTags(),
            ],
          ),
        ),
      ),
    );
  }

  /// Create Card image
  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppThemeSize.appBorderRadius)),
      child: AspectRatio(
        aspectRatio: widget.imageRatio,
        child: widget.assetImagePath != null
            ? Image(
                image: AssetImage(widget.assetImagePath!),
                fit: widget.fit,
                width: widget.width,
              )
            : CachedNetworkImage(
                imageUrl: widget.imageUrl!,
                placeholder: (context, url) => AppCircularLoading(),
                errorWidget: (context, url, error) => ImageNotFound(),
                fit: widget.fit,
                width: widget.width,
              ),
      ),
    );
  }

  /// Create Item category text
  Widget _buildCategory() {
    return Padding(
      padding:
          const EdgeInsets.all(AppThemeSize.defaultItemVerticalPaddingSize / 2),
      child: RichText(
        maxLines: widget.categoryMaxLine,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .apply(color: AppThemeColor.appPrimaryColor, fontSizeDelta: -1),
          children:
              widget.categories!.map((e) => TextSpan(text: '$e ')).toList(),
        ),
      ),
    );
  }

  /// Create Item name text
  Widget _buildTitle() {
    return Padding(
      padding:
          const EdgeInsets.all(AppThemeSize.defaultItemVerticalPaddingSize / 2),
      child: Text(
        widget.title,
        style: Theme.of(context).textTheme.bodyText1,
        maxLines: widget.titleMaxLine,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// Create Item tags
  Widget _buildTags() {
    return Padding(
      padding:
          const EdgeInsets.all(AppThemeSize.defaultItemVerticalPaddingSize / 2),
      child: Wrap(
        children: widget.tags!
            .map((e) => TagChip(
                  label: e,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                ))
            .toList(),
        spacing: AppThemeSize.defaultItemHorizontalPaddingSize,
        runSpacing: AppThemeSize.defaultItemVerticalPaddingSize / 2,
      ),
    );
  }

  /// Create subtitle
  Widget _buildSubtitle() {
    return BlocBuilder<VideoBloc, VideoState>(
      builder: (context, state) {
        var isPurchased = state is VideoFetchSuccessState &&
            VideoUtils.isVideoPurchased(
                widget.videoModel, state.videoFormatModel);
        return Padding(
          padding: const EdgeInsets.all(
              AppThemeSize.defaultItemVerticalPaddingSize / 2),
          child: Text(
            isPurchased ? 'Purchased' : widget.subtitle ?? '',
            style: TextStyle(
                fontSize: 14,
                color: isPurchased ? Colors.green : Color(0xFF707070)),
            maxLines: widget.titleMaxLine,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    );
  }
}
