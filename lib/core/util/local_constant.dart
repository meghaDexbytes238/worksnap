//Shared Preferences Constants
abstract class WorkplaceNotificationConst {
  static const String selectedLanguageEnglishC = 'lang_eng';
  static const String selectedLanguageC = 'selected_app_language';
  static const String accessTokenC = 'access_token';
  static const String deviceTokenC = 'device_token';
  static const String anyNewNotificationC = 'anyNewNotification';
  static const String globalNotificationC = 'globalNotification';

  static const String isUserLoggedInC = 'is_user_logged_in';
  static const String isUserFirstTime = 'is_user_first_time' ;
  static const String isUserDeleted = 'is_user_deleted';
  static const String loggedInUserApiResponse = 'logged_in_user_api_response';
  static const String profileSetUpStepLocal = 'profile_set_up_step_local';
  static const String isIsTutorialSeenC = 'is_tutorial_seen';
  static const String isOneTimeProfileSetUpDoneC =
      'is_one_time_profile_setup_done';
  static const String loggedInUserDetails = 'logged_in_user_details';
  static const String languageCodeC = 'language';
  static const String deviceIdC = 'device_id';
  static const String deviceNameC = 'device_name';
  static const String deviceModelC = 'device_model';
  static const String deviceTypeC = 'device_type';
  static const String deviceOsVersionC = 'device_os_version';
  static const String appVersionVersionC = 'app_version';
  static const String totalNotificationCount = 'total_notification_count';
  static const String chatNotificationCount = 'chat_notification_count';
  static const String userProfileImageC = 'user_profile_image';
  static const String userAutoLoginDetails =
      'user_auto_login_details'; //In this we will store logged in user details

  static const String isNotFirstTime = 'is_not_first_time';
  static const String userProfileImageThumbnailC =
      'user_profile_image_thumbnail';

  static const String selectedLanguageKoreanC = 'selected_language_korean';
  static const String notificationUnreadCountC = 'notification_unread_count';
  static const String userFullNameC = 'user_name';
  static const String userEmailC = 'user_email';
  static const String userLoggedInPasswordC = 'user_password';

  static const String anotherUserChatUidC = 'another_firebase_chat_uid';
  static const String userFirstName = 'name';
  static const String userDob = '';
  static const String userDateOfJoining = '';
  static const String isUserEnableLeaveApply = '';
//FCM Chat
  static const String userIdC = 'user_self_id';
  static const String fcmUidC = 'chatUid';
  static const String fcmEmailIdC = 'fcmEmailId';
  static const String fcmNewMessageC = 'fcmNewMessage';

//keyboard type
  static const int emailInputC = 3;
  static const int numberInputC = 2;
  static const int textInputC = 1;

//Notigcation
  static const int notificationOneToOneC = 3;
  static const int notificationGroupC = 4;
  static const int notificationOneToOneSecondC = 5;
  static const int notificationGroupSecondC = 6;

//keyboard input action
  static const int doneC = 1;
  static const int nextC = 2;
  static const int topAppearancePositionC = 100;
  static const int topAppearanceDurationC = 1500;

//max length
  static const int nameMaxLengthC = 50;
  static const int emailMaxLengthC = 50;
  static const int descriptionMaxLengthC = 200;
  static const int mobileMaxLengthC = 10;

}
