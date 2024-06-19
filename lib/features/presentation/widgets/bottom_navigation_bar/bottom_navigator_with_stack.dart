import 'package:flutter/cupertino.dart';
import 'package:workplace/features/presentation/bloc/home_bloc/home_event.dart';
import 'package:workplace/imports.dart';

import '../../bloc/home_bloc/home_bloc.dart';
import '../../pages/leave_screen.dart';

final Map<TabItemBottomNavigatorWithStack, Widget> menuScreens = {
  TabItemBottomNavigatorWithStack.menu1: const HomeMenuScreen(),
  TabItemBottomNavigatorWithStack.menu2: const Center(child: Text("Message")),
  TabItemBottomNavigatorWithStack.menu3: const Center(child: Text("Search")),
  TabItemBottomNavigatorWithStack.menu4: const Center(child: Text("Cart")),
  TabItemBottomNavigatorWithStack.menu5: const Center(child: Text("Profile")),
};

enum TabItemBottomNavigatorWithStack { menu1, menu2, menu3, menu4, menu5 }

/// This is the stateful widget that the main application instantiates.
class BottomNavigatorWithStack extends StatefulWidget {
  final TabItemBottomNavigatorWithStack? currentTab;
  final ValueChanged<TapedItemModel>? onSelectTab;

  final List<Widget>? widgetOptions;
  final double menuHeight;

  const BottomNavigatorWithStack({
    Key? key,
    this.currentTab,
    this.onSelectTab,
    this.menuHeight = 56,
    this.widgetOptions,
  }) : super(key: key);

  @override
  State<BottomNavigatorWithStack> createState() =>
      _BottomNavigatorWithStackState(
          currentTab: currentTab, onSelectTab: onSelectTab);
}

/// This is the private State class that goes with BottomNavigatorWithStack.
class _BottomNavigatorWithStackState extends State<BottomNavigatorWithStack> {
  TabItemBottomNavigatorWithStack? currentTab;
  ValueChanged<TapedItemModel>? onSelectTab;
  int selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  double menuHeight = 56;
  double fontSize = 18;
  Map<String, dynamic> homeBottomNavigationBar =
      MainAppBloc.configTheme.containsKey("homeBottomNavigationBar")
          ? MainAppBloc.configTheme["homeBottomNavigationBar"]
          : {};
  Map<String, dynamic> setting = MainAppBloc.configTheme.containsKey("setting")
      ? MainAppBloc.configTheme["setting"]
      : {};
  Color backgroundColor = Colors.white;
  Color activeIconColor = Colors.orange;
  Color deActiveIconColor = Colors.blueGrey.withOpacity(0.25);
  TextStyle activeMenuTextStyle =
      const TextStyle(fontSize: 0, color: Colors.orange);
  TextStyle deActiveMenuTextStyle =
      TextStyle(fontSize: 0, color: Colors.blueGrey.withOpacity(0.25));
  double elevation = 0;
  int bottomMenuType = 0;

  List<BottomNavigationBarItem> menuItem = <BottomNavigationBarItem>[];
  List<dynamic> menuItemTemp = [];

/*  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    String menuPageId = menuItemTemp[selectedIndex]["menuPageId"];
    widget.onItemTapped?.call(selectedIndex, menuPageId);
  }*/

  _BottomNavigatorWithStackState({this.onSelectTab, this.currentTab}) {
    //Set values from jason file
    backgroundColor = homeBottomNavigationBar.containsKey("backgroundColor")
        ? Color(int.parse(homeBottomNavigationBar["backgroundColor"]))
        : backgroundColor;
    activeIconColor = homeBottomNavigationBar.containsKey("activeIconColor")
        ? Color(int.parse(homeBottomNavigationBar["activeIconColor"]))
        : activeIconColor;
    deActiveIconColor = homeBottomNavigationBar.containsKey("deActiveIconColor")
        ? Color(int.parse(homeBottomNavigationBar["deActiveIconColor"]))
        : deActiveIconColor;
    if (homeBottomNavigationBar.containsKey("deActiveMenuTextStyle")) {
      deActiveMenuTextStyle.copyWith(
          color: Color(int.parse(
              homeBottomNavigationBar["deActiveMenuTextStyle"]["color"])),
          fontSize: homeBottomNavigationBar["deActiveMenuTextStyle"]["fontSize"]
              .toDouble());
    }
    if (homeBottomNavigationBar.containsKey("activeMenuTextStyle")) {
      activeMenuTextStyle.copyWith(
          color: Color(int.parse(
              homeBottomNavigationBar["activeMenuTextStyle"]["color"])),
          fontSize: homeBottomNavigationBar["activeMenuTextStyle"]["fontSize"]
              .toDouble());
    }

    if (homeBottomNavigationBar.containsKey("elevation")) {
      elevation = homeBottomNavigationBar["elevation"];
    }
    if (homeBottomNavigationBar.containsKey("bottomMenuType")) {
      bottomMenuType = homeBottomNavigationBar["bottomMenuType"];
    }

    if (homeBottomNavigationBar.containsKey("menuHeight")) {
      menuHeight = homeBottomNavigationBar["menuHeight"];
    }

    if (menuHeight < 56) {
      menuHeight = 56;
    }

    updateMenuItem();
  }

