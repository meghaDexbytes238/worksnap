class UserResponseModel {
  User? user;
  String? message;

  UserResponseModel({this.user, this.message});

  UserResponseModel.fromJson(Map<String, dynamic> json) {
    user = json['data'] != null ? User.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.user != null) {
      data['data'] = this.user!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? countryCode;
  String? phone;
  List<RoleId>? roleId;
  String? emailVerifiedAt;
  String? phoneVerifiedAt;
  String? rememberToken;
  String? lastLogin;
  bool? globalNotifications;
  String? defaultLang;
  List<dynamic>? device;
  String? profilePhoto;
  int? messageCount;
  int? notificationCount;
  int? status;
  String? displayMessage;
  bool? isBlockAccount;
  String? jobTitle;
  String? address;
  String? alternativeAddress;
  String? alternativePhone;
  String? dob;
  String? doj;
  int? marriageStatus;
  String? marriageAnniversaryDate;
  String? skills;
  String? gender;
  String? skype;
  String? githubUsername;
  String? bitbucketUsername;
  String? createdAt;
  String? updatedAt;
  bool? enableDelete;
  bool? enableLeaveApply;
  List<Leads>? leads;

  User(
      {
        this.id,
        this.name,
        this.firstName,
      this.lastName,
      this.email,
        this.countryCode,
      this.phone,
        this.leads,
      this.roleId,
      this.emailVerifiedAt,
      this.phoneVerifiedAt,
      this.rememberToken,
      this.lastLogin,
      this.globalNotifications,
      this.defaultLang,
      this.device,
      this.profilePhoto,
      this.messageCount,
      this.notificationCount,
      this.status,
      this.displayMessage,
      this.isBlockAccount,
      this.jobTitle,
      this.address,
      this.alternativeAddress,
      this.alternativePhone,
      this.dob,
        this.doj,
        this.marriageStatus,
        this.marriageAnniversaryDate,
        this.skills,
      this.gender,
      this.skype,
      this.githubUsername,
      this.bitbucketUsername,
      this.createdAt,
      this.updatedAt,
        this.enableDelete,
        this.enableLeaveApply,
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    countryCode = json['country_code'];
    phone = json['phone'];
    if (json['role_id'] != null) {
      roleId = <RoleId>[];
      json['role_id'].forEach((v) {
        roleId!.add(RoleId.fromJson(v));
      });
    }
    emailVerifiedAt = json['email_verified_at'];
    phoneVerifiedAt = json['phone_verified_at'];
    rememberToken = json['remember_token'];
    lastLogin = json['last_login'];
    globalNotifications = json['global_notifications'];
    defaultLang = json['default_lang'];
    device = json['device'] ?? [];
    profilePhoto = json['profile_photo'];
    messageCount = json['message_count'];
    notificationCount = json['notification_count'];
    status = json['status'];
    displayMessage = json['display_message'];
    isBlockAccount = json['is_block_account'];
    jobTitle = json['job_title'];
    address = json['address'];
    alternativeAddress = json['alternative_address'];
    alternativePhone = json['alternative_phone'];
    dob = json['dob'];
    doj = json['doj'];
    marriageStatus = json['marriage_status'];
    marriageAnniversaryDate = json['marriage_anniversary_date'];
    skills = json['skills'];
    gender = json['gender'];
    skype = json['skype'];
    githubUsername = json['github_username'];
    bitbucketUsername = json['bitbucket_username'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    enableDelete = json['enable_delete'];
    enableLeaveApply = json['enable_leave_apply'];
    if (json['leads'] != null) {
      leads =  <Leads>[];
      json['leads'].forEach((v) {
        leads!.add( Leads.fromJson(v));
      });
    }
      }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['phone'] = this.phone;
    if (this.roleId != null) {
      data['role_id'] = this.roleId!.map((v) => v.toJson()).toList();
    }
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone_verified_at'] = this.phoneVerifiedAt;
    data['remember_token'] = this.rememberToken;
    data['last_login'] = this.lastLogin;
    data['global_notifications'] = this.globalNotifications;
    data['default_lang'] = this.defaultLang;
    data['device'] = this.device;
    data['profile_photo'] = this.profilePhoto;
    data['message_count'] = this.messageCount;
    data['notification_count'] = this.notificationCount;
    data['status'] = this.status;
    data['display_message'] = this.displayMessage;
    data['is_block_account'] = this.isBlockAccount;
    data['job_title'] = this.jobTitle;
    data['address'] = this.address;
    data['alternative_address'] = this.alternativeAddress;
    data['alternative_phone'] = this.alternativePhone;
    data['dob'] = this.dob;
    data['doj'] = this.doj;
    data['marriage_status'] = this.marriageStatus;
    data['marriage_anniversary_date'] = this.marriageAnniversaryDate;
    data['skills'] = this.skills;
    data['gender'] = this.gender;
    data['skype'] = this.skype;
    data['github_username'] = this.githubUsername;
    data['bitbucket_username'] = this.bitbucketUsername;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['enable_delete'] = this.enableDelete;
    if (this.leads != null) {
      data['leads'] = this.leads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class RoleId {
  String? name;

  RoleId({this.name});

  RoleId.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Leads {
  int? leadId;
  String? name;
  String? firstName;
  String? lastName;
  String? jobTitle;
  String? email;
  String? phone;
  String? profilePhoto;

  Leads(
      {this.leadId,
        this.name,
        this.firstName,
        this.lastName,
        this.jobTitle,
        this.email,
        this.phone,
        this.profilePhoto});

  Leads.fromJson(Map<String, dynamic> json) {
    leadId = json['lead_id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    jobTitle = json['job_title'];
    email = json['email'];
    phone = json['phone'];
    profilePhoto = json['profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lead_id'] = this.leadId;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['job_title'] = this.jobTitle;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['profile_photo'] = this.profilePhoto;
    return data;
  }
}


