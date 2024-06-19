import 'package:workplace/features/data/models/user_response_model.dart';

class BirthdayDataModel {
  List<BirthdayData>? data;
  String? message;

  BirthdayDataModel({this.data, this.message});

  BirthdayDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data =<BirthdayData>[];
      json['data'].forEach((v) {
        data!.add(new BirthdayData.fromJson(v));
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

class BirthdayData {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? profilePhoto;
  String? jobTitle;
  String? dob;
  String? description;
  User? user;

  BirthdayData(
      {this.id,
        this.name,
        this.firstName,
        this.lastName,
        this.profilePhoto,
        this.jobTitle,
        this.dob,
        this.description,
        this.user});

  BirthdayData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profilePhoto = json['profile_photo'];
    jobTitle = json['job_title'];
    dob = json['dob'];
    description = json['description'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['profile_photo'] = this.profilePhoto;
    data['job_title'] = this.jobTitle;
    data['dob'] = this.dob;
    data['description'] = this.description;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

