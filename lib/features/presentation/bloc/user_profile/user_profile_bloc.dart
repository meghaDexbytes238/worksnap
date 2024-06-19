import 'package:workplace/imports.dart';
import '../../../../core/util/app_navigator/app_navigator.dart';
part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserResponseModel userResponseModel = UserResponseModel();
  User user=User();
  bool notification = false;
  bool isUerEnableLeaveApply = true;
  String? selectProfilePhoto;
  GetUserProfile getUserProfile =
      GetUserProfile(RepositoryImpl(WorkplaceDataSourcesImpl()));

  DeleteUser deleteUser =
      DeleteUser(RepositoryImpl(WorkplaceDataSourcesImpl()));
  PostProfileUpdate postProfileUpdate =
      PostProfileUpdate(RepositoryImpl(WorkplaceDataSourcesImpl()));
  PostChangePassword postChangePassword =
      PostChangePassword(RepositoryImpl(WorkplaceDataSourcesImpl()));
  PostUploadMedia postUploadMedia =
      PostUploadMedia(RepositoryImpl(WorkplaceDataSourcesImpl()));

  UserProfileBloc() : super(UserProfileInitial()) {
    on<UserProfileEvent>((event, emit) async {
      // TODO: implement event handler
      await PrefUtils()
          .readBool(WorkplaceNotificationConst.globalNotificationC)
          .then((value) => notification = value);
    });

    on<FetchProfileDetails>((event, emit) async {
      emit(UserProfileFetching(mcontext: event.mContext));
      await fetchProfileData(event.mContext);
    });

    on<DeleteUserEvent>((event, emit) async {
      emit(UserProfileLoading());
      Either<Failure, bool> response = await deleteUser.call('');
      response.fold((left) {
        if(left is UnauthorizedFailure)
        {
          appNavigator.tokenExpireUserLogout(event.mContext);
        }
        else
          {
            emit(DeleteUserErrorState(errorMessage: 'Something went wrong'));
          }
      },
              (right) {
        if (right) {
          PrefUtils().clearAll();
          PrefUtils()
              .saveBool(WorkplaceNotificationConst.isUserLoggedInC, false);
          emit(DeleteUserState());
        }
        else {
          emit(DeleteUserErrorState(errorMessage: 'Something went wrong'));
        }

      });
    });

    on<CancelEvent>((event, emit) {
      emit(CancelState());
    });

    on<UpdateNotificationEvent>((event, emit) async {
      await Future(() async {
        bool notification = await PrefUtils()
            .readBool(WorkplaceNotificationConst.globalNotificationC);
        await postProfileUpdate.call(ProfileUpdateParams(globalNotifications: !notification ? 1 : 0,
          profilePhoto: selectProfilePhoto?.split('.com/').last
        ))
            .then((value) {
          value.fold((left) {
            if(left is UnauthorizedFailure)
            {

              appNavigator.tokenExpireUserLogout(event.mContext);
            }
            else {
              emit(
                  UpdateNotificationErrorState(errorMessage: 'Data Not found'));
            }
          }, (right) {
            notification = (right.user?.globalNotifications ?? false);
            PrefUtils().saveBool(WorkplaceNotificationConst.globalNotificationC,
                right.user?.globalNotifications ?? false);
          });
        });
      }).whenComplete(() {
        emit(UserProfileInitial());
        emit(UpdateNotificationState());
      });
    });

    on<ChangePasswordEvent>((event, emit) async {
      emit(UserProfileLoading());
      Either<Failure, dynamic> response = await postChangePassword.call(
          ChangePasswordParams(
              oldPassword: event.oldPassword,
              newPassword: event.newPassword,
              confirmPassword: event.confirmPassword));
      response.fold((left) {
        if(left is NoDataFailure)
        {
          emit(ChangePasswordErrorState(errorMessage: left.errorMessage));
        }
       else if(left is UnauthorizedFailure)
        {
          appNavigator.tokenExpireUserLogout(event.mContext);
        }
        else {
          emit(ChangePasswordErrorState(errorMessage: 'The password must be at least 8 characters'));
        }
      }, (right) {
        emit(ChangePasswordState());
      });
    });

    on<StoreMediaEvent>((event, emit) async {
      // TODO: implement event handler
      emit(UserProfileLoading());
      await postProfileUpdate.call(
          ProfileUpdateParams(profilePhoto: event.fileName)).then((value) =>
          value.fold((left)
          {
            if(left is UnauthorizedFailure)
            {
              appNavigator.tokenExpireUserLogout(event.mContext);
            }
            else {
              emit(UploadMediaErrorState(errorMessage: 'Image not changed'));
            }
          },
                  (right)
              {
                 add(FetchProfileDetails(mContext:event.mContext ));
                emit(StoreMediaState());
          }));


    });

    on<UploadMediaEvent>((event, emit) async {
      emit(UserProfileInitial());
      emit(UserProfileLoading());
      Either<Failure, UploadMediaModel> response = await postUploadMedia.call(UploadMediaParams(filePath: event.imagePath));
      response.fold((left) {
        if(left is UnauthorizedFailure)
        {
          appNavigator.tokenExpireUserLogout(event.mContext);
        }
        else {
          emit(UploadMediaErrorState(errorMessage: 'Image not changed'));
        }
      }, (right) async {

        String fileName = right.data!.fileName ?? "";
        if (fileName.isNotEmpty) {
          add(StoreMediaEvent(fileName: fileName, mContext: event.mContext));
        }
        emit(UploadMediaState());
      });
      emit(UserProfileFetched());
    });
    on<UserIsBlockedEvent>((event,emit){
      PrefUtils().clearAll();
      Navigator.of(MainAppBloc.dashboardContext!).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          const SignInScreen()), (Route<dynamic> route) => false);
    });
  }

  Future<void> fetchProfileData(BuildContext context)
  async {
      await PrefUtils()
        .readBool(WorkplaceNotificationConst.globalNotificationC)
        .then((value) => notification = value);
      getUserProfile.call('').fold((left) {
      if(left is UnauthorizedFailure)
      {
        appNavigator.tokenExpireUserLogout(context);
      }
      emit(UserProfileFetched());
      
    }, (right) {
      user = right.user ?? User();
      if(right.user!.profilePhoto != null) {
        PrefUtils().saveStr(WorkplaceNotificationConst.userProfileImageC,right.user!.profilePhoto);
      }
        PrefUtils().saveStr(WorkplaceNotificationConst.userDob, right.user!.dob);
        PrefUtils().saveStr(WorkplaceNotificationConst.userDateOfJoining, right.user!.doj);

        isUerEnableLeaveApply = right.user!.enableLeaveApply!;

        PrefUtils().saveBool(WorkplaceNotificationConst.isUserEnableLeaveApply, right.user!.enableLeaveApply);

      PrefUtils()
          .readStr(WorkplaceNotificationConst.userProfileImageC).then((value) {
        selectProfilePhoto=value;
      });
      emit(UserProfileFetched(displayMessage: right.user!.displayMessage ?? "Your account has been disabled, Please contact to administrator"));

      });
  }
}
