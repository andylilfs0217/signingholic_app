import 'dart:convert';

import 'package:singingholic_app/data/models/member/member_tier.dart';
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
  MemberTierModel? tier;

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

  MemberModel.fromJson(Map<String, dynamic> jsons)
      : id = jsons['id'] is int ? jsons['id'] : int.parse(jsons['id']),
        active = jsons['active'],
        name = jsons['name'],
        email = jsons['email'],
        type = jsons['type'],
        mobile = jsons['mobile'],
        address = jsons['address'],
        birthday = jsons['birthday'],
        data = jsons['data'],
        password = jsons['password'],
        tierStartDate = jsons['tierStartDate'],
        signupToken = jsons['signupToken'],
        createTime = jsons['createTime'],
        updateTime = jsons['updateTime'],
        points = jsons['points'],
        productCart = jsons['productCart'] != null
            ? ProductCartModel.fromJson(jsons['productCart'] is String
                ? jsonDecode(jsons['productCart'])
                : jsons['productCart'])
            : null,
        productCartDate = jsons['productCartDate'],
        productCartSent = jsons['productCartSent'],
        eventCart = jsons['eventCart'],
        eventCartDate = jsons['eventCartDate'],
        eventCartSent = jsons['eventCartSent'],
        videoCart = jsons['videoCart'] != null
            ? VideoCartModel.fromJson(jsons['videoCart'] is String
                ? jsonDecode(jsons['videoCart'])
                : jsons['videoCart'])
            : null,
        videoCartDate = jsons['videoCartDate'],
        videoCartSent = jsons['videoCartSent'],
        resetDate = jsons['resetDate'],
        resetToken = jsons['resetToken'],
        tier = jsons['tier'] != null
            ? MemberTierModel.fromJson(jsons['tier'])
            : null;

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
    data['tier'] = this.tier != null ? this.tier!.toJson() : null;
    return data;
  }
}
