class ProductItemModel {
  int id;
  String? status;
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
  int? maxQty;
  List? tags;
  List? imageIds;
  List? imagePaths;
  num? weight;
  String? createTime;
  String? updateTime;
  dynamic category;
  List? categories;
  List? options;
  List? addons;
  List? favourites;

  ProductItemModel(
      {required this.id,
      this.status,
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
      this.createTime,
      this.updateTime,
      this.category,
      this.categories,
      this.options,
      this.addons,
      this.favourites});

  ProductItemModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        status = json['status'],
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
        tags = json['tags']?.map((e) => e).toList(),
        imageIds = json['imageIds'],
        imagePaths = json['imagePaths'],
        weight = json['weight'],
        createTime = json['createTime'],
        updateTime = json['updateTime'],
        category = json['category'],
        categories = json['categories']
            ?.map((e) => ProductCategoryModel.fromJson(e))
            .toList(),
        options = json['options']
            ?.map((e) => ProductOptionModel.fromJson(e))
            .toList(),
        addons =
            json['addons']?.map((e) => ProductAddonModel.fromJson(e)).toList(),
        favourites = json['favourites']?.map((e) => e).toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
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
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    data['imageIds'] = this.imageIds;
    data['imagePaths'] = this.imagePaths;
    data['weight'] = this.weight;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['category'] = this.category;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    if (this.addons != null) {
      data['addons'] = this.addons!.map((v) => v.toJson()).toList();
    }
    if (this.favourites != null) {
      data['favourites'] = this.favourites!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductCategoryModel {
  String name;
  String nameLang;
  int id;

  ProductCategoryModel(
      {required this.name, required this.nameLang, required this.id});

  ProductCategoryModel.fromJson(Map<String, dynamic> json)
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

class ProductAddonModel {
  int id;
  int? seq;
  String? status;
  String? type;
  int? weight;
  int? cost;
  String? code;
  String? name;
  String? inventoryMode;
  String? nameLang;
  String? startDate;
  String? endDate;
  String? description;
  String? descriptionLang;
  int? price;
  int? discount;
  int? discountPc;
  List? tags;
  List? imageIds;
  List? imagePaths;
  String? createTime;
  String? updateTime;

  ProductAddonModel(
      {required this.id,
      this.seq,
      this.status,
      this.type,
      this.weight,
      this.cost,
      this.code,
      this.name,
      this.inventoryMode,
      this.nameLang,
      this.startDate,
      this.endDate,
      this.description,
      this.descriptionLang,
      this.price,
      this.discount,
      this.discountPc,
      this.tags,
      this.imageIds,
      this.imagePaths,
      this.createTime,
      this.updateTime});

  ProductAddonModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        seq = json['seq'],
        status = json['status'],
        type = json['type'],
        weight = json['weight'],
        cost = json['cost'],
        code = json['code'],
        name = json['name'],
        inventoryMode = json['inventoryMode'],
        nameLang = json['name_lang'],
        startDate = json['startDate'],
        endDate = json['endDate'],
        description = json['description'],
        descriptionLang = json['description_lang'],
        price = json['price'],
        discount = json['discount'],
        discountPc = json['discountPc'],
        tags = json['tags'],
        imageIds = json['imageIds'],
        imagePaths = json['imagePaths'],
        createTime = json['createTime'],
        updateTime = json['updateTime'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seq'] = this.seq;
    data['status'] = this.status;
    data['type'] = this.type;
    data['weight'] = this.weight;
    data['cost'] = this.cost;
    data['code'] = this.code;
    data['name'] = this.name;
    data['inventoryMode'] = this.inventoryMode;
    data['name_lang'] = this.nameLang;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['description'] = this.description;
    data['description_lang'] = this.descriptionLang;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['discountPc'] = this.discountPc;
    data['tags'] = this.tags;
    data['imageIds'] = this.imageIds;
    data['imagePaths'] = this.imagePaths;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    return data;
  }
}

class ProductOptionModel {
  int id;
  String? code;
  int? seq;
  bool? active;
  String? name;
  String? nameLang;
  String? type;
  String? description;
  String? descriptionLang;
  List? tags;
  String? createTime;
  String? updateTime;
  List? items;

  ProductOptionModel(
      {required this.id,
      this.code,
      this.seq,
      this.active,
      this.name,
      this.nameLang,
      this.type,
      this.description,
      this.descriptionLang,
      this.tags,
      this.createTime,
      this.updateTime,
      this.items});

  ProductOptionModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        code = json['code'],
        seq = json['seq'],
        active = json['active'],
        name = json['name'],
        nameLang = json['name_lang'],
        type = json['type'],
        description = json['description'],
        descriptionLang = json['description_lang'],
        tags = json['tags'],
        createTime = json['createTime'],
        updateTime = json['updateTime'],
        items = json['items']
            ?.map((e) => ProductOptionItemModel.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['seq'] = this.seq;
    data['active'] = this.active;
    data['name'] = this.name;
    data['name_lang'] = this.nameLang;
    data['type'] = this.type;
    data['description'] = this.description;
    data['description_lang'] = this.descriptionLang;
    data['tags'] = this.tags;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductOptionItemModel {
  int id;
  int? seq;
  bool? active;
  String? code;
  String? name;
  String? nameLang;
  String? description;
  int? cost;
  int? price;
  int? discount;
  int? discountPc;
  List? tags;
  List? imageIds;
  List? imagePaths;
  String? createTime;
  String? updateTime;

  ProductOptionItemModel(
      {required this.id,
      this.seq,
      this.active,
      this.code,
      this.name,
      this.nameLang,
      this.description,
      this.cost,
      this.price,
      this.discount,
      this.discountPc,
      this.tags,
      this.imageIds,
      this.imagePaths,
      this.createTime,
      this.updateTime});

  ProductOptionItemModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        seq = json['seq'],
        active = json['active'],
        code = json['code'],
        name = json['name'],
        nameLang = json['name_lang'],
        description = json['description'],
        cost = json['cost'],
        price = json['price'],
        discount = json['discount'],
        discountPc = json['discountPc'],
        tags = json['tags'],
        imageIds = json['imageIds'],
        imagePaths = json['imagePaths'],
        createTime = json['createTime'],
        updateTime = json['updateTime'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seq'] = this.seq;
    data['active'] = this.active;
    data['code'] = this.code;
    data['name'] = this.name;
    data['name_lang'] = this.nameLang;
    data['description'] = this.description;
    data['cost'] = this.cost;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['discountPc'] = this.discountPc;
    data['tags'] = this.tags;
    data['imageIds'] = this.imageIds;
    data['imagePaths'] = this.imagePaths;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    return data;
  }
}
