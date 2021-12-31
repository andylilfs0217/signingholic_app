class AccountModel {
  bool memberPointsEnabled;
  bool hasFacebookProductToken;
  bool hasInstagramToken;

  AccountModel(
      {this.memberPointsEnabled = false,
      this.hasFacebookProductToken = false,
      this.hasInstagramToken = false});

  AccountModel.fromJson(Map<String, dynamic> json)
      : memberPointsEnabled = json['memberPointsEnabled'],
        hasFacebookProductToken = json['hasFacebookProductToken'],
        hasInstagramToken = json['hasInstagramToken'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['memberPointsEnabled'] = this.memberPointsEnabled;
    data['hasFacebookProductToken'] = this.hasFacebookProductToken;
    data['hasInstagramToken'] = this.hasInstagramToken;
    return data;
  }
}
