class FeedDataModel {
  List<FeedData>? data;
  String? message;
  FeedPagination? pagination;

  FeedDataModel({this.data, this.message, this.pagination});

  FeedDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <FeedData>[];
      json['data'].forEach((v) {
        data!.add(new FeedData.fromJson(v));
      });
    }
    message = json['message'];
    pagination = json['pagination'] != null
        ? new FeedPagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}


class FeedData {
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

  FeedData(
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

  FeedData.fromJson(Map<String, dynamic> json) {
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

class FeedPagination {
  int? currentPage;
  String? prevPageApiUrl;
  String? nextPageApiUrl;
  int? perPage;

  FeedPagination(
      {this.currentPage,
        this.prevPageApiUrl,
        this.nextPageApiUrl,
        this.perPage});

  FeedPagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    prevPageApiUrl = json['prev_page_api_url'];
    nextPageApiUrl = json['next_page_api_url'];
    perPage = json['per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['prev_page_api_url'] = this.prevPageApiUrl;
    data['next_page_api_url'] = this.nextPageApiUrl;
    data['per_page'] = this.perPage;
    return data;
  }
}
