import 'package:flutter/material.dart';
import 'package:singingholic_app/data/models/video/video.dart';

class VideoThumbnailContainer extends StatelessWidget {
  /// Video details
  final VideoModel videoDetails;

  /// Flag to show category
  final bool showCategory;

  /// Create Video thumbnail card
  const VideoThumbnailContainer({
    Key? key,
    required this.videoDetails,
    this.showCategory = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildThumbnail(),
        _buildCategory(),
        _buildTitle(),
        _buildPriceTag(),
      ],
    );
  }

  Widget _buildThumbnail() {
    return Container();
  }

  Widget _buildCategory() {
    return Container();
  }

  Widget _buildTitle() {
    return Container();
  }

  Widget _buildPriceTag() {
    return Container();
  }
}
