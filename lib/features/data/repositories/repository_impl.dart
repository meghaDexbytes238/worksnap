import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:workplace/imports.dart';

class RepositoryImpl implements Repository {
  final WorkplaceDataSources workplaceDataSources;
  // final NetworkInfo networkInfo = NetworkInfoImpl();
  final Connectivity networkInfo = Connectivity();

  RepositoryImpl(this.workplaceDataSources);

  @override
  Future<Either<Failure, SignInModel>> loinUser(
      {required UserLoginParams userLoginParams}) async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response =
            await workplaceDataSources.loinUser(userDetails: userLoginParams);
        return Right(SignInModel.fromJson(response));
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
  @override
  Future<Either<Failure, UserResponseModel>> getUserProfile() async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.getUserProfile();
        return Right(UserResponseModel.fromJson(response));
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> getUserLogout({required UserLogoutParams userLogoutParams}) async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.getUserLogout(userLogoutParams: userLogoutParams);
        return Right(
            response['message'] == 'Logout successfully.' ? true : false);
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, TeamDetailsModel>> getTeamDetails() async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.getTeamDetails();
        return Right(TeamDetailsModel.fromJson(response));
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteUser() async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.deleteUser();
        return Right(
            response['message'] == 'customer.Account deleted successfully'
                ? true
                : false);
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, UserResponseModel>> profileUpdate(
      {required ProfileUpdateParams profileUpdateParams}) async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.profileUpdate(
            profileUpdateParams: profileUpdateParams);
        return Right(UserResponseModel.fromJson(response));
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, FaqModal>> getFaq() async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.getFaq();
        return Right(FaqModal.fromJson(response));
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, AboutUsModal>> getAboutUs() async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.getAboutUs();
        return Right(AboutUsModal.fromJson(response));
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> postChangePassword(
      {required ChangePasswordParams changePasswordParams}) async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.postChangePassword(changePasswordParams: changePasswordParams);
        return Right(response['message'] == 'Password updated successfully' ? true : false);
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, UploadMediaModel>> postUploadMedia(
      {required UploadMediaParams params}) async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response =
            await workplaceDataSources.postUploadMedia(params: params);
        return Right(UploadMediaModel.fromJson(response));
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, GetHomeDataModel>> getHomeData() async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.getHomeData();
        return Right(GetHomeDataModel.fromJson(response));
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, BirthdayDataModel>> getBirthdayData() async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.getBirthdayData();
        return Right(BirthdayDataModel.fromJson(response));
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, MarriageAnniversaryDataModel>>
      getMarriageAnniversaryData() async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response =
            await workplaceDataSources.getMarriageAnniversaryData();
        return Right(MarriageAnniversaryDataModel.fromJson(response));
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, WorkAnniversaryDataModel>>
      getWorkAnniversaryData() async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.getWorkAnniversaryData();
        return Right(WorkAnniversaryDataModel.fromJson(response));
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, EventDataModel>> getEventData() async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.getEventData();
        return Right(EventDataModel.fromJson(response));
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, HolidayDataModel>> getHolidayData() async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.getHolidayData();
        return Right(HolidayDataModel.fromJson(response));
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, FeedDataModel>> getFeedData({ FeedParams? feedParams}) async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.getFeedData(feedParams : feedParams!);
        return Right(FeedDataModel.fromJson(response));
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, GetLeaveTypeModel>> getLeaveType() async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.getLeaveType();
        return Right(GetLeaveTypeModel.fromJson(response));
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
  @override
  Future<Either<Failure, GetLeaveDataModel>> getLeaveData({LeaveParams? leaveParams}) async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.getLeaveData(leaveParams : leaveParams!);
        return Right(GetLeaveDataModel.fromJson(response));
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
  @override
  Future<Either<Failure, PostLeaveApplyModel>> postLeaveApply(
      {required LeaveApplyParams leaveApplyParams}) async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.postLeaveApply(
            leaveApplyParams: leaveApplyParams);
        return Right(PostLeaveApplyModel.fromJson(response));
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, NotificationDataModel>> getNotification() async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.getNotification();
        return Right(NotificationDataModel.fromJson(response));
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> postLikeUpdate(
      {required PostLikeParams postLikeParams}) async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.postLikeRequest(
            postLikeParams: postLikeParams);
        return Right(response['message'] == 'Successfully' ? true : false);
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, SinglePostModel>> getSinglePost(
      {required singlePostParams}) async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.getSinglePost(
            singlePostParams: singlePostParams);
        return Right(SinglePostModel.fromJson(response));
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, GetLeaveDetailModel>> getLeaveDetailById({required LeaveDetailParams leaveDetailParams}) async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.getLeaveDetailById(leaveDetailParams: leaveDetailParams);
        return Right(GetLeaveDetailModel.fromJson(response));
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
  
  
  @override
  Future<Either<Failure, GetLeaveDataModel>> getTeamLeaves() async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.getTeamLeaveData();
        return Right(GetLeaveDataModel.fromJson(response));
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }


  @override
  Future<Either<Failure, PostLeaveApplyModel>> postLeaveStatusChange(
      {required LeaveStatusChangeParams leaveStatusChangeParams}) async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.postLeaveStatusApply(
            leaveStatusChangeParams: leaveStatusChangeParams);
        return Right(PostLeaveApplyModel.fromJson(response));
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, GetLeaveDetailModel>> getTeamLeaveDetailById(
      {required TeamLeaveDetailParams teamLeaveDetailParams}) async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.getTeamLeaveDetailById (teamLeaveDetailParams: teamLeaveDetailParams);
        return Right(GetLeaveDetailModel.fromJson(response));
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> putMarkNotificationDisplayed() async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.putMarkNotificationDisplayed();
        return Right(
            response['message'] == 'Message status updated successfully' ? true : false);
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> putMarkNotificationRead({required MarkNotificationReadParams markNotificationReadParams}) async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.putMarkNotificationRead(markNotificationReadParams: markNotificationReadParams);
        return Right(
            response['message'] == 'Message status updated successfully' ? true : false);
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> putMarkNotificationReadDisplay({required MarkNotificationReadDisplayParams markNotificationReadDisplayParams}) async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.putMarkNotificationReadDisplay( markNotificationReadDisplayParams: markNotificationReadDisplayParams);
        return Right(
            response['message'] == 'Message status updated successfully' ? true : false);
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, FamilyModel>> getFamilyDataList() async {
  if(await networkInfo.checkConnectivity() == ConnectivityResult.wifi)
    {
      try{
        final response = await workplaceDataSources.getFamilyDataList();
        return Right(FamilyModel.fromJson(response));
      }on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
    return Left(NetworkFailure());
  }
  }

  @override
  Future<Either<Failure, bool>> deleteFamilyMember({required FamilyParams familyParams}) async {
    if (await networkInfo.checkConnectivity() == ConnectivityResult.wifi) {
      try {
        final response = await workplaceDataSources.deleteFamilyMember(familyParams: familyParams);
        return Right(response['message'] == "Family deleted Successfully" ? true : false);
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, SingleFamilyMemberModel>> postFamilyMemberDetails({required AddFamilyMemberParams addFamilyMemberParams}) async {
    if(await networkInfo.checkConnectivity() == ConnectivityResult.wifi)
    {
      try{
        final response = await workplaceDataSources.postFamilyMemberDetails(addFamilyMemberParams: addFamilyMemberParams);
        return Right(SingleFamilyMemberModel.fromJson(response));
      }on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, SingleFamilyMemberModel>> putFamilyMemberDetails({required EditFamilyMemberParams editFamilyMemberParams}) async {
    if(await networkInfo.checkConnectivity() == ConnectivityResult.wifi)
    {
      try{
        final response = await workplaceDataSources.putFamilyMemberDetails(editFamilyMemberParams: editFamilyMemberParams);
        return Right(SingleFamilyMemberModel.fromJson(response));
      }on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        if (e is DataNotFoundException) {
          return Left(NoDataFailure(errorMessage: e.errorMessage));
        }
        return Left(ParsingFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }





}
