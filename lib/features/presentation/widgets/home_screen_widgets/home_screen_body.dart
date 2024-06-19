import 'package:workplace/imports.dart';
import '../../bloc/home_bloc/home_bloc.dart';
import '../../bloc/home_bloc/home_event.dart';
import '../../bloc/home_bloc/home_state.dart';
import '../../pages/announcement_screen_body.dart';
import '../../pages/birthday_screen_body.dart';
import '../../pages/event_screen_body.dart';
import '../../pages/holiday_screen_body.dart';
import '../../pages/marraige_anniversary_screen_body.dart';
import '../../pages/today_leave_screen.dart';
import '../../pages/today_whf_screen.dart';
import '../../pages/work_anniversary_screen_body.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  bool isExpanded = false;
  String userFirstName = "";

  HomeBloc bloc = HomeBloc();
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

  _HomeScreenBodyState() {
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
          fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black
          //fontFamily: "Caveat",
          ),
    );
  }

  getUserFirstName() async {
    userFirstName =
        await PrefUtils().readStr(WorkplaceNotificationConst.userFirstName);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserFirstName();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is HomeInitialState) {
          bloc.add(FetchHomeData(mContext: context));
        }
        if (state is HomeLoadingState) {
          return LoadingWidget2.loadViewWidget();
        }
        if (state is FetchedHomeDataState) {
          return body();
        }
        return Container();
      },
    );
  }

  Widget body() => RefreshIndicator(
        color: Colors.blue,
        onRefresh: () async {
          await bloc.fetchData(context);
        },
        child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            //physics: NeverScrollableScrollPhysics(),
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
                      userFirstName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black
                          // fontFamily: "Caveat",
                          ),
                    ),
                  ],
                ),
              ),
              size,
              const SizedBox(height: 5,),
              homeExpansionTile(
                  WorkplaceIcons.leaveIcon,
                  Colors.orange,
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
                  AppColors.appPurpleAccent,
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
                  WorkplaceIcons.birthdayIcon,
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
                  AppColors.appPink,
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
              size,
              homeExpansionTile(
                  WorkplaceIcons.calendarImage,
                  AppColors.appBlueAccent,
                  AppString.events,
                  [
                    divider,
                    EventScreenBody(
                      events: bloc.events,
                    ),
                  ],
                  initiallyExpanded: homeOption.containsKey(AppString.events)
                      ? homeOption[AppString.events]
                      : false),
              const SizedBox(
                height: 40,
              ),
            ]),
      );
}
