class SinglePostModel {
  SinglePostData? data;
  String? message;

  SinglePostModel({this.data, this.message});

  SinglePostModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SinglePostData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class SinglePostData {
  int? id;
  String? title;
  String? postCategory;
  String? featuredImage;
  String? content;
  String? publishedAt;
  String? createdAt;
  String? postBy;
  String? profilePhoto;
  String? backgoundColor;
  String? textColor;
  int? likes;
  bool? isLike;

  SinglePostData(
      {this.id,
        this.title,
        this.postCategory,
        this.featuredImage,
        this.content,
        this.publishedAt,
        this.createdAt,
        this.postBy,
        this.profilePhoto,
        this.backgoundColor,
        this.textColor,
        this.likes,
        this.isLike});

  SinglePostData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    postCategory = json['post_category'];
    featuredImage = json['featured_image'];
    content = json['content'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    postBy = json['post_by'];
    profilePhoto = json['profile_photo'];
    backgoundColor = json['backgound_color'];
    textColor = json['text_color'];
    likes = json['likes'];
    isLike = json['is_like'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['post_category'] = this.postCategory;
    data['featured_image'] = this.featuredImage;
    data['content'] = this.content;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['post_by'] = this.postBy;
    data['profile_photo'] = this.profilePhoto;
    data['backgound_color'] = this.backgoundColor;
    data['text_color'] = this.textColor;
    data['likes'] = this.likes;
    data['is_like'] = this.isLike;
    return data;
  }
}
