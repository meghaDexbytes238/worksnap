class FamilyModel {
  List<FamilyData>? data;
  String? message;

  FamilyModel({this.data, this.message});

  FamilyModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <FamilyData>[];
      json['data'].forEach((v) {
        data!.add(new FamilyData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class FamilyData {
  int? id;
  String? name;
  String? dob;
  String? relation;
  String? photo;
  String? filename;

  FamilyData({this.id, this.name, this.dob, this.relation, this.photo});

  FamilyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dob = json['dob'];
    relation = json['relation'];
    photo = json['photo'];
    filename = json['filename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['relation'] = this.relation;
    data['photo'] = this.photo;
    data['filename'] = this.filename;
    return data;
  }
}
