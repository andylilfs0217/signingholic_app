import 'package:singingholic_app/data/models/video/video_cart.dart';
import 'package:singingholic_app/data/models/video/video_item.dart';

/// Arguments which will be passed to Video List screen
class VideoListArguments {
  final String? title;
  VideoListArguments({this.title});
}

/// Arguments which will be passed to Video screen
class VideoArguments {
  final int id;
  VideoArguments({required this.id});
}

/// Arguments which will be passed to Checkout page
class CheckoutArguments {
  final List<VideoItemModel> videoItems;
  final VideoCartModel videoCart;

  CheckoutArguments({required this.videoItems, required this.videoCart});
}
