

import 'imports.dart';

Future<InitVar> workplaceInit() async {
  // if you are using await in main function then add this line
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase Crashlytics
  //await Firebase.initializeApp();
  await ScreenUtil.ensureScreenSize();
  //FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // Pass all uncaught errors to Crashlytics.
 // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  Provider.debugCheckInvalidValueType = null;

  // Restrict for portrait mode only
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  bool isLoggedIn =
      await PrefUtils().readBool(WorkplaceNotificationConst.isUserLoggedInC);
  String jsonString =
      await rootBundle.loadString('assets/app_theme/config_theme.json');
  MainAppBloc.configTheme = json.decode(jsonString);

  String? loggedInUserDetailsStr;
  if (isLoggedIn) {
    MainAppBloc mainAppBloc = MainAppBloc();
    loggedInUserDetailsStr = await PrefUtils()
        .readStr(WorkplaceNotificationConst.loggedInUserDetails);
    if (loggedInUserDetailsStr.trim().isNotEmpty) {
      LoggedInUserInfoModel? loggedInUserInfoModel;
      try {
        loggedInUserInfoModel =
            LoggedInUserInfoModel.fromJson(json.decode(loggedInUserDetailsStr));
        mainAppBloc.add(UpdateLoggedInUserDetailsEvent(loggedInUserInfoModel));
      } catch (e) {
        debugPrint("$e");
      }
    }
    mainAppBloc.add(LoggedInEvent(isLoggedIn));
  }
  bool isTutorialSeen =
      await PrefUtils().readBool(WorkplaceNotificationConst.isIsTutorialSeenC);
  bool isOneTimeProfileSetUpDone = await PrefUtils()
      .readBool(WorkplaceNotificationConst.isOneTimeProfileSetUpDoneC);
  Locale? mLocale = isLoggedIn ? await lang() : null;

  Provider.debugCheckInvalidValueType = null;

  return InitVar(
      isLoggedIn: isLoggedIn,
      mLocale: mLocale,
      isTutorialSeen: isTutorialSeen,
      isOneTimeProfileSetUpDone: isOneTimeProfileSetUpDone);
}

Future<Locale?> lang() async {
  Locale? mLocale = const Locale('en', 'US');
  String languageCode, countryCode;
  String value =
      await PrefUtils().readStr(WorkplaceNotificationConst.languageCodeC);

  if (value != '') {
    Map localDetails = json.decode(value);
    languageCode = localDetails["languageCode"];
    countryCode = localDetails["countryCode"];
    if (languageCode != '' && countryCode != '') {
      mLocale = Locale(languageCode, countryCode);
    } else {
      mLocale = null;
    }
  }
  //First Time User
  else {
    mLocale = null;
    PrefUtils().saveStr(WorkplaceNotificationConst.selectedLanguageC,
        WorkplaceNotificationConst.selectedLanguageKoreanC);
    PrefUtils().saveBool(WorkplaceNotificationConst.isNotFirstTime, true);
  }
  return mLocale;
}
