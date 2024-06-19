class AboutUsModal {
  List<AboutData>? aboutData;
  String? message;

  AboutUsModal({this.aboutData, this.message});

  AboutUsModal.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      aboutData = <AboutData>[];
      json['data'].forEach((v) {
        aboutData!.add(new AboutData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aboutData != null) {
      data['data'] = this.aboutData!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class AboutData {
  int? id;
  String? title;
  String? slug;
  String? content;
  String? status;
  int? userId;
  String? userName;
  String? postType;
  String? createdAt;
  String? updatedAt;

  AboutData(
      {this.id,
      this.title,
      this.slug,
      this.content,
      this.status,
      this.userId,
      this.userName,
      this.postType,
      this.createdAt,
      this.updatedAt});

  AboutData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    content = json['content'];
    status = json['status'];
    userId = json['user_id'];
    userName = json['user_name'];
    postType = json['post_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['content'] = this.content;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['post_type'] = this.postType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
