import 'package:singingholic_app/data/models/product/product_item.dart';

class ProductCartItemOptionModel {
  ProductOptionModel? option;
  ProductItemModel? item;

  ProductCartItemOptionModel({this.option, this.item});

  ProductCartItemOptionModel.fromJson(Map<String, dynamic> json) {
    option = json['option'] != null
        ? new ProductOptionModel.fromJson(json['option'])
        : null;
    item = json['item'] != null
        ? new ProductItemModel.fromJson(json['item'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.option != null) {
      data['option'] = this.option!.toJson();
    }
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    return data;
  }
}
