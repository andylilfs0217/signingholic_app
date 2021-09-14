import 'package:singingholic_app/data/models/member/member.dart';

class CommentModel {
  int id;
  MemberModel member;
  String comment;
  num? stars;
  DateTime createTime;
  DateTime updateTime;

  CommentModel(
      {required this.id,
      required this.member,
      required this.comment,
      this.stars,
      required this.createTime,
      required this.updateTime});

  CommentModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        member = MemberModel.fromJson(json['member']),
        comment = json['comment'],
        stars = json['stars'],
        createTime = DateTime.parse(json['createTime']),
        updateTime = DateTime.parse(json['updateTime']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'member': member.toJson(),
        'comment': comment,
        'stars': stars,
        'createTime': createTime,
        'updateTime': updateTime
      };
}
