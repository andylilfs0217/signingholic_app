class MemberTierModel {
  int id;
  String? name;

  MemberTierModel({required this.id, this.name});

  MemberTierModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] is int ? json['id'] : int.parse(json['id']),
        name = json['name'];

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
