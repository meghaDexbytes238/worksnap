import 'package:flutter/material.dart';
import 'package:platform_detector/enums.dart';
import 'package:platform_detector/platform_detector.dart';
import 'package:workplace/core/util/animation/z_imports.dart';
import 'package:workplace/features/presentation/presentation.dart';

import '../../../imports.dart';

class AppNavigator {

  String? deviceId;

  //SignUpScreen
  void launchSignUpPage(BuildContext context, {bool canBackArrow = false}) {
    Navigator.push(
      context,
      SlideRightRoute(widget: const SignInScreen()),
    );
  }

  void launchDashBoardScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        SlideRightRoute(widget: DashBoardPage()),
        ModalRoute.withName("dashBoardScreen"));
  }

  Future<void> launchLogOutAndSign(BuildContext context) async {
    MainAppBloc mainAppBloc = MainAppBloc();
    final PlatformType currentPlatformType = PlatformDetector.platform.type;
    if(currentPlatformType == PlatformType.mobile){
      await PrefUtils().readStr(WorkplaceNotificationConst.deviceIdC).then((value){
        if(value.isNotEmpty)
        {
          mainAppBloc.add(LogOutEvent(
            context: MainAppBloc.getDashboardContext,
            deviceId: value,
          ));
        }
      });
    }
else{

    }

  }

  //SignInScreen
  void launchSignInPage(BuildContext context,
      {String userEmail = "", bool canBackArrow = false}) {
    /* Navigator.push(
      context,
      SlideRightRoute(
          widget: SignInPage(
        userEmailId: userEmail,
        canBackArrow: canBackArrow,
      )),
    );*/
  }

  //SignInScreen
  void launchVerificationCodePage(BuildContext context,
      {String userEmail = ""}) {
    Navigator.push(
      context,
      SlideRightRoute(widget: const SignInScreen()),
    );
  }

  void popBackStack(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> launchLogOutAndSignUp(BuildContext context) async {
    MainAppBloc mainAppBloc = MainAppBloc();
    await PrefUtils().readStr(WorkplaceNotificationConst.deviceIdC).then((value){

      final PlatformType currentPlatformType = PlatformDetector.platform.type;
      if(currentPlatformType == PlatformType.mobile){
        if(value.isNotEmpty) {
          mainAppBloc.add(LogOutEvent(
            context: MainAppBloc.getDashboardContext,
            deviceId: value,
          ));
        }
      }
      else{
        mainAppBloc.add(LogOutEvent(
          context: MainAppBloc.getDashboardContext,
          deviceId: '',
        ));
      }

    });


  }
  Future<void> tokenExpireUserLogout(BuildContext context) async {
    MainAppBloc mainAppBloc = MainAppBloc();
    mainAppBloc.add(ExpireTokenEvent(
      context: MainAppBloc.getDashboardContext,
    ));
  }


 }

AppNavigator appNavigator = AppNavigator();
