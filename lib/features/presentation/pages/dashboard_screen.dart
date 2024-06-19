import 'package:workplace/imports.dart';

class DashBoardPage extends StatefulWidget {
  DashBoardPage({Key? key}) : super(key: key);

  @override
  _DashBoardPage createState() => _DashBoardPage();
}

class _DashBoardPage extends State<DashBoardPage>
    with TickerProviderStateMixin {
  _DashBoardPage();

  Color statusBarColors = const Color(0xff212327);
  bool popUpActive = false;
  bool showFullView = true;

  GlobalKey<ScaffoldState> globalScaffoldKey = GlobalKey();
  double bottomMenuHeight = 56;

  //Current index
  TabItemBottomNavigatorWithStack _currentTab =
      TabItemBottomNavigatorWithStack.menu1;

  //Get selected menu
  Widget buildOffstageNavigator(TabItemBottomNavigatorWithStack tabItem,
      {item}) {
    return Offstage(
        offstage: _currentTab != tabItem,
        child: AppNavigator(
          navigatorKey: _navigatorKeys[tabItem]!,
          tabItem: tabItem,
          item: item,
        ));
  }

  //Add Menu navigation key according to added menu
  final Map<TabItemBottomNavigatorWithStack, GlobalKey<NavigatorState>>
      _navigatorKeys = {
    TabItemBottomNavigatorWithStack.menu1: GlobalKey<NavigatorState>(),
    TabItemBottomNavigatorWithStack.menu2: GlobalKey<NavigatorState>(),
    TabItemBottomNavigatorWithStack.menu3: GlobalKey<NavigatorState>(),
    TabItemBottomNavigatorWithStack.menu4: GlobalKey<NavigatorState>(),
    TabItemBottomNavigatorWithStack.menu5: GlobalKey<NavigatorState>(),
  };

  @override
  void initState() {
    BlocProvider.of<UserProfileBloc>(context)
        .add(FetchProfileDetails(mContext: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    AppDimens().appDimensFind(context: context);

    MainAppBloc.dashboardContext = context;

    //Selected bottom menu index
    void selectTab(TapedItemModel capedItemModel) {
      TabItemBottomNavigatorWithStack tabItem =
          capedItemModel.tabItemBottomNavigatorWithStack;
      try {
        statusBarColors = Color(int.parse(capedItemModel.statusBarColor!));
      } catch (e) {
        print(e);
      }
      if (tabItem == _currentTab) {
        // pop to first route
        _navigatorKeys[tabItem]!
            .currentState!
            .popUntil((route) => route.isFirst);
      } else {
        setState(() {
          _currentTab = tabItem;
          if (tabItem.index == 1) {
            TeamMemberBloc bloc = TeamMemberBloc();
            bloc.add(FetchTeamList(mContext: context));
          }
          else if(tabItem.index == 2)
            {
              BlocProvider.of<UserProfileBloc>(context).add(FetchProfileDetails(mContext: context));
            }
        });
        // setState(() => _currentTab = tabItem);
      }
    }
    //Return main Ui view
    return PopScope(
      onPopInvoked: null, //_onBackPressed,
      child: BlocBuilder<MainAppBloc, MainAppState>(
          // ignore: non_constant_identifier_names
          builder: (_, mainAppState) {
        Color statusBarColorsLocal = statusBarColors;

        if (mainAppState is HomeBottomNavigationBarTapedState) {
          statusBarColorsLocal = mainAppState.statusBarColor != null
              ? projectUtil.colorFromIntString(
                  stringColor: mainAppState.statusBarColor!)
              : statusBarColors;
        }

        if (mainAppState is MainLogoutUser) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SignInScreen()),
              (route) => false);
        }
        return ContainerDashboard(
            contextCurrentView: context,
            isOverLayStatusBar: true,
            statusBarColor: statusBarColorsLocal,
            appBackgroundColor:
                !isDarkMode ? AppColors.white : AppColors.appBgColor3,
            appBarHeight: -1,
            bottomMenuHeight: 58,
            bottomMenuView: BottomNavigatorWithStack(
              currentTab: _currentTab,
              onSelectTab: selectTab,
            ),
            appBar: Container(
              color: statusBarColorsLocal,
            ),
            containChild: Stack(
              children: [
                BlocBuilder<MainAppBloc, MainAppState>(
                    // ignore: non_constant_identifier_names
                    builder: (_, mainAppState) {
                  if (mainAppState is HomeBottomNavigationBarTapedState) {}
                  return Stack(children: <Widget>[
                    buildOffstageNavigator(
                        TabItemBottomNavigatorWithStack.menu1, item: () {
                      globalScaffoldKey.currentState?.openDrawer();
                    }),
                    buildOffstageNavigator(
                        TabItemBottomNavigatorWithStack.menu2),
                    buildOffstageNavigator(
                        TabItemBottomNavigatorWithStack.menu3),
                    buildOffstageNavigator(
                        TabItemBottomNavigatorWithStack.menu4),
                    buildOffstageNavigator(
                        TabItemBottomNavigatorWithStack.menu5),
                  ]);
                }),
              ],
            ));
      }),
    );
  }
}
