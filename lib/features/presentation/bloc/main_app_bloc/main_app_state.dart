import 'package:workplace/features/presentation/widgets/alerts/error_alert.dart';
import 'package:workplace/core/util/app_navigator/app_navigator.dart';
import 'package:workplace/imports.dart';

abstract class MainAppState {
  static MainAppStateModel mainAppStateModel = MainAppStateModel();

  void updateModel({mainAppStateModelTemp}) {
    if (mainAppStateModelTemp != null) {
      mainAppStateModel = mainAppStateModelTemp;
    }
  }

  get loggedInUserAuthToken => getMainAppStateModel.loggedInUserAuth;
/*  SignInModel get loggedInUserDetails =>
      getMainAppStateModel.loggedInUserDetails;*/

  /* UserProfileDetailModel? get loggedInUserProfileDetails =>
      getMainAppStateModel.loggedInUserProfile;*/

  MainAppStateModel get getMainAppStateModel {
    return mainAppStateModel;
  }

  void logOutUser() {
    mainAppStateModel = MainAppStateModel();
  }
}

class MainAppInitStat extends MainAppState {}

class MainAppStateInProgress extends MainAppState {}

class UserAuthState extends MainAppState {
  String? loggedInUserAuth;
  UserAuthState({this.loggedInUserAuth}) {
    getMainAppStateModel.loggedInUserAuth = loggedInUserAuth!;
    updateModel(mainAppStateModelTemp: this.getMainAppStateModel);
  }
  @override
  String toString() => 'ProductAdded { todos: $getMainAppStateModel }';
}

class UserLoggedInDetailState extends MainAppState {
  LoggedInUserInfoModel? loggedInUserDetails;
  UserLoggedInDetailState({this.loggedInUserDetails}) {
    getMainAppStateModel.loggedInUserInfoModel = loggedInUserDetails;
    updateModel(mainAppStateModelTemp: this.getMainAppStateModel);
  }
  @override
  String toString() => 'ProductAdded { todos: $getMainAppStateModel }';
}

class LoggedInState extends MainAppState {
  bool isLoggedInUser;
  LoggedInState({this.isLoggedInUser = false}) {
    getMainAppStateModel.isLoggedIn = isLoggedInUser;
    updateModel(mainAppStateModelTemp: this.getMainAppStateModel);
  }
  @override
  String toString() => 'ProductAdded { todos: $getMainAppStateModel }';
}

class HomeBottomNavigationBarTapedState extends MainAppState {
  int tapedBottomBarIndex;
  String tapedBottomBarPageId;
  String? statusBarColor;
  HomeBottomNavigationBarTapedState(
      {this.tapedBottomBarIndex = 0,
      this.tapedBottomBarPageId = "",
      this.statusBarColor}) {
    getMainAppStateModel.tapedBottomBarIndex = tapedBottomBarIndex;
    getMainAppStateModel.tapedBottomBarPageId = tapedBottomBarPageId;
    //updateModel(mainAppStateModelTemp: this.getMainAppStateModel);
  }
  @override
  String toString() => 'ProductAdded { todos: $getMainAppStateModel }';
}

class LoggedUserInfoUpdatedState extends MainAppState {
  LoggedUserInfoUpdatedState() {
    updateModel(mainAppStateModelTemp: this.getMainAppStateModel);
  }
  @override
  String toString() => 'ProductAdded { todos: $getMainAppStateModel }';
}

//clear data from provider on logout user
class LogOutUserState extends MainAppState {
  BuildContext? context;
  LogOutUserState({this.context}) {
    logOutUser();
  }

  @override
  String toString() => 'ProductAdded { todos: $getMainAppStateModel }';
}

//Show log out error
class LogOutErrorState extends MainAppState {
  LogOutErrorState(
      {required BuildContext context,
      String? errorMessage,
      String? phone,
      int? code,
      okCallBack}) {
    ErrorAlert(
        context: context,
        message: errorMessage,
        callBackYes: (mContext) {
          if (okCallBack != null) {
            okCallBack();
          } else {
            appNavigator.popBackStack(mContext);

            /* else if(){

            }*/
          }
          // appNavigator.popBackStack(context);
          // appNavigator.launchVerificationCodePage(context, userEmail: emailId);
        });
  }
}

class MainLogoutUser extends MainAppState {}

