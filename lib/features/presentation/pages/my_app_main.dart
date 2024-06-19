import 'package:workplace/imports.dart';

class MyAppFlutterMain extends StatefulWidget {
  final bool isLoggedIn;
  final bool isTutorialSeen;
  final bool isOneTimeProfileSetUpDone;
  final Locale? locale;

  final String? loggedInUserDetails;

  const MyAppFlutterMain({
    Key? key,
    this.isLoggedIn = false,
    this.isTutorialSeen = false,
    this.isOneTimeProfileSetUpDone = false,
    this.loggedInUserDetails,
    this.locale,
  }) : super(key: key);

  static void setLocale(BuildContext? context, Locale newLocale) async {
    _MyAppState? state = context!.findAncestorStateOfType<_MyAppState>();
    state!.changeLanguage(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppFlutterMain> {

  bool isCheckedLang = false;
  bool isInit = false;

  Locale _locale = const Locale('en', 'US');
  final Locale _localeDefult = const Locale('en', 'US');
  String? jsonString;

  _MyAppState() {
    getLanguage();
  }

  var supportedLocales1 = const [
    Locale('en', 'US'),
    Locale('ko', 'KR'),
  ];

  @override
  void initState() {
    // projectUtil.statusBarColor(
    //     statusBarColor: AppColors.appStatusBarColor,
    //     isAppStatusDarkBrightness: false);

    try {
      //  versionCheck(context);
    } catch (e) {
      debugPrint("$e");
    }
    super.initState();
  }

  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
      String languageCode = locale.languageCode;
      String? countryCode = locale.countryCode;
      var localDetails = {
        "languageCode": languageCode,
        "countryCode": countryCode
      };

      String localDetailsStr = jsonEncode(localDetails);
      PrefUtils()
          .saveStr(WorkplaceNotificationConst.languageCodeC, localDetailsStr);
    });
  }

  getLanguage() async {
    PrefUtils()
        .readBool(WorkplaceNotificationConst.isNotFirstTime)
        .then((value) {
      if (value == false) {
        _locale = _localeDefult;
        PrefUtils().saveStr(WorkplaceNotificationConst.selectedLanguageC,
            WorkplaceNotificationConst.selectedLanguageKoreanC);
        changeLanguage(_locale);
        PrefUtils().saveBool(WorkplaceNotificationConst.isNotFirstTime, true);
      } else {
        String languageCode, countryCode;
        PrefUtils()
            .readStr(WorkplaceNotificationConst.languageCodeC)
            .then((value) {
          if (value != '') {
            Map localDetails = json.decode(value);
            languageCode = localDetails["languageCode"];
            countryCode = localDetails["countryCode"];
            if (languageCode != '' && countryCode != '') {
              setState(() {
                _locale = Locale(languageCode, countryCode);
              });
            } else {
              setState(() {
                _locale = _localeDefult;
              });
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.locale != null && !isInit) {
      // setState(() {
        isInit = true;
        _locale = widget.locale!;
      // });
    }
    // projectUtil.statusBarColor();
    ScreenUtil.init(context);
    return MultiBlocProvider(
        providers: [
          BlocProvider<MainAppBloc>(
            create: (context) => MainAppBloc(),
          ),
          BlocProvider<SignInBloc>(
            create: (context) => SignInBloc(),
          ),
          BlocProvider<FaqBloc>(
            create: (context) => FaqBloc(),
          ),
          BlocProvider<AppNotificationBloc>(
            create: (context) => AppNotificationBloc(),
          ),
          BlocProvider<UserProfileBloc>(
            create: (context) => UserProfileBloc(),
          ),
          BlocProvider<TeamMemberBloc>(
            create: (context) => TeamMemberBloc(),
          ),
          BlocProvider<SinglePostViewLikeBloc>(
            create: (context) => SinglePostViewLikeBloc(),
          ),
          BlocProvider<WorkplaceNetworkBloc>(
              create: (context) => WorkplaceNetworkBloc()),
          BlocProvider<AboutBloc>(create: (context) => AboutBloc()),
          BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
          BlocProvider<BirthdayBloc>(create: (context) => BirthdayBloc()),
          BlocProvider<WorkAnniversaryBloc>(
              create: (context) => WorkAnniversaryBloc()),
          BlocProvider<MarriageAnniversaryBloc>(
              create: (context) => MarriageAnniversaryBloc()),
          BlocProvider<HolidayBloc>(create: (context) => HolidayBloc()),
          BlocProvider<EventsBloc>(create: (context) => EventsBloc()),
          BlocProvider<FeedBloc>(create: (context) => FeedBloc()),
          BlocProvider<LeaveBloc>(create: (context) => LeaveBloc()),
          BlocProvider<FamilyBloc>(create: (context)=>FamilyBloc()),
        ],
        child: BlocConsumer<WorkplaceNetworkBloc, WorkplaceNetworkState>(
          listener: (context, state) {
          },

          builder: (context, state) {
            return /*state is NetworkConnected
                ?*/ MaterialApp(
                    //navigatorKey: NavigationService.navigatorKey,
                    debugShowCheckedModeBanner: !ApiConst.isProduction,
                    title: 'Base App',
                    // List all of the app's supported locales here
                    supportedLocales: supportedLocales1,
                    locale: _locale,
                    themeMode: ThemeMode.system,
                    theme: MyThemes.lightTheme,
                    darkTheme: MyThemes.darkTheme,
                    // These delegates make sure that the localization data for the proper language is loaded
                    localizationsDelegates: const [
                      // THIS CLASS WILL BE ADDED LATER
                      // A class which loads the translations from JSON files
                      AppLocalizations.delegate,
                    ],
                    // Returns a locale which will be used by the app
                    localeResolutionCallback: (locale, supportedLocales) {
                      // Check if the current device locale is supported
                      // If the locale of the device is not supported, use the first one
                      // from the list (English, in this case).
                      return supportedLocales.first;
                    },

                    home: !widget.isLoggedIn
                        ? loginOptionScreen()
                        : anotherLandingScreen(),
                    //Routes File
                    routes: Routes.route(),
                    onGenerateRoute: (settings) =>
                        Routes.onGenerateRoute(settings),
                    onUnknownRoute: (settings) =>
                        Routes.onUnknownRoute(settings),
                  );
                // : MaterialApp(
                //   debugShowCheckedModeBanner: false,
                //     home: Scaffold(
                //       body:WorkplaceWidgets.errorPage(title: 'No Connection',
                //           subTitle: 'Please check your internet connectivity and try again',
                //           imageUrl: 'assets/images/wifi_logo.svg',
                //           onPressed: () {
                //             setState(() {});
                //           },
                //       ),
                //     ),
                //   );
          },
        ));
  }
  mainLandingScreen() {}

  //Redirect to login screen in case user not loggedIn
  loginOptionScreen() {
    return const SignInScreen();
  }

  //Redirect to another screen if already loggedIn
  anotherLandingScreen() {
    return  DashBoardPage();
  }
}
