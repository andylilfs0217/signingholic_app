import 'package:singingholic_app/data/models/member/member.dart';
import 'package:singingholic_app/data/models/video/video.dart';

class VideoSubmissionModel {
  final int id;
  final MemberModel member;
  final VideoModel parentVideo;
  final String path;
  final DateTime createTime;
  final DateTime updateTime;

  VideoSubmissionModel({
    required this.id,
    required this.member,
    required this.parentVideo,
    required this.path,
    required this.createTime,
    required this.updateTime,
  });

  VideoSubmissionModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        member = MemberModel.fromJson(json['member']),
        parentVideo = VideoModel.fromJson(json['parentVideo']),
        path = json['path'],
        createTime = DateTime.parse(json['createTime']),
        updateTime = DateTime.parse(json['updateTime']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'member': member.toJson(),
        'parentVideo': parentVideo.toJson(),
        'path': path,
      };
}
