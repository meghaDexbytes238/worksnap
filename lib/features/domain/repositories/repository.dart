import 'package:workplace/imports.dart';

abstract class Repository {
  //Get otp
  Future<Either<Failure, SignInModel>> loinUser({required UserLoginParams userLoginParams});
  Future<Either<Failure, bool>> getUserLogout({required UserLogoutParams userLogoutParams});
  Future<Either<Failure, UserResponseModel>> getUserProfile();


  Future<Either<Failure, GetLeaveDataModel>> getTeamLeaves();

  Future<Either<Failure, TeamDetailsModel>> getTeamDetails();

  Future<Either<Failure, bool>> deleteUser();

  Future<Either<Failure, UserResponseModel>> profileUpdate(
      {required ProfileUpdateParams profileUpdateParams});

  Future<Either<Failure, FaqModal>> getFaq();

  Future<Either<Failure, NotificationDataModel>> getNotification();

  Future<Either<Failure, AboutUsModal>> getAboutUs();
  
  Future<Either<Failure, bool>> postChangePassword(
      //..
      {required ChangePasswordParams changePasswordParams});

  Future<Either<Failure, UploadMediaModel>> postUploadMedia(
      {required UploadMediaParams params});

  Future<Either<Failure, GetHomeDataModel>> getHomeData();
  Future<Either<Failure, BirthdayDataModel>> getBirthdayData();
  Future<Either<Failure, WorkAnniversaryDataModel>> getWorkAnniversaryData();
  Future<Either<Failure, MarriageAnniversaryDataModel>>
      getMarriageAnniversaryData();
  Future<Either<Failure, EventDataModel>> getEventData();
  Future<Either<Failure, HolidayDataModel>> getHolidayData();
  Future<Either<Failure, FeedDataModel>> getFeedData({required FeedParams feedParams});
  Future<Either<Failure, GetLeaveTypeModel>> getLeaveType();
  Future<Either<Failure, GetLeaveDataModel>> getLeaveData({required LeaveParams leaveParams});
  Future<Either<Failure, PostLeaveApplyModel>> postLeaveApply(
      {required LeaveApplyParams leaveApplyParams});
  Future<Either<Failure, bool>> postLikeUpdate(
      {required PostLikeParams postLikeParams});

  Future<Either<Failure, SinglePostModel>> getSinglePost(
      {required SinglePostParams singlePostParams});
  
  
  Future<Either<Failure,GetLeaveDetailModel>> getLeaveDetailById({required LeaveDetailParams leaveDetailParams});
  Future<Either<Failure, PostLeaveApplyModel>> postLeaveStatusChange(
      {required LeaveStatusChangeParams leaveStatusChangeParams,});

  Future<Either<Failure,GetLeaveDetailModel>> getTeamLeaveDetailById({required TeamLeaveDetailParams teamLeaveDetailParams});

  Future<Either<Failure, bool>> putMarkNotificationDisplayed();
  Future<Either<Failure, bool>> putMarkNotificationRead({required MarkNotificationReadParams markNotificationReadParams});
  Future<Either<Failure, bool>> putMarkNotificationReadDisplay({required MarkNotificationReadDisplayParams markNotificationReadDisplayParams});

  Future<Either<Failure,FamilyModel>> getFamilyDataList();
  Future<Either<Failure, bool>>  deleteFamilyMember({required FamilyParams familyParams});
  Future<Either<Failure,SingleFamilyMemberModel>> postFamilyMemberDetails({required AddFamilyMemberParams addFamilyMemberParams});

  Future<Either<Failure, SingleFamilyMemberModel>>  putFamilyMemberDetails({required EditFamilyMemberParams editFamilyMemberParams});
}
