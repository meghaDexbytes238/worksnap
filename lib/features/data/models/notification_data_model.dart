class NotificationDataModel {
  List<NotificationDataList>? data;
  String? message;

  NotificationDataModel({this.data, this.message});

  NotificationDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <NotificationDataList>[];
      json['data'].forEach((v) {
        data!.add(new NotificationDataList.fromJson(v));
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

class NotificationDataList {
  int? id;
  int? isRead;
  int? isDisplayed;
  bool? shouldVisible;
  String? title;
  String? body;
  NotificationData? data;
  String? sendAt;

  NotificationDataList(
      {this.id,
        this.isRead,
        this.isDisplayed,
        this.shouldVisible,
        this.title,
        this.body,
        this.data,
        this.sendAt});

  NotificationDataList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isRead = json['is_read'];
    isDisplayed = json['is_displayed'];
    shouldVisible = json['should_visible'];
    title = json['title'];
    body = json['body'];
    data = json['data'] != null ? new NotificationData.fromJson(json['data']) : null;
    sendAt = json['send_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_read'] = this.isRead;
    data['is_displayed'] = this.isDisplayed;
    data['should_visible'] = this.shouldVisible;
    data['title'] = this.title;
    data['body'] = this.body;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['send_at'] = this.sendAt;
    return data;
  }
}

class NotificationData {
  int? leaveId;
  int? postId;
  String? type;
  String? postCategory;

  NotificationData({this.leaveId,this.postId, this.type, this.postCategory});

  NotificationData.fromJson(Map<String, dynamic> json) {
    leaveId = json['leaveId'];
    postId = json['postId'];
    type = json['type'];
    postCategory = json['post_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leaveId'] = this.leaveId;
    data['postId'] = this.postId;
    data['type'] = this.type;
    data['post_category'] = this.postCategory;
    return data;
  }
}