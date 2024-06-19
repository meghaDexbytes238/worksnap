class EventDataModel {
  List<EventData>? data;
  String? message;

  EventDataModel({this.data, this.message});

  EventDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data =<EventData>[];
      json['data'].forEach((v) {
        data!.add(new EventData.fromJson(v));
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

class EventData {
  String? title;
  String? description;
  String? startDate;
  String? endDate;
  int? totalDays;

  EventData(
      {this.title,
        this.description,
        this.startDate,
        this.endDate,
        this.totalDays});

  EventData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    totalDays = json['total_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['total_days'] = this.totalDays;
    return data;
  }
}
