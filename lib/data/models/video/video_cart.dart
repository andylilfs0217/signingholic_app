import 'package:singingholic_app/data/models/product/product_cart_item.dart';
import 'package:singingholic_app/data/models/video/video_cart_item.dart';

class VideoCartModel {
  final List<VideoCartItemModel>? gifts;
  final num? itemTotal;
  final List<VideoCartItemModel>? items;
  final num? usePoints;

  VideoCartModel({
    this.itemTotal,
    this.items,
    this.usePoints,
    this.gifts,
  });

  VideoCartModel.fromJson(Map<String, dynamic> json)
      : this.gifts = json['gifts']
            ?.map<VideoCartItemModel>((e) => VideoCartItemModel.fromJson(e))
            .toList(),
        this.itemTotal = json['itemTotal'],
        this.items = json['items']
            ?.map<VideoCartItemModel>((e) => VideoCartItemModel.fromJson(e))
            .toList(),
        this.usePoints = json['usePoints'];

  Map<String, dynamic> toJson() => {
        'gift': this.gifts,
        'itemTotal': this.itemTotal,
        'items': this.items,
        'gifts': this.gifts,
      };
}
