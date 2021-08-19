import 'package:singingholic_app/data/models/video/video_category.dart';

class VideoModel {
  final int id;
  final bool? free;
  final String? status;
  final bool? featured;
  final String? name;
  final String? nameLang;
  final String? description;
  final String? descriptionLang;
  final int? price;
  final int? discount;
  final int? discountPc;
  final String? youTubeId;
  final String? youTubePublishedAt;
  final List? tags;
  final List? imageIds;
  final List? imagePaths;
  final String? createTime;
  final String? updateTime;
  final List? categories;

  VideoModel(
    this.id,
    this.free,
    this.status,
    this.name,
    this.nameLang,
    this.description,
    this.price,
    this.discount,
    this.discountPc,
    this.youTubeId,
    this.youTubePublishedAt,
    this.tags,
    this.imageIds,
    this.imagePaths,
    this.createTime,
    this.updateTime,
    this.featured,
    this.descriptionLang,
    this.categories,
  );

  VideoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        free = json['free'],
        status = json['status'],
        featured = json['featured'],
        name = json['name'],
        nameLang = json['name_lang'],
        description = json['description'],
        descriptionLang = json['description_lang'],
        price = json['price'],
        discount = json['discount'],
        discountPc = json['discountPc'],
        youTubeId = json['youTubeId'],
        youTubePublishedAt = json['youTubePublishedAt'],
        tags = json['tags'],
        imageIds = json['imageIds'],
        imagePaths = json['imagePaths'],
        createTime = json['createTime'],
        updateTime = json['updateTime'],
        categories = json['categories']
            ?.map((e) => new VideoCategoryModel.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'free': free,
        'status': status,
        'featured': featured,
        'name': name,
        'name_lang': nameLang,
        'description': description,
        'description_lang': descriptionLang,
        'price': price,
        'discount': discount,
        'discountPc': discountPc,
        'youTubeId': youTubeId,
        'youTubePublishedAt': youTubePublishedAt,
        'tags': tags,
        'imageIds': imageIds,
        'imagePaths': imagePaths,
        'createTime': createTime,
        'updateTime': updateTime,
        'categories': categories?.map((e) => e.toJson()).toList(),
      };
}
