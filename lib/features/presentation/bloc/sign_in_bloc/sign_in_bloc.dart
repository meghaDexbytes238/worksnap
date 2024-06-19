import 'package:platform_detector/enums.dart';
import 'package:platform_detector/platform_detector.dart';
import 'package:workplace/core/util/app_navigator/app_navigator.dart';
import 'package:workplace/imports.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  LoginUser loginUser = LoginUser(RepositoryImpl(WorkplaceDataSourcesImpl()));
  final PlatformType currentPlatformType = PlatformDetector.platform.type;

  SignInBloc() : super(SignInInitStat()) {


    on<SubmitSignInEvent>((event, emit) async {
      if(currentPlatformType == PlatformType.mobile){
        await projectUtil.deviceInfo();
      }else {

      }
     // await FirebaseNotifications().getToken();
      emit(SignInInProgressState());
      Map? data = event.requestData;

      String enteredEmail = event.requestData!["email"];
      try {
        LoadingWidget2.startLoadingWidget(event.mContext!);
          String deviceToken =
          await PrefUtils().readStr(WorkplaceNotificationConst.deviceTokenC);
          String deviceId =
          await PrefUtils().readStr(WorkplaceNotificationConst.deviceIdC);
          print(deviceId);
          String deviceName =
          await PrefUtils().readStr(WorkplaceNotificationConst.deviceNameC);
          String deviceVersion = await PrefUtils()
              .readStr(WorkplaceNotificationConst.deviceOsVersionC);
          String deviceModel =
          await PrefUtils().readStr(WorkplaceNotificationConst.deviceModelC);
          String appVersion = await PrefUtils().readStr(WorkplaceNotificationConst.appVersionVersionC);
          String deviceTypeName = currentPlatformType == PlatformType.mobile ?  Platform.isAndroid ? "android" : "ios":"web";
          data!["deviceId"] = deviceId;
          data["deviceName"] = deviceName;
          data["fcmToken"] = deviceToken;
          data["deviceVersion"] = deviceVersion;
          data["deviceType"] = deviceTypeName;
          data["device_model"] = deviceModel;
          data["app_version"] = appVersion;


        Either<Failure, SignInModel> response = await loginUser.call(
            UserLoginParams(
                email: event.requestData!["email"],
                password: event.requestData!["password"],
                deviceId: deviceId,
                deviceName: deviceName,
                deviceType: deviceTypeName,
                deviceVersion: deviceVersion,
                fcmToken: deviceToken
            ));

        response.fold((left) {
          if (left is NoDataFailure) {
            emit(SignInErrorState(
              context: event.mContext!,
              errorMessage: left.errorMessage,
              code: 401,
              okCallBack: () {
                appNavigator.popBackStack(event.mContext!);
              },
            ));
            LoadingWidget2.endLoadingWidget(event.mContext!);
          } else if (left is NetworkFailure) {
            emit(SignInErrorState(
                context: event.mContext!,
                errorMessage: "Network Not Available"));
            LoadingWidget2.endLoadingWidget(event.mContext!);
          } else {
            LoadingWidget2.endLoadingWidget(event.mContext!);
            emit(SignInErrorState(
                context: event.mContext!,
                errorMessage: "Something went wrong..."));
          }
        }, (right) async {
          if (right.data != null) {
            MainAppBloc mainAppBloc =
                BlocProvider.of<MainAppBloc>(event.mContext!);
            mainAppBloc.add(LoggedInUserInfoUpdateEvent(
              userId: 0,
              name: '${right.data!.firstName} ${right.data!.lastName}',
              mobileNumber: right.data!.phone,
              email: right.data!.email,
              countryCode: int.parse((right.data!.countryCode) ?? '0'),
            ));
            PrefUtils()
                .saveBool(WorkplaceNotificationConst.isUserLoggedInC, true);

            PrefUtils()
                .saveBool(WorkplaceNotificationConst.isUserFirstTime, true);

            PrefUtils().saveBool(WorkplaceNotificationConst.globalNotificationC,
                (right.data!.globalNotifications) ?? false);
            PrefUtils().saveStr(WorkplaceNotificationConst.userFirstName,
                right.data!.firstName);
            mainAppBloc.add(const LoggedInEvent(true));
            await PrefUtils()
                .saveStr(
                    WorkplaceNotificationConst.accessTokenC, right.data!.token)
                .whenComplete(() {
              appNavigator.launchDashBoardScreen(event.mContext!);
            });
          } else {
            emit(SignInErrorState(
                context: event.mContext!,
                errorMessage: right.message,
                phone: enteredEmail));
          }
        });
      } catch (e) {
        LoadingWidget2.endLoadingWidget(event.mContext!);
        print(e);
        emit(SignInErrorState(
            context: event.mContext!, errorMessage: "Something went wrong"));
      }
      LoadingWidget2.endLoadingWidget(event.mContext!);
    });
  }
}
