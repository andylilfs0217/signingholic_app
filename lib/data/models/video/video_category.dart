class VideoCategoryModel {
  final int id;
  final String name;

  VideoCategoryModel(
    this.id,
    this.name,
  );

  VideoCategoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'name': this.name,
      };
}
