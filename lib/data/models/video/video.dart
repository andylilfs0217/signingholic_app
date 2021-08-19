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
        'id': this.id,
        'free': this.free,
        'status': this.status,
        'featured': this.featured,
        'name': this.name,
        'name_lang': this.nameLang,
        'description': this.description,
        'description_lang': this.descriptionLang,
        'price': this.price,
        'discount': this.discount,
        'discountPc': this.discountPc,
        'youTubeId': this.youTubeId,
        'youTubePublishedAt': this.youTubePublishedAt,
        'tags': this.tags,
        'imageIds': this.imageIds,
        'imagePaths': this.imagePaths,
        'createTime': this.createTime,
        'updateTime': this.updateTime,
        'categories': this.categories?.map((e) => e.toJson()).toList(),
      };
}
