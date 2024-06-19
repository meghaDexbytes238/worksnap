import 'package:http/http.dart' as http;
import 'package:platform_detector/enums.dart';
import 'package:platform_detector/platform_detector.dart';
import 'package:workplace/imports.dart';

class WorkplaceDataSourcesImpl implements WorkplaceDataSources {
  String? token;
  String? deviceId;
  String? deviceName;
  String? deviceVersion;
  String? deviceToken;
  String? deviceTypeName;
  String? profilePhoto;

  WorkplaceDataSourcesImpl() {
    final PlatformType currentPlatformType = PlatformDetector.platform.type;
    PrefUtils()
        .readStr(WorkplaceNotificationConst.accessTokenC)
        .then((value) => token = value);

    if(currentPlatformType == PlatformType.mobile){
      deviceTypeName = Platform.isAndroid ? "android" : "ios";
    }
    else if(currentPlatformType == PlatformType.web){
      deviceTypeName = "web";
    }
    else {
      deviceTypeName = "desktop";
    }

  }

  @override
  Future<Map<String, dynamic>> loinUser(
      {required UserLoginParams userDetails}) async {
    http.Response response = await http.post(
      Uri.parse(ApiConst.userLogin),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': userDetails.email,
        'password': userDetails.password,
        'deviceId': userDetails.deviceId,
        'deviceName': userDetails.deviceName,
        'fcmToken': userDetails.fcmToken,
        'deviceVersion': userDetails.deviceVersion,
       // 'deviceType': userDetails.deviceType,
      }),
    );

    debugPrint(
        'URL ======== ${ApiConst.userLogin} STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      //parse your modal here
      await PrefUtils().saveStr(WorkplaceNotificationConst.accessTokenC,
          json.decode(response.body)["data"]["token"]);
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: json.decode(response.body)['error']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getUserProfile() async {
    await PrefUtils()
        .readStr(WorkplaceNotificationConst.accessTokenC)
        .then((value) => token = value);
    http.Response response = await http.get(
      Uri.parse(ApiConst.userProfile),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint(
        'URL ======== ${ApiConst.userProfile} STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      //parse your modal here
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: json.decode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getUserLogout({ required UserLogoutParams userLogoutParams}) async {
    String url = "${ApiConst.userLogout}/${userLogoutParams.deviceId}";
    http.Response response = await http.get(Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint(
        'URL ======== ${ApiConst.userLogout} STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      //parse your modal here
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: json.decode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getTeamDetails() async {
    http.Response response = await http.get(
      Uri.parse(ApiConst.teamDetails),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint(
        'URL ======== ${ApiConst.teamDetails} STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');
    if (response.statusCode == 200) {
      //parse your modal here

      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: json.decode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> deleteUser() async {
    http.Response response = await http.get(
      Uri.parse(ApiConst.deleteProfile),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint(
        'URL ======== ${ApiConst.deleteProfile} STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      //parse your modal here
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: json.decode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> profileUpdate(
      {required ProfileUpdateParams profileUpdateParams}) async {
    Map<String, dynamic> parameters = {};
    http.Response? response;

    parameters.clear();
    if (profileUpdateParams.globalNotifications != null) {
      parameters['global_notifications'] =
          profileUpdateParams.globalNotifications;
    }
    if (profileUpdateParams.profilePhoto != null) {
      parameters['profile_photo'] = profileUpdateParams.profilePhoto;
    }

    response = await http.post(Uri.parse(ApiConst.profileUpdate),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(parameters));

    debugPrint(
        'URL ======== ${ApiConst.profileUpdate} STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      //parse your modal here
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: json.decode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getFaq() async {
    http.Response response = await http.get(
      Uri.parse(ApiConst.faqUser),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint(
        'URL ======== ${ApiConst.faqUser} STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      //parse your modal here
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: json.decode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getNotification() async {
    http.Response response = await http.get(
      Uri.parse(ApiConst.notificationDataList),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint(
        'URL ======== ${ApiConst.notificationDataList} STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      //parse your modal here
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: json.decode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getAboutUs() async {
    http.Response response = await http.get(
      Uri.parse(ApiConst.aboutUs),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint(
        'URL ======== ${ApiConst.aboutUs} STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      //parse your modal here
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: json.decode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> postChangePassword(
      {required ChangePasswordParams changePasswordParams}) async {
    http.Response response = await http.post(
      Uri.parse(ApiConst.changePasswords),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'old_password': changePasswordParams.oldPassword,
        'password': changePasswordParams.newPassword,
        'password_confirmation': changePasswordParams.confirmPassword
      }),
    );

    debugPrint(
        'URL ======== ${ApiConst.changePasswords} STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      //parse your modal here
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: json.decode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> postUploadMedia(
      {required UploadMediaParams params}) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiConst.updateProfilePhotos));
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    request.headers.addAll(headers);
    request.files
        .add(await http.MultipartFile.fromPath('file', params.filePath));
    request.fields['collection_name'] = params.collectionName;
    var rawResponse = await request.send();

    var response = await http.Response.fromStream(rawResponse);

    debugPrint(
        'URL ======== ${ApiConst.updateProfilePhotos} STATUS = ${rawResponse.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (rawResponse.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (rawResponse.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: jsonDecode(response.body)['error']);
    } else if (rawResponse.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getHomeData() async {
    http.Response response = await http.get(
      Uri.parse(ApiConst.homeData),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    debugPrint(
        'URL ======== ${ApiConst.homeData} STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      //parse your modal here
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: json.decode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getBirthdayData() async {
    http.Response response = await http.get(
      Uri.parse(ApiConst.birthdayData),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint(
        'URL ======== ${ApiConst.birthdayData} STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      //parse your modal here
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: json.decode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getMarriageAnniversaryData() async {
    http.Response response = await http.get(
      Uri.parse(ApiConst.marriageAnniversaryData),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint(
        'URL ======== ${ApiConst.marriageAnniversaryData} STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      //parse your modal here
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: json.decode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getWorkAnniversaryData() async {
    http.Response response = await http.get(
      Uri.parse(ApiConst.workAnniversaryData),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint(
        'URL ======== ${ApiConst.workAnniversaryData} STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      //parse your modal here
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: json.decode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getEventData() async {
    http.Response response = await http.get(
      Uri.parse(ApiConst.eventData),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint(
        'URL ======== ${ApiConst.eventData} STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      //parse your modal here
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: json.decode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getHolidayData() async {
    http.Response response = await http.get(
      Uri.parse(ApiConst.holidayData),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint(
        'URL ======== ${ApiConst.holidayData} STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      //parse your modal here
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: json.decode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getFeedData({required feedParams}) async {
    http.Response response = await http.get(
      Uri.parse(feedParams.url ?? ApiConst.feedPostData),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint(
        'URL ======== ${ApiConst.feedPostData} STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: jsonDecode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getLeaveType() async {
    http.Response response = await http.get(
      Uri.parse(ApiConst.leaveType),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint(
        'URL ======== ${ApiConst.leaveType} STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: jsonDecode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> postLeaveApply(
      {required leaveApplyParams}) async {
    http.Response response = await http.post(
      Uri.parse(ApiConst.leaveApply),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'leave_type_id': leaveApplyParams.leaveTypeID,
        'reason': leaveApplyParams.reason,
        'duration': leaveApplyParams.duration,
        'start_date': leaveApplyParams.startDate,
        'end_date': leaveApplyParams.endDate
      }),
    );

    debugPrint(
        'URL ======== ${ApiConst.leaveApply} STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      //parse your modal here
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: json.decode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getLeaveData({required leaveParams}) async {
    http.Response response = await http.get(
      Uri.parse(leaveParams.url ?? ApiConst.leaveDataList),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint(
        'URL ======== ${ApiConst.leaveDataList} STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: jsonDecode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> postLikeRequest(
      {required PostLikeParams postLikeParams}) async {
    String url = "${ApiConst.postLikeApi}/${postLikeParams.postId.toString()}";
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    debugPrint('URL ======== $url STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      //parse your modal here
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: json.decode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getSinglePost(
      {required singlePostParams}) async {
    String url = "${ApiConst.singleNotificationPostApi}/${singlePostParams.postId.toString()}";
    http.Response response = await http.get(Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    debugPrint('URL ======== $url STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      //parse your modal here
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: json.decode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getLeaveDetailById(
      {required LeaveDetailParams leaveDetailParams}) async {
    String url =
        "${ApiConst.leaveDataByID}/${leaveDetailParams.postId.toString()}";
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    debugPrint('URL ======== $url STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      //parse your modal here
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: json.decode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getTeamLeaveData() async {
    http.Response response = await http.get(
      Uri.parse(ApiConst.teamLeaveData),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint(
        'URL ======== ${ApiConst.teamLeaveData} STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: jsonDecode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> postLeaveStatusApply(
      {required LeaveStatusChangeParams leaveStatusChangeParams}) async {
    http.Response response = await http.post(
      Uri.parse(ApiConst.leaveStatusChange),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'id': leaveStatusChangeParams.leaveId,
        'status': leaveStatusChangeParams.status,
      }),
    );

    debugPrint(
        'URL ======== ${ApiConst.leaveStatusChange} STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      //parse your modal here
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: json.decode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getTeamLeaveDetailById(
      {required TeamLeaveDetailParams teamLeaveDetailParams}) async {
    String url =
        "${ApiConst.teamLeaveDataByID}/${teamLeaveDetailParams.postId.toString()}";
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    debugPrint('URL ======== $url STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      //parse your modal here
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: json.decode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> putMarkNotificationDisplayed() async {
    http.Response response = await http.put(
      Uri.parse(ApiConst.notificationDisplay),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    debugPrint(
        'URL ======== ${ApiConst.notificationDisplay} STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: jsonDecode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> putMarkNotificationRead(
      {required MarkNotificationReadParams markNotificationReadParams}) async {
    String url =
        "${ApiConst.notificationRead}/${markNotificationReadParams.messageID.toString()}";
    http.Response response = await http.put(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint('URL ======== $url STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: jsonDecode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> putMarkNotificationReadDisplay(
      {required MarkNotificationReadDisplayParams
          markNotificationReadDisplayParams}) async {
    String url =
        "${ApiConst.notificationReadDisplay}/${markNotificationReadDisplayParams.messageID.toString()}";
    http.Response response = await http.put(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint('URL ======== $url STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: jsonDecode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getFamilyDataList() async {
    http.Response response =
        await http.get(Uri.parse(ApiConst.familyApi), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    debugPrint(
        'URL ======== ${ApiConst.familyApi} STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: jsonDecode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> deleteFamilyMember(
      {required FamilyParams familyParams}) async {
    String url = "${ApiConst.familyApi}/${familyParams.familyId.toString()}";
    http.Response response = await http.delete(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    debugPrint('URL ======== $url STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: jsonDecode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> postFamilyMemberDetails(
      {required AddFamilyMemberParams addFamilyMemberParams}) async {
    http.Response response =
        await http.post(Uri.parse(ApiConst.familyApi), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'name': addFamilyMemberParams.name,
      'dob': addFamilyMemberParams.dob,
      'relation': addFamilyMemberParams.relation,
      'photo': addFamilyMemberParams.photo,
    });

    debugPrint(
        'URL ======== ${ApiConst.familyApi} STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: jsonDecode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> putFamilyMemberDetails(
      {required EditFamilyMemberParams editFamilyMemberParams}) async {
    String url =
        "${ApiConst.familyApi}/${editFamilyMemberParams.familyId.toString()}";
    http.Response response = await http.put(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'name': editFamilyMemberParams.name,
      'dob': editFamilyMemberParams.dob,
      'relation': editFamilyMemberParams.relation,
      'photo': editFamilyMemberParams.photo,
    });

    debugPrint('URL ======== $url STATUS = ${response.statusCode}');
    debugPrint('response=====${json.decode(response.body)}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      throw DataNotFoundException(
          errorMessage: jsonDecode(response.body)['error']);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }
}
