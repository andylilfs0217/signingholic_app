import 'dart:convert';

import 'package:singingholic_app/data/models/product/product_cart.dart';
import 'package:singingholic_app/data/models/video/video_cart.dart';

class MemberModel {
  int id;
  bool? active;
  String? name;
  String? email;
  String? type;
  String? mobile;
  String? address;
  String? birthday;
  String? data;
  String? password;
  String? tierStartDate;
  String? signupToken;
  String? createTime;
  String? updateTime;
  int? points;
  ProductCartModel? productCart;
  String? productCartDate;
  bool? productCartSent;
  String? eventCart;
  String? eventCartDate;
  bool? eventCartSent;
  VideoCartModel? videoCart;
  String? videoCartDate;
  bool? videoCartSent;
  String? resetDate;
  String? resetToken;
  Object? tier;

  MemberModel(
      {required this.id,
      this.active,
      this.name,
      this.email,
      this.type,
      this.mobile,
      this.address,
      this.birthday,
      this.data,
      this.password,
      this.tierStartDate,
      this.signupToken,
      this.createTime,
      this.updateTime,
      this.points,
      this.productCart,
      this.productCartDate,
      this.productCartSent,
      this.eventCart,
      this.eventCartDate,
      this.eventCartSent,
      this.videoCart,
      this.videoCartDate,
      this.videoCartSent,
      this.resetDate,
      this.resetToken,
      this.tier});

  MemberModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        active = json['active'],
        name = json['name'],
        email = json['email'],
        type = json['type'],
        mobile = json['mobile'],
        address = json['address'],
        birthday = json['birthday'],
        data = json['data'],
        password = json['password'],
        tierStartDate = json['tierStartDate'],
        signupToken = json['signupToken'],
        createTime = json['createTime'],
        updateTime = json['updateTime'],
        points = json['points'],
        productCart = json['productCart'] != null
            ? ProductCartModel.fromJson(jsonDecode(json['productCart']))
            : null,
        productCartDate = json['productCartDate'],
        productCartSent = json['productCartSent'],
        eventCart = json['eventCart'],
        eventCartDate = json['eventCartDate'],
        eventCartSent = json['eventCartSent'],
        videoCart = json['videoCart'] != null
            ? VideoCartModel.fromJson(jsonDecode(json['videoCart']))
            : null,
        videoCartDate = json['videoCartDate'],
        videoCartSent = json['videoCartSent'],
        resetDate = json['resetDate'],
        resetToken = json['resetToken'],
        tier = json['tier'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['active'] = this.active;
    data['name'] = this.name;
    data['email'] = this.email;
    data['type'] = this.type;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['birthday'] = this.birthday;
    data['data'] = this.data;
    data['password'] = this.password;
    data['tierStartDate'] = this.tierStartDate;
    data['signupToken'] = this.signupToken;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['points'] = this.points;
    data['productCart'] =
        this.productCart != null ? this.productCart!.toJson() : null;
    data['productCartDate'] = this.productCartDate;
    data['productCartSent'] = this.productCartSent;
    data['eventCart'] = this.eventCart;
    data['eventCartDate'] = this.eventCartDate;
    data['eventCartSent'] = this.eventCartSent;
    data['videoCart'] =
        this.videoCart != null ? this.videoCart!.toJson() : null;
    data['videoCartDate'] = this.videoCartDate;
    data['videoCartSent'] = this.videoCartSent;
    data['resetDate'] = this.resetDate;
    data['resetToken'] = this.resetToken;
    data['tier'] = this.tier;
    return data;
  }
}
