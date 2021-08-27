import 'package:singingholic_app/data/models/product/product_item.dart';
import 'package:singingholic_app/data/models/product/product_cart_item_option.dart';
import 'package:singingholic_app/data/models/video/video.dart';

class VideoCartItemModel {
  int? id;
  int? qty;
  num? total;
  num? discount;
  num? unit;
  num? unitDiscounted;
  VideoModel? video;

  VideoCartItemModel(
      {this.id,
      this.qty,
      this.total,
      this.discount,
      this.unit,
      this.unitDiscounted,
      this.video});

  VideoCartItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qty = json['qty'];
    total = json['total'];
    discount = json['discount'];
    unit = json['unit'];
    unitDiscounted = json['unitDiscounted'];
    video = json['video'] != null ? VideoModel.fromJson(json['video']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['qty'] = this.qty;
    data['total'] = this.total;
    data['discount'] = this.discount;
    data['unit'] = this.unit;
    data['unitDiscounted'] = this.unitDiscounted;
    if (this.video != null) {
      data['video'] = this.video!.toJson();
    }
    return data;
  }
}
