class VideoItemModel {
  List? rules;
  int id;
  String? status;
  bool? featured;
  String? inventoryMode;
  String? code;
  String? name;
  bool? hidden;
  bool? excludeFromOrderRules;
  String? nameLang;
  String? startDate;
  String? endDate;
  String? description;
  String? descriptionLang;
  num? cost;
  num? price;
  num? discount;
  num? discountPc;
  num? memberPrice;
  num? memberDiscount;
  num? memberDiscountPc;
  num? maxQty;
  List? tags;
  List? imageIds;
  List? imagePaths;
  num? weight;
  num? sold;
  num? sold7day;
  num? sold30day;
  String? createTime;
  String? updateTime;
  String? category;
  List? categories;

  VideoItemModel(
      {this.rules,
      required this.id,
      this.status,
      this.featured,
      this.inventoryMode,
      this.code,
      this.name,
      this.hidden,
      this.excludeFromOrderRules,
      this.nameLang,
      this.startDate,
      this.endDate,
      this.description,
      this.descriptionLang,
      this.cost,
      this.price,
      this.discount,
      this.discountPc,
      this.memberPrice,
      this.memberDiscount,
      this.memberDiscountPc,
      this.maxQty,
      this.tags,
      this.imageIds,
      this.imagePaths,
      this.weight,
      this.sold,
      this.sold7day,
      this.sold30day,
      this.createTime,
      this.updateTime,
      this.category,
      this.categories});

  VideoItemModel.fromJson(Map<String, dynamic> json)
      : rules = json['rules'],
        id = json['id'],
        status = json['status'],
        featured = json['featured'],
        inventoryMode = json['inventoryMode'],
        code = json['code'],
        name = json['name'],
        hidden = json['hidden'],
        excludeFromOrderRules = json['excludeFromOrderRules'],
        nameLang = json['name_lang'],
        startDate = json['startDate'],
        endDate = json['endDate'],
        description = json['description'],
        descriptionLang = json['description_lang'],
        cost = json['cost'],
        price = json['price'],
        discount = json['discount'],
        discountPc = json['discountPc'],
        memberPrice = json['memberPrice'],
        memberDiscount = json['memberDiscount'],
        memberDiscountPc = json['memberDiscountPc'],
        maxQty = json['maxQty'],
        tags = json['tags'],
        imageIds = json['imageIds'],
        imagePaths = json['imagePaths'],
        weight = json['weight'],
        sold = json['sold'],
        sold7day = json['sold_7day'],
        sold30day = json['sold_30day'],
        createTime = json['createTime'],
        updateTime = json['updateTime'],
        category = json['category'],
        categories = json['categories']
            ?.map((e) => VideoItemCategoryModel.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rules'] = this.rules;
    data['id'] = this.id;
    data['status'] = this.status;
    data['featured'] = this.featured;
    data['inventoryMode'] = this.inventoryMode;
    data['code'] = this.code;
    data['name'] = this.name;
    data['hidden'] = this.hidden;
    data['excludeFromOrderRules'] = this.excludeFromOrderRules;
    data['name_lang'] = this.nameLang;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['description'] = this.description;
    data['description_lang'] = this.descriptionLang;
    data['cost'] = this.cost;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['discountPc'] = this.discountPc;
    data['memberPrice'] = this.memberPrice;
    data['memberDiscount'] = this.memberDiscount;
    data['memberDiscountPc'] = this.memberDiscountPc;
    data['maxQty'] = this.maxQty;
    data['tags'] = this.tags;
    data['imageIds'] = this.imageIds;
    data['imagePaths'] = this.imagePaths;
    data['weight'] = this.weight;
    data['sold'] = this.sold;
    data['sold_7day'] = this.sold7day;
    data['sold_30day'] = this.sold30day;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['category'] = this.category;
    data['categories'] = this.categories?.map((v) => v.toJson()).toList();
    return data;
  }
}

class VideoItemCategoryModel {
  String? name;
  String? nameLang;
  int id;

  VideoItemCategoryModel({this.name, this.nameLang, required this.id});

  VideoItemCategoryModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        nameLang = json['name_lang'],
        id = json['id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['name_lang'] = this.nameLang;
    data['id'] = this.id;
    return data;
  }
}
