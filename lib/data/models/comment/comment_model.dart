import 'package:singingholic_app/data/models/member/member.dart';

class CommentModel {
  int id;
  MemberModel? member;
  String? comment;
  num? stars;
  DateTime? createTime;
  DateTime? updateTime;

  CommentModel(
      {required this.id,
      this.member,
      this.comment,
      this.stars,
      this.createTime,
      this.updateTime});

  CommentModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        member = json['member'] != null
            ? MemberModel.fromJson(json['member'])
            : null,
        comment = json['comment'],
        stars = json['stars'],
        createTime = json['createTime'] != null
            ? DateTime.parse(json['createTime'])
            : null,
        updateTime = json['updateTime'] != null
            ? DateTime.parse(json['updateTime'])
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'member': member?.toJson(),
        'comment': comment,
        'stars': stars,
        'createTime': createTime,
        'updateTime': updateTime
      };
}