  @override
  void didUpdateWidget(covariant BottomNavigatorWithStack oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.currentTab != null) {
      setState(() {
        currentTab = widget.currentTab;
        updateMenuItem();
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {

      selectedIndex = index;
    });
    String menuPageId = menuItemTemp[selectedIndex]["menuPageId"];
    String statusBarColor = menuItemTemp[selectedIndex]["statusBarColors"];
    widget.onSelectTab?.call(TapedItemModel(
        tabItemBottomNavigatorWithStack: getMenuId(menuPageId),
        statusBarColor: statusBarColor));
    // widget.onItemTapped?.call(selectedIndex, menuPageId);
  }
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                top: BorderSide(width: 0.5, color: Colors.grey.shade300))),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            items: menuItem,
            elevation: elevation,
            type: bottomMenuType == 0
                ? BottomNavigationBarType.shifting
                : BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            // fixedColor: backgroundColor,
            currentIndex: selectedIndex,
            selectedIconTheme: IconThemeData(color: activeIconColor),
            selectedItemColor: activeIconColor,
            unselectedItemColor: deActiveIconColor,
            selectedLabelStyle: activeMenuTextStyle,
            unselectedLabelStyle: deActiveMenuTextStyle,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  TabItemBottomNavigatorWithStack getMenuId(String menuIdStr) {
    TabItemBottomNavigatorWithStack? tapedItem;
    switch (menuIdStr) {
      case "menu1":
        tapedItem = TabItemBottomNavigatorWithStack.menu1;
        break;
      case "menu2":
        tapedItem = TabItemBottomNavigatorWithStack.menu2;
        break;
      case "menu3":
        tapedItem = TabItemBottomNavigatorWithStack.menu3;
        break;
      case "menu4":
        tapedItem = TabItemBottomNavigatorWithStack.menu4;
        break;
      case "menu5":
        tapedItem = TabItemBottomNavigatorWithStack.menu5;
        break;
    }
    return tapedItem!;
  }

  void updateMenuItem() {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    if (homeBottomNavigationBar.containsKey("menu_item")) {
      menuItemTemp = homeBottomNavigationBar["menu_item"];
      menuItem = [];
      int index = 0;

      menuItemTemp.map((values) {
        menuItem.add(BottomNavigationBarItem(
          backgroundColor: Colors.white,
          activeIcon: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.only(left: 6, right: 6),
            margin: EdgeInsets.zero,
            height: 40,
            child: Container(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppColors.buttonBgColor4,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WorkplaceIcons.iconImage(
                        imageUrl: values["activeIcon"],
                        imageColor: Colors.white,
                        iconSize: const Size(20, 20)),
                    const SizedBox(
                      width: 8,
                    ),
                    Flexible(
                        child: Text(
                      values["label"],
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ))
                  ],
                )),
          ),
          icon: Container(
              padding: const EdgeInsets.all(0),
              height: index == 1 || index == 3 ? 25.5 : 30,
              child: WorkplaceIcons.iconImage(
                  imageUrl: values["deActiveIcon"],
                  imageColor: const Color(0xFF575757))),
          label: "" /*values["label"]*/,
        ));
        index++;
      }).toList();
    }
  }
}

class TapedItemModel {
  final TabItemBottomNavigatorWithStack tabItemBottomNavigatorWithStack;
  final String? statusBarColor;

  TapedItemModel(
      {required this.tabItemBottomNavigatorWithStack, this.statusBarColor});
}

//App Navigator
class AppNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class AppNavigator extends StatelessWidget {
  AppNavigator({this.navigatorKey, this.tabItem, this.item});

  final GlobalKey<NavigatorState>? navigatorKey;
  final TabItemBottomNavigatorWithStack? tabItem;
  final dynamic? item;

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {dynamic item}) {
    return {
      AppNavigatorRoutes.root: (context) => _buildRootWidget(context),
      // AppNavigatorRoutes.detail: (context) => _buildDetailWidget(context, item)
    };
  }

  Widget _buildRootWidget(BuildContext context) {
    if (tabItem == TabItemBottomNavigatorWithStack.menu1) {
      return const HomeMenuScreen();
      //return const TeamsScreen();
    } else if (tabItem == TabItemBottomNavigatorWithStack.menu2) {
      return const TeamsScreen();
    } else if (tabItem == TabItemBottomNavigatorWithStack.menu3) {
      return const PostMenuScreen();
    } else if (tabItem == TabItemBottomNavigatorWithStack.menu4) {
      return  LeavesScreen();
    } else {
      return const UserProfileScreen();
      // return ProfileSecondScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context, item: item);

    return Navigator(
      key: navigatorKey,
      initialRoute: AppNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return CupertinoPageRoute(
          builder: (context) => routeBuilders[routeSettings.name]!(context),
        );
      },
    );
  }
}
