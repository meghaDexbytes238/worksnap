import 'package:platform_detector/platform_detector.dart';
import 'package:workplace/imports.dart';

class MainAppBloc extends Bloc<MainAppEvent, MainAppState> {
  static Map<String, dynamic> configTheme = <String, dynamic>{};
  static BuildContext? dashboardContext;
  static get getDashboardContext => dashboardContext;
  GetUserLogout getUserLogout =
      GetUserLogout(RepositoryImpl(WorkplaceDataSourcesImpl()));

  MainAppBloc() : super(MainAppInitStat()) {
    on<UpdateLoggedInUserAuth>(
      (event, emit) => emit(
        UserAuthState(loggedInUserAuth: event.apiAuth),
      ),
    );
    on<LoggedInEvent>(
      (event, emit) => emit(
        LoggedInState(isLoggedInUser: event.isLoggedIn),
      ),
    );
    on<HomeBottomNavigationBarTapedEvent>(
      (event, emit) => emit(
        HomeBottomNavigationBarTapedState(
            tapedBottomBarIndex: event.tapedBottomBarIndex,
            tapedBottomBarPageId: event.tapedBottomBarPageId,
            statusBarColor: event.statusBarColor),
      ),
    );

    on<UpdateLoggedInUserDetailsEvent>((event, emit) => emit(
        UserLoggedInDetailState(
            loggedInUserDetails: event.loggedInUserDetails)));
    on<LoggedInUserInfoUpdateEvent>((event, emit) async {
      MainAppState.mainAppStateModel.loggedInUserInfoModel!.name = event.name ??
          MainAppState.mainAppStateModel.loggedInUserInfoModel!.name;
      MainAppState.mainAppStateModel.loggedInUserInfoModel!.email =
          event.email ??
              MainAppState.mainAppStateModel.loggedInUserInfoModel!.email;
      MainAppState.mainAppStateModel.loggedInUserInfoModel!.id = event.userId ??
          MainAppState.mainAppStateModel.loggedInUserInfoModel!.id;
      MainAppState.mainAppStateModel.loggedInUserInfoModel!.phone =
          event.mobileNumber ??
              MainAppState.mainAppStateModel.loggedInUserInfoModel!.phone;
      MainAppState.mainAppStateModel.loggedInUserInfoModel!.countryCode =
          event.countryCode ??
              MainAppState.mainAppStateModel.loggedInUserInfoModel!.countryCode;

      String loggedInUserData = json.encode(
          MainAppState.mainAppStateModel.loggedInUserInfoModel!.toJson());
      //Store logged in jason
      await PrefUtils().saveStr(
          WorkplaceNotificationConst.loggedInUserDetails, loggedInUserData);
      emit(LoggedUserInfoUpdatedState());
    });

    on<LogOutEvent>((event, emit) async {
      emit(LogOutUserState());
      try {
        LoadingWidget2.startLoadingWidget(event.context);
        //add logout api
        // final PlatformType currentPlatformType = PlatformDetector.platform.type;
        // if(currentPlatformType == PlatformType.mobile){}
        Either<Failure, bool> response = await getUserLogout.call(UserLogoutParams(deviceId: event.deviceId));
        response.fold((left) {
          LoadingWidget2.endLoadingWidget(event.context);
          emit(LogOutErrorState(
              context: event.context, errorMessage: "Something went wrong"));
        }, (right) async {
          if (right) {
            await PrefUtils().clearAll();
            await PrefUtils()
                .saveBool(WorkplaceNotificationConst.isUserLoggedInC, false);
            BlocProvider.of<UserProfileBloc>(event.context).user = User();

            LoadingWidget2.endLoadingWidget(event.context);
            //emit(MainLogoutUser());
           // FirebaseMessaging.instance.deleteToken();
            Navigator.pushAndRemoveUntil(
                event.context,
                SlideRightRoute(widget: const SignInScreen()),
                (route) => false);

          }

          // LoadingWidget2.endLoadingWidget(event.context);
        });

        // if (response.status || !response.status) {
        //   bool isNotFirstTimeBool = await PrefUtils()
        //       .readBool(WorkplaceNotificationConst.isNotFirstTime);
      } catch (e) {
        // ignore: use_build_context_synchronously
        emit(LogOutErrorState(
            context: event.context, errorMessage: "Something went wrong"));
      }
    });

    on<ExpireTokenEvent>((event, emit) {
      PrefUtils().clearAll();
      Navigator.of(event.context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const SignInScreen()), (Route<dynamic> route) => false);
    });
  }
}
