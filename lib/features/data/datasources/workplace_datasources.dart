import 'package:workplace/imports.dart';

abstract class WorkplaceDataSources {
  Future<Map<String, dynamic>> loinUser({required UserLoginParams userDetails});
  Future<Map<String, dynamic>> getUserProfile();
  Future<Map<String, dynamic>> getUserLogout({required UserLogoutParams userLogoutParams});
  Future<Map<String, dynamic>> getTeamDetails();

  Future<Map<String, dynamic>> deleteUser();
  Future<Map<String, dynamic>> profileUpdate(
      {required ProfileUpdateParams profileUpdateParams});

  Future<Map<String, dynamic>> getFaq();

  Future<Map<String, dynamic>> getNotification();

  Future<Map<String, dynamic>> getAboutUs();

  Future<Map<String, dynamic>> postChangePassword(
      {required ChangePasswordParams changePasswordParams});

  Future<Map<String, dynamic>> postUploadMedia(
      {required UploadMediaParams params});

  Future<Map<String, dynamic>> getHomeData();

  Future<Map<String, dynamic>> getBirthdayData();

  Future<Map<String, dynamic>> getWorkAnniversaryData();

  Future<Map<String, dynamic>> getMarriageAnniversaryData();

  Future<Map<String, dynamic>> getEventData();

  Future<Map<String, dynamic>> getHolidayData();

  Future<Map<String, dynamic>> getFeedData({required FeedParams feedParams});

  Future<Map<String, dynamic>> getLeaveType();

  Future<Map<String, dynamic>> getLeaveData({required LeaveParams leaveParams});

  Future<Map<String, dynamic>> postLeaveApply(
      {required LeaveApplyParams leaveApplyParams});


  Future<Map<String, dynamic>> postLikeRequest(
      {required PostLikeParams postLikeParams});

  Future<Map<String, dynamic>> getSinglePost(
      {required SinglePostParams singlePostParams});

  Future<Map<String, dynamic>> getLeaveDetailById(
      {required LeaveDetailParams leaveDetailParams});

  Future<Map<String, dynamic>> getTeamLeaveData();

  Future<Map<String, dynamic>> postLeaveStatusApply(
          {required LeaveStatusChangeParams leaveStatusChangeParams});

  Future<Map<String, dynamic>> getTeamLeaveDetailById(
      {required TeamLeaveDetailParams teamLeaveDetailParams});

  Future<Map<String, dynamic>> putMarkNotificationDisplayed();

  Future<Map<String, dynamic>> putMarkNotificationRead({required MarkNotificationReadParams markNotificationReadParams});

  Future<Map<String, dynamic>> putMarkNotificationReadDisplay({required MarkNotificationReadDisplayParams markNotificationReadDisplayParams});

  Future<Map<String,dynamic>> getFamilyDataList();

  Future<Map<String,dynamic>> deleteFamilyMember({required FamilyParams familyParams});

  Future<Map<String,dynamic>> postFamilyMemberDetails({required AddFamilyMemberParams addFamilyMemberParams});

  Future<Map<String,dynamic>> putFamilyMemberDetails({required EditFamilyMemberParams editFamilyMemberParams});


}
