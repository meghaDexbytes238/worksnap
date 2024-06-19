abstract class ConstantC {
  static const String imageNotFoundC = 'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png';
  static const defaultProfileImage ="https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Windows_10_Default_Profile_Picture.svg/2048px-Windows_10_Default_Profile_Picture.svg.png";
  static String getGoogleMapStaticImageUrl(
          {String address = "",
          var latitude,
          var longitude,
          String googleMapKey = ""}) =>
      "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&"
      "zoom=6&"
      "size=600x300%20&"
      "markers=color:0xffc3f5%7Clabel:%7C$latitude,$longitude&"
      "style=feature:road%7Celement:geometry%7Cvisibility:simplified%7Ccolor:0xf5f5f5&"
      "style=feature:water|color:0xc9c9c9&"
      "key=%20$googleMapKey";
}
abstract class ApiConst {
  static const bool isProduction = false ;
  static const String baseUrlDevC = 'https://cms-api.dexbytes.in/'; //Development
  static const String baseUrlProC = 'https://api-hrms.dexbytes.com/'; // Production
  //API Constants

  static const String userLogin =
      '${isProduction ? baseUrlProC : baseUrlDevC}api/customer/login-by-email';
  static const String userLogout =
      '${isProduction ? baseUrlProC : baseUrlDevC}api/customer/logout';
  static const String userProfile =
      '${isProduction ? baseUrlProC : baseUrlDevC}api/customer/profile';
  static const String teamDetails =
      '${isProduction ? baseUrlProC : baseUrlDevC}api/user';
  static const String deleteProfile =
      '${isProduction ? baseUrlProC : baseUrlDevC}api/customer/delete';
  static const String profileUpdate =
      '${isProduction ? baseUrlProC : baseUrlDevC}api/customer/profile-update';
  static const String faqUser =
      '${isProduction ? baseUrlProC : baseUrlDevC}api/faq/user/member';
  static const String aboutUs =
      '${isProduction ? baseUrlProC : baseUrlDevC}api/page/get-by-slug/about-us';
  static const String changePasswords =
      '${isProduction ? baseUrlProC : baseUrlDevC}api/customer/change-password';
  static const String updateProfilePhotos =
      '${isProduction ? baseUrlProC : baseUrlDevC}api/media';
  static const String homeData =
      '${isProduction ? baseUrlProC : baseUrlDevC}api/home';
  static const String birthdayData =
      '${isProduction ? baseUrlProC : baseUrlDevC}api/birthday/list';
  static const String workAnniversaryData =
      '${isProduction ? baseUrlProC : baseUrlDevC}api/workanniversary/list';
  static const String marriageAnniversaryData =
      '${isProduction ? baseUrlProC : baseUrlDevC}api/marriageanniversary/list';
  static const String eventData =
      '${isProduction ? baseUrlProC : baseUrlDevC}api/events';

  static const String holidayData =
      '${isProduction ? baseUrlProC : baseUrlDevC}api/holidays';

  static const String feedPostData =
      '${isProduction ? baseUrlProC : baseUrlDevC}api/posts';

  static const String leaveType =
      '${isProduction ? baseUrlProC : baseUrlDevC}api/leave/types';

  static const String leaveApply =
      '${isProduction ? baseUrlProC : baseUrlDevC}api/leaves';

  static const String leaveDataList =
      '${isProduction ? baseUrlProC : baseUrlDevC}api/leaves';

  static const String notificationDataList = '${isProduction ? baseUrlProC : baseUrlDevC}api/customer/notifications';

  static const String postLikeApi = '${isProduction ? baseUrlProC : baseUrlDevC}api/posts/like';

  static const String singleNotificationPostApi = '${isProduction ? baseUrlProC : baseUrlDevC}api/posts';

  static const String leaveDataByID = '${isProduction ? baseUrlProC : baseUrlDevC}api/leaves';

  static const String teamLeaveData = '${isProduction ? baseUrlProC : baseUrlDevC}api/team/leaves';

  static const String leaveStatusChange = '${isProduction ? baseUrlProC : baseUrlDevC}api/team/leaves/status';

  static const String teamLeaveDataByID = '${isProduction ? baseUrlProC : baseUrlDevC}api/team/leaves';

  static const String notificationDisplay = '${isProduction ? baseUrlProC : baseUrlDevC}api/customer/notification/display';

  static const String notificationRead = '${isProduction ? baseUrlProC : baseUrlDevC}api/customer/notification/read';

  static const String notificationReadDisplay = '${isProduction ? baseUrlProC : baseUrlDevC}api/customer/notification/read-display';

  static const String familyApi = '${isProduction ? baseUrlProC : baseUrlDevC}api/family';

  }
