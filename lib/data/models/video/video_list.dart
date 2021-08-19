import 'package:equatable/equatable.dart';
import 'package:singingholic_app/data/models/video/video.dart';

class VideoListModel extends Equatable {
  late final int count;
  late final List<VideoModel> results;

  VideoListModel({
    required this.count,
    required this.results,
  });

  @override
  List<Object> get props => [count, results];

  VideoListModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    results = json['results']
        .map<VideoModel>((e) => new VideoModel.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['results'] = this.results.map((e) => e.toJson()).toList();
    return data;
  }
}
