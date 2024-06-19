import 'package:flutter/material.dart';
import 'package:workplace/core/config/customRoute.dart';
import 'package:workplace/features/presentation/pages/sign_in_new_screen.dart';
import 'package:workplace/features/presentation/pages/splash.dart';

const dashBoardScreen = 'dashBoardScreen';

class Routes {
  static dynamic route() {
    return {
     //'SplashPage': (BuildContext context) => SplashPage(),
      'SplashPage': (BuildContext context) => Container(),
    };
  }

  static void sendNavigationEventToFirebase(String path) {
    if (path != null && path.isNotEmpty) {
      // analytics.setCurrentScreen(screenName: path);
    }
  }

  static Route? onGenerateRoute(RouteSettings settings) {
    final List<String> pathElements = settings.name!.split('/');
    if (pathElements[0] != '' || pathElements.length == 1) {
      return null;
    }
    switch (pathElements[1]) {
      case "dashBoardScreen":
        return CustomRoute<bool>(
            builder: (BuildContext context) => SignInScreen());

      case "signInPage":
        return CustomRoute<bool>(
            builder: (BuildContext context) => Container());
      /*CustomRoute<bool>(
            builder: (BuildContext context) => SignInPage());*/

      default:
        return onUnknownRoute(RouteSettings(name: '/Feature'));
    }
  }

  static Route onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('Title'),
          centerTitle: true,
        ),
        body: Center(
          child: Text('${settings.name!.split('/')[1]} Comming soon..'),
        ),
      ),
    );
  }
}
