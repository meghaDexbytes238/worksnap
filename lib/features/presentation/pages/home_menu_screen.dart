import 'package:platform_detector/enums.dart';
import 'package:platform_detector/platform_detector.dart';
import 'package:workplace/imports.dart';

class HomeMenuScreen extends StatefulWidget {
  const HomeMenuScreen({Key? key})
      : super(key: key);

  @override
  _HomeMenuScreenState createState() => _HomeMenuScreenState();
}
class _HomeMenuScreenState extends State<HomeMenuScreen> {
  final PlatformType currentPlatformType = PlatformDetector.platform.type;
  bool isExpanded = false;
  HomeBloc bloc = HomeBloc();
  late UserProfileBloc userProfileBloc;
  Widget size = SizedBox(
    height: 10.sp,
  );
  Widget divider = Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(.5),
          spreadRadius: .5,
          blurRadius: 1.5,
          offset: const Offset(0, .5), // changes position of shadow
        ),
      ],
    ),
    child: Divider(
      thickness: 0.5,
      color: Colors.grey.withOpacity(.5),
      height: .5,
    ),
  );
  Map<String, dynamic> homeOption = {};
  _HomeMenuScreenState() {
    PrefUtils().readStr("home_options").then((value) {
      if (value.isNotEmpty) {
        try {
          homeOption.addAll(jsonDecode(value));
        } catch (e) {
          print(e);
        }
      }
    });
  }

  Future<void> homeOptions(String key, bool value) async {
    homeOption[key] = value;
    PrefUtils().saveStr("home_options", jsonEncode(homeOption));
  }
  Widget homeExpansionTile(
      String icon, Color color, String title, List<Widget> children,
      {bool? initiallyExpanded = false}) {
    return Card(
      color: AppColors.appWhite,
      elevation: 0.25,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(width: 1, color: Colors.grey.shade300)),
      child: ExpansionTileWidget(
        initiallyExpanded: initiallyExpanded!,
        leading: Container(
          height: 35.sp,
          width: 35.sp,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: SvgPicture.asset(
              icon,
              color: AppColors.appWhite,
            ),
          ),
        ),
        onExpansionChanged: (value) {
          homeOptions(title, value);
        },
        title: Container(
          alignment: Alignment.centerLeft,
          height: 50,
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        collapsedBackgroundColor: AppColors.appWhite,
        backgroundColor: Colors.white,
        children: children,
      ),
    );
  }

  String greetings() {
    DateTime now = DateTime.now();
    String time = '${now.hour}:${now.minute}';
    if (time.compareTo('00:00') >= 0 && time.compareTo('11:59') <= 0) {
      return 'Good Morning,';
    } else if (time.compareTo('12:00') >= 0 && time.compareTo('16:59') <= 0) {
      return 'Good Afternoon,';
    } else {
      return 'Good Evening,';
    }
  }

  Widget getGreeting() {
    String text = greetings();
    return Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.appBlack
          ),
    );
  }
  @override
  void initState() {
    userProfileBloc = BlocProvider.of<UserProfileBloc>(context);

    if(currentPlatformType == PlatformType.mobile ){
      PrefUtils().readStr(WorkplaceNotificationConst.deviceTokenC).then((value) {
        print(">>>> $value <<< ");
        // if (value == null) {
        //   // FirebaseNotifications().getToken();
        // } else {
        //   //  new FirebaseNotifications().getToken();
        //   // FirebaseNotifications().setUpFirebase(MainAppBloc.getDashboardContext, null);
        // }
      });
    }else {
      print('megha');
      PrefUtils().readStr(WorkplaceNotificationConst.deviceTokenC).then((value) {
        print(">>>> $value <<< ");
        // if (value == null) {
        //   // FirebaseNotifications().getToken();
        // } else {
        //   //  new FirebaseNotifications().getToken();
        //   // FirebaseNotifications().setUpFirebase(MainAppBloc.getDashboardContext, null);
        // }
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileBloc, UserProfileState>(
      bloc: userProfileBloc,
      listener: (context, state) {
        if (state is UserProfileFetched) {
          if (userProfileBloc.user.isBlockAccount == true) {
            showDialog(
                barrierDismissible: false,
                barrierColor: Colors.white.withOpacity(0.9),
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    backgroundColor: Colors.white,
                    title: const Text('Account Deactivated', textAlign: TextAlign.center,),
                    titleTextStyle: appStyles.titleStyle(
                      fontSize: AppDimens().fontSize(value: 22),
                      fontWeight: FontWeight.w500,
                      texColor: AppColors.black,
                      fontFamily: AppFonts().defaultFont,
                    ),
                    content: Text(state.displayMessage ??
                        "Your account has been disabled, Please contact to administrator", textAlign: TextAlign.center,),
                    contentTextStyle: appStyles.subTitleStyle(
                      fontSize: AppDimens().fontSize(value: 16),
                      fontWeight: FontWeight.w200,
                      texColor: AppColors.black,
                      fontFamily: AppFonts().defaultFont,
                    ),
                    actionsAlignment: MainAxisAlignment.end,
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              userProfileBloc
                                  .add(UserIsBlockedEvent(mContext: context));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                border: Border.all(
                                  width: 1, color: AppColors.appBlue,
                                ),
                                color:AppColors.white,
                              ),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                                child: Text(
                                  'Exit',
                                  style: appStyles.subTitleStyle(
                                    fontSize: AppDimens().fontSize(value: 15),
                                    fontWeight: FontWeight.w500,
                                    texColor: AppColors.appBlue,
                                    fontFamily: AppFonts().defaultFont,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                });
          }
        }
      },

    builder: (context, state) {
    if (state is UserProfileLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.appBlueA,),
      );
    }
    if(state is UserProfileFetching)
      {

      }
    return ContainerFirst(
      contextCurrentView: context,
      isSingleChildScrollViewNeed: false,
      isListScrollingNeed: true,
      appBarHeight: 40.sp,
      appBar: HomeScreenAppBar(notificationCount: userProfileBloc.user.notificationCount ?? 0),
      containChild: BlocBuilder<HomeBloc, HomeState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is HomeInitialState) {
                bloc.add(FetchHomeData(mContext: context));
              }
              if (state is HomeLoadingState) {
                return LoadingWidget2.loadViewWidget();
              }
              if (state is HomeErrorState) {
                return WorkplaceWidgets.errorPage(title: AppString.somethingWentWrong,
                    subTitle: AppString.technicalIssue,
                    imageUrl: WorkplaceIcons.boxIcon,
                    onPressed: () {
                      setState(() {});
                    },
                  );
              }
              return body();
            },
          ),
    );
  },
);
  }

  Widget body() => RefreshIndicator(
        color: AppColors.appBlueA,
        onRefresh: () async {
          bloc.add(FetchHomeData(mContext: context));
          userProfileBloc.add(FetchProfileDetails(mContext: context));
          //await userProfileBloc.fetchProfileData(context);
          await bloc.fetchData(context);
        },
        child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp)
                .copyWith(bottom: 60, top: 0),
            shrinkWrap: true,
            children: [
              size,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    getGreeting(),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      userProfileBloc.user.firstName ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.appBlack
                          // fontFamily: "Caveat",
                          ),
                    ),
                  ],
                ),
              ),
              size,
              const SizedBox(
                height: 5,
              ),
              homeExpansionTile(
                  WorkplaceIcons.leaveIcon,
                  AppColors.appBlue,
                  AppString.todayLeave,
                  [
                    divider,
                    TodayLeaveScreen(
                      leaveToday: bloc.todayLeaves,
                    )
                  ],
                  initiallyExpanded:
                      homeOption.containsKey(AppString.todayLeave)
                          ? homeOption[AppString.todayLeave]
                          : false),
              size,
              homeExpansionTile(
                  WorkplaceIcons.homeWorkIcon,
                  AppColors.appOrange,
                  AppString.whfLeave,
                  [
                    divider,
                    TodayWHFScreen(
                      todayWfh: bloc.todayWfh,
                    )
                  ],
                  initiallyExpanded: homeOption.containsKey(AppString.whfLeave)
                      ? homeOption[AppString.whfLeave]
                      : false),
              size,
              homeExpansionTile(
                  WorkplaceIcons.announcementIcon,
                  AppColors.appPurpleAccent,
                  AppString.announcements,
                  [
                    divider,
                    AnnouncementScreenBody(
                      announcements: bloc.announcements,
                    ),
                  ],
                  initiallyExpanded:
                  homeOption.containsKey(AppString.announcements)
                      ? homeOption[AppString.announcements]
                      : false),
              size,
              homeExpansionTile(
                  WorkplaceIcons.birthdayCakeIcon,
                  AppColors.appAmber,
                  AppString.upcomingBirthday,
                  [
                    divider,
                    BirthdayScreenBody(
                      birthday: bloc.birthday,
                    )
                  ],
                  initiallyExpanded:
                      homeOption.containsKey(AppString.upcomingBirthday)
                          ? homeOption[AppString.upcomingBirthday]
                          : false),
              size,
              homeExpansionTile(
                  WorkplaceIcons.anniversaryIcon,
                  AppColors.appPurple,
                  AppString.upcomingWorkAnniversary,
                  [
                    divider,
                    WorkAnniversaryScreenBody(
                        workAnniversary: bloc.workAnniversary),
                  ],
                  initiallyExpanded:
                      homeOption.containsKey(AppString.upcomingWorkAnniversary)
                          ? homeOption[AppString.upcomingWorkAnniversary]
                          : false),
              size,
              homeExpansionTile(
                  WorkplaceIcons.anniversaryIcon,
                  AppColors.appRed,
                  AppString.upcomingMarriageAnniversary,
                  [
                    divider,
                    MarriageAnniversaryScreenBody(
                      marriageAnniversary: bloc.marriageAnniversary,
                    ),
                  ],
                  initiallyExpanded: homeOption
                          .containsKey(AppString.upcomingMarriageAnniversary)
                      ? homeOption[AppString.upcomingMarriageAnniversary]
                      : false),

              size,
              homeExpansionTile(
                  WorkplaceIcons.holidayIcon,
                  AppColors.appGreen,
                  AppString.upcomingHoliday,
                  [
                    divider,
                    HolidayScreenBody(
                      holidays: bloc.holidays,
                    ),
                  ],
                  initiallyExpanded:
                      homeOption.containsKey(AppString.upcomingHoliday)
                          ? homeOption[AppString.upcomingHoliday]
                          : false),
              // to display event expansion tile
              // size,
              // homeExpansionTile(
              //     WorkplaceIcons.calendarImage,
              //     AppColors.appBlueAccent,
              //     AppString.events,
              //     [
              //       divider,
              //       EventScreenBody(
              //         events: bloc.events,
              //       ),
              //     ],
              //     initiallyExpanded: homeOption.containsKey(AppString.events)
              //         ? homeOption[AppString.events]
              //         : false),
              const SizedBox(
                height: 40,
              ),
            ]),
      );
}
