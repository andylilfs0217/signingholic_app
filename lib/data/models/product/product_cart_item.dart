import 'package:singingholic_app/data/models/product/product_item.dart';
import 'package:singingholic_app/data/models/product/product_cart_item_option.dart';

class ProductCartItemModel {
  int id;
  int? qty;
  num? total;
  num? discount;
  num? unit;
  num? unitDiscounted;
  ProductItemModel? product;
  List? options;

  ProductCartItemModel(
      {required this.id,
      this.qty,
      this.total,
      this.discount,
      this.unit,
      this.unitDiscounted,
      this.product,
      this.options});

  ProductCartItemModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        qty = json['qty'],
        total = json['total'],
        discount = json['discount'],
        unit = json['unit'],
        unitDiscounted = json['unitDiscounted'],
        product = json['product'] != null
            ? new ProductItemModel.fromJson(json['product'])
            : null,
        options = json['options']
            ?.map((e) => ProductCartItemOptionModel.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['qty'] = this.qty;
    data['total'] = this.total;
    data['discount'] = this.discount;
    data['unit'] = this.unit;
    data['unitDiscounted'] = this.unitDiscounted;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
