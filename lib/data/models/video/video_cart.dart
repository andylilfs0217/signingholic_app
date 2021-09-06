import 'package:singingholic_app/data/models/video/video_cart_item.dart';

class VideoCartModel {
  List<VideoCartItemModel>? gifts;
  num? itemTotal;
  List<VideoCartItemModel>? items;
  num? usePoints;

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
        'gift': this.gifts?.map((e) => e.toJson()).toList(),
        'itemTotal': this.itemTotal,
        'items': this.items?.map((e) => e.toJson()).toList(),
        'usePoints': this.usePoints,
      };
}
