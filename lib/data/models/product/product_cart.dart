import 'package:singingholic_app/data/models/product/product_cart_item.dart';

class ProductCartModel {
  final List<ProductCartItemModel>? gifts;
  final int? itemTotal;
  final List<ProductCartItemModel>? items;
  final int? qtyTotal;
  final int? usePoints;

  ProductCartModel({
    this.itemTotal,
    this.items,
    this.qtyTotal,
    this.usePoints,
    this.gifts,
  });

  ProductCartModel.fromJson(Map<String, dynamic> json)
      : this.gifts = json['gifts']
            ?.map<ProductCartItemModel>((e) => ProductCartItemModel.fromJson(e))
            .toList(),
        this.itemTotal = json['itemTotal'],
        this.items = json['items']
            ?.map<ProductCartItemModel>((e) => ProductCartItemModel.fromJson(e))
            .toList(),
        this.qtyTotal = json['qtyTotal'],
        this.usePoints = json['usePoints'];

  Map<String, dynamic> toJson() => {
        'gift': this.gifts,
        'itemTotal': this.itemTotal,
        'items': this.items,
        'qtyTotal': this.qtyTotal,
        'gifts': this.gifts,
      };
}
