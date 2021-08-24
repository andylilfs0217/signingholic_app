class MemberModel {
  int? id;
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
  String? productCart;
  String? productCartDate;
  bool? productCartSent;
  String? eventCart;
  String? eventCartDate;
  bool? eventCartSent;
  String? resetDate;
  String? resetToken;
  Object? tier;

  MemberModel(
      {this.id,
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
        productCart = json['productCart'],
        productCartDate = json['productCartDate'],
        productCartSent = json['productCartSent'],
        eventCart = json['eventCart'],
        eventCartDate = json['eventCartDate'],
        eventCartSent = json['eventCartSent'],
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
    data['productCart'] = this.productCart;
    data['productCartDate'] = this.productCartDate;
    data['productCartSent'] = this.productCartSent;
    data['eventCart'] = this.eventCart;
    data['eventCartDate'] = this.eventCartDate;
    data['eventCartSent'] = this.eventCartSent;
    data['resetDate'] = this.resetDate;
    data['resetToken'] = this.resetToken;
    data['tier'] = this.tier;
    return data;
  }
}
