import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:workplace/imports.dart';

class LeavesScreen extends StatefulWidget {
  const LeavesScreen({
    Key? key,
  }) : super(key: key);

  @override
  _LeavesScreenState createState() => _LeavesScreenState();
}

class _LeavesScreenState extends State<LeavesScreen>
    with TickerProviderStateMixin {
  int difference = -1;
  //int provisionalDifference = -1;
  bool isUserEnableLeaveApply = false;
  late Animation<double> _animation;
  late AnimationController _animationController;
  late LeaveBloc bloc;
  late UserProfileBloc userProfileBloc;
  late TabController tabController;
  int tabInitialIndex = 0;
  bool isPullToRefresh = false;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  RefreshController refreshController1 =
      RefreshController(initialRefresh: false);

  Future<void> onRefresh() async {
    if (!isPullToRefresh) {
      isPullToRefresh = true;
      bloc.add(GetLeaveDataOnRefresh(mContext: context));
      bloc.add(FetchLeaveTypeEvent(mContext: context));
      await Future.delayed(const Duration(milliseconds: 2000));
      isPullToRefresh = false;
      refreshController.refreshCompleted();
    }
  }

  Future<void> onRefresh2() async {
    if (!isPullToRefresh) {
      isPullToRefresh = true;
      bloc.add(FetchTeamLeaveAppliedDataEvent(mContext: context));
      await Future.delayed(const Duration(milliseconds: 2000));
      isPullToRefresh = false;
      refreshController1.refreshCompleted();
    }
  }

  // for pagination load more data
  Future<void> onLoad() async {
    await bloc.getLeaveData(context); //get Leave data onLoad
    refreshController.loadComplete();
  }

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
    refreshController1.dispose();
  }
  // int calculateMonthsDifference(DateTime startDate, DateTime endDate) {
  //   int startYear = startDate.year;
  //   int startMonth = startDate.month;
  //   int startDay = startDate.day;
  //   int endYear = endDate.year;
  //   int endMonth = endDate.month;
  //   int endDay = endDate.day;
  //
  //   // Calculate year and month differences
  //   int yearDifference = endYear - startYear;
  //   int monthDifference = endMonth - startMonth;
  //
  //   // Combine year and month differences
  //   int totalMonthsDifference = (yearDifference * 12) + monthDifference;
  //
  //   // Adjust for the day of the month
  //   if (endDay < startDay) {
  //     totalMonthsDifference -= 1;
  //   }
  //
  //   return totalMonthsDifference;
  // }
  @override
  void initState() {
    bloc = BlocProvider.of<LeaveBloc>(context);
    userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
    PrefUtils().readStr(WorkplaceNotificationConst.userDob).then((value) {
      if (value.isNotEmpty) {
        try {
          DateTime birthDate = DateFormat("yyyy-MM-dd").parse(value);
          DateTime newBirthDate =
              DateTime(DateTime.now().year, birthDate.month, birthDate.day);
          DateTime nowDate = DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day);
          Duration diff = newBirthDate.difference(nowDate);
          difference = diff.inDays;
        } catch (e) {
          difference = -1;
        }
      }
    });


    // PrefUtils().readStr(WorkplaceNotificationConst.userDateOfJoining).then((value) {
    //   if(value.isNotEmpty)
    //     {
    //      DateTime doj =  DateFormat("yyyy-MM-dd").parse(value);
    //      DateTime nowDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    //      provisionalDifference = calculateMonthsDifference(doj,nowDate);
    //     }
    // });

    PrefUtils().readBool(WorkplaceNotificationConst.isUserEnableLeaveApply).then((value) {
      if(value.toString().isNotEmpty)
        {
          isUserEnableLeaveApply = value;
        }
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    tabController = TabController(vsync: this, length: 2, initialIndex: 0);

    final curvedAnimation =
        CurvedAnimation(curve: Curves.decelerate, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppDimens appDimens = AppDimens();
    appDimens.appDimensFind(context: context);

    var now = DateTime.now();
    var formatter = DateFormat('MMMM');
    String month = formatter.format(now);
    int year = now.year;

    Widget noDataView(String title) {
      return Container(
        color: AppColors.appTransparent,
        padding: EdgeInsets.only(top: appDimens.heightFullScreen() / 5),
        alignment: Alignment.center,
        child: Text(
          title,
          style: appStyles.noDataTextStyle(),
        ),
      );
    }

    Widget noLeaveRequestDataView(String title) {
      return Container(
        color: AppColors.appTransparent,
        alignment: Alignment.center,
        child: Text(
          title,
          style: appStyles.noDataTextStyle(),
        ),
      );
    }

    topCardView() => Container(
          margin: EdgeInsets.only(left: 10.sp, right: 10.sp),
          padding: const EdgeInsets.all(12).copyWith(left: 3),
          decoration: BoxDecoration(
              color: AppColors.appWhite,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade200,
                    spreadRadius: 3,
                    offset: const Offset(0, 1),
                    blurRadius: 3)
              ]),
          child: GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 5 / 2,
              ),
              itemCount: bloc.leaveTypeData.length,
              itemBuilder: (context, index) {
                String color = bloc.leaveTypeData[index].colorCode ?? "077FC8";
                String color1 =
                    color[0] == '#' ? color.substring(1, color.length) : color;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularPercentIndicator(
                        radius: 19,
                        lineWidth: 1.6,
                        backgroundColor: Colors.grey.shade300,
                        progressColor: Color(int.parse('0xFF$color1')),
                        percent: getPercentage(index: index),
                        center: WorkplaceIcons.iconImage(
                          iconSize: const Size(16, 16),
                          imageColor: AppColors.black,
                          imageUrl: WorkplaceIcons.briefcaseIcon,
                        ),
                        animation: true,
                        animationDuration: 2000,
                        onAnimationEnd: () {
                          if (kDebugMode) {
                            print("Animation finished");
                          }
                        },
                      ),
                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                               '${bloc.leaveTypeData[index].title}',
                              style: appStyles.userNameTextStyle(
                                  fontWeight: FontWeight.w500)),
                          Text(
                            bloc.leaveTypeData[index].name ?? '',
                            style: appStyles.userJobTitleTextStyle(
                                fontSize: 11, texColor: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }),
        );

    leaveCardView() => bloc.leaveAppliedData.isEmpty
        ? noDataView(AppString.hurryFullPresent)
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            itemCount: bloc.leaveAppliedData.length,
            itemBuilder: (context, index) {
              Color? color;
              if ('${bloc.leaveAppliedData[index].status}' == "Pending") {
                color = Colors.orange.shade500;
              } else if ('${bloc.leaveAppliedData[index].status}' ==
                  "Approved") {
                color = Colors.green.shade500;
              } else if ('${bloc.leaveAppliedData[index].status}' ==
                  "Rejected") {
                color = Colors.red.shade500;
              }
              return LeavesCardWidget(
                leaveType: bloc.leaveAppliedData[index].leaveType,
                message: parse(bloc.leaveAppliedData[index].messages)
                    .body!
                    .text
                    .trim(),
                startDate: bloc.leaveAppliedData[index].startDate,
                endDate: bloc.leaveAppliedData[index].endDate ?? '',
                managerName: '',
                managerImageUrl: '',
                description: parse(bloc.leaveAppliedData[index].reason)
                    .body!
                    .text
                    .trim(),
                status: bloc.leaveAppliedData[index].status,
                statusBoxColor: color,
                iconColor: color,
                editClickCallBack: () {},
                cardClickCallback: () {
                  Navigator.push(
                    MainAppBloc.getDashboardContext,
                    SlideRightRoute(
                        widget: LeaveDetailScreen(
                      leaveId: bloc.leaveAppliedData[index].id,
                    )),
                  ).then((value) {
                    if (value == true) {
                      bloc.add(GetLeaveDataOnRefresh(mContext: context));
                    }
                  });
                },
                cancleClickCallBack: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (ctx) => WorkplaceWidgets.titleContentPopup(
                            buttonName1: AppString.yes,
                            buttonName2: AppString.no,
                            title: AppString.cancelLeave,
                            content: AppString.cancelLeaveContent,
                            onPressedButton1: () {
                              if (bloc.leaveAppliedData[index].status
                                      ?.toLowerCase() ==
                                  "pending") {
                                Navigator.of(ctx).pop();
                                bloc.add(SubmitCancelLeaveRequestEvent(
                                  mContext: context,
                                  id: bloc.leaveAppliedData[index].id ?? 0,
                                  status: 'cancelled',
                                ));
                              }
                            },
                            onPressedButton2: () {
                              Navigator.of(ctx).pop();
                            },
                          ));
                },
              );
            });

    //Return main Ui view
    return PopScope(
        onPopInvoked: null, //_onBackPressed,
        child: ContainerFirst(
            contextCurrentView: context,
            isSingleChildScrollViewNeed: false,
            isListScrollingNeed: true,
            isFixedDeviceHeight: true,
            appBarHeight: 50,
            //106,
            appBar: DetailsScreenAppBar(
              title: AppString.leaveWHF,
              isHideIcon: true,
            ),
            containChild: BlocConsumer<LeaveBloc, LeaveState>(
              bloc: bloc,
              listener: (context, state) {},
              builder: (context, state) {
                if (state is LeaveInitialState) {
                  bloc.add(FetchLeaveTypeEvent(mContext: context));
                  bloc.add(GetLeaveDataOnRefresh(mContext: context));
                  bloc.add(FetchTeamLeaveAppliedDataEvent(mContext: context));
                } else if (state is LeaveCancelState) {
                  bloc.add(GetLeaveDataOnRefresh(mContext: context));
                  bloc.add(FetchLeaveTypeEvent(mContext: context));
                  bloc.add(FetchTeamLeaveAppliedDataEvent(mContext: context));
                } else if (state is LeaveRequestState) {
                  bloc.add(FetchTeamLeaveAppliedDataEvent(mContext: context));
                } else if (state is LeaveLoadingState) {
                  if (isPullToRefresh == false) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.appBlueA,),
                    );
                  }
                }
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    TabBar(
                        onTap: (int index) {
                          setState(() {
                            tabInitialIndex = index;
                          });
                        },
                        labelColor: AppColors.buttonBgColor4,
                        labelPadding: const EdgeInsets.only(bottom: 10),
                        indicatorColor: AppColors.buttonBgColor4,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorWeight: 4,
                        unselectedLabelColor: AppColors.greyUnselected,
                        controller: tabController,
                        tabs: [
                          Text(
                            AppString.myLeave,
                            style: appStyles.tabTextStyle(),
                          ),
                          Text(AppString.leaveRequests,
                              style: appStyles.tabTextStyle())
                        ]),
                    Expanded(
                        child: IndexedStack(index: tabInitialIndex, children: [
                       SmartRefresher(
                        controller: refreshController,
                        enablePullUp: true,
                        enablePullDown: true,
                        onRefresh: onRefresh,
                        onLoading: onLoad,
                        footer: const ClassicFooter(
                          loadStyle: LoadStyle.ShowWhenLoading,
                        ),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 15.sp,
                                      right: 15.sp,
                                      top: 10.sp,
                                      bottom: 10.sp),
                                  child: Text('$month $year',
                                      style: appStyles.userNameTextStyle(
                                          fontWeight: FontWeight.w500)),
                                ),
                                topCardView(),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 15.sp,
                                      right: 15.sp,
                                      top: 10.sp,
                                      bottom: 10.sp),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(AppString.history,
                                          style: appStyles.userNameTextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15.5)),
                                    ],
                                  ),
                                ),
                                leaveCardView(),
                                SizedBox(
                                  height: 60.sp,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SmartRefresher(
                        controller: refreshController1,
                        onRefresh: onRefresh2,
                        child: (bloc.teamLeaveData.isEmpty)
                            ? noLeaveRequestDataView(AppString.noLeaveRequest)
                            : ListView.separated(
                                padding: const EdgeInsets.only(
                                    bottom: 75, top: 10, left: 5, right: 5),
                                shrinkWrap: false,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: bloc.teamLeaveData.length,
                                itemBuilder: (context, index) {
                                  return UserLeaveRequest(
                                    cardClickCallBack: () {
                                      Navigator.of(
                                              MainAppBloc.getDashboardContext)
                                          .push(MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                      LeaveDetailScreen(
                                                        leaveId: bloc
                                                            .teamLeaveData[
                                                                index]
                                                            .id,
                                                        title: AppString.leaveRequest,
                                                      )))
                                          .then((value) {
                                        if (value == true) {
                                          bloc.add(
                                              FetchTeamLeaveAppliedDataEvent(
                                                  mContext: context));
                                        }
                                      });
                                    },
                                    cancelClickCallBack: () {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return WorkplaceWidgets
                                                .titleContentPopup(
                                                    buttonName1: AppString.yes,
                                                    buttonName2: AppString.no,
                                                    onPressedButton1: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      bloc.add(LeaveRequestEvent(
                                                          mContext: context,
                                                          id: bloc.teamLeaveData
                                                                  .elementAt(
                                                                      index)
                                                                  .id ??
                                                              0,
                                                          status: 'cancelled'));
                                                    },
                                                    onPressedButton2: () {
                                                      Navigator.pop(context);
                                                    },
                                                    title:
                                                        AppString.cancelLeave,
                                                    content: AppString
                                                        .cancelLeaveContent);
                                          });
                                    },
                                    rejectClickCallback: () {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return WorkplaceWidgets
                                                .titleContentPopup(
                                                    buttonName1:
                                                        AppString.reject,
                                                    buttonName2:
                                                        AppString.cancel,
                                                    onPressedButton1: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      bloc.add(LeaveRequestEvent(
                                                          mContext: context,
                                                          id: bloc.teamLeaveData
                                                                  .elementAt(
                                                                      index)
                                                                  .id ??
                                                              0,
                                                          status: 'rejected'));
                                                    },
                                                    onPressedButton2: () {
                                                      Navigator.pop(context);
                                                    },
                                                    title: AppString
                                                        .rejectConfirmation,
                                                    content: AppString
                                                        .rejectConfirmationContent);
                                          });
                                    },
                                    approvedClickCallBack: () {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return WorkplaceWidgets
                                                .titleContentPopup(
                                                    buttonName1:
                                                        AppString.accept,
                                                    buttonName2:
                                                        AppString.cancel,
                                                    onPressedButton1: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      bloc.add(LeaveRequestEvent(
                                                          mContext: context,
                                                          id: bloc.teamLeaveData
                                                                  .elementAt(
                                                                      index)
                                                                  .id ??
                                                              0,
                                                          status: 'approved'));
                                                    },
                                                    onPressedButton2: () {
                                                      Navigator.pop(context);
                                                    },
                                                    title: AppString
                                                        .requestConfirmation,
                                                    content: AppString
                                                        .requestConfirmationContent);
                                          });
                                    },
                                    leaveDescription: bloc.teamLeaveData
                                        .elementAt(index)
                                        .reason,
                                    leaveMessage: bloc.teamLeaveData
                                        .elementAt(index)
                                        .messages,
                                    leaveType: bloc.teamLeaveData
                                        .elementAt(index)
                                        .leaveType,
                                    userImage: bloc.teamLeaveData
                                        .elementAt(index)
                                        .user!
                                        .profilePhoto!,
                                    userNme: bloc.teamLeaveData
                                        .elementAt(index)
                                        .user!
                                        .name,
                                    status: bloc.teamLeaveData
                                        .elementAt(index)
                                        .status,
                                    startDate: bloc.teamLeaveData
                                        .elementAt(index)
                                        .startDate,
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 8,
                                  );
                                },
                              ),
                      )
                    ]))
                  ],
                );
              },
            ),
            bottomMenuView: (tabInitialIndex == 0)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(bottom: 65, right: 12),
                          child:
                              // For birthday Leave

                          // (difference <= 7 && difference >= 0)
                          //     ?
                          // FloatingActionBubble(
                          //         // Menu items
                          //         items: <Bubble>[
                          //           // Floating action menu item
                          //           Bubble(
                          //             title: AppString.applyLeave,
                          //             iconColor: Colors.white,
                          //             bubbleColor: AppColors.buttonBgColor4,
                          //             isHideIcon: true,
                          //             titleStyle: appStyles.buttonTextStyle1(
                          //                 fontSize: 13),
                          //             onPress: () {
                          //               // if(userProfileBloc.isUerEnableLeaveApply){
                          //               //   return;
                          //               // }
                          //               Navigator.push(
                          //                 MainAppBloc.getDashboardContext,
                          //                 SlideRightRoute(
                          //                     widget: LeaveApplyScreen(
                          //                   appbarTitle: AppString.applyLeave,
                          //                   leaveTypeData: bloc.leaveTypeData,
                          //                       isUserEnableLeaveApply: userProfileBloc.isUerEnableLeaveApply , //isUserEnableLeaveApply,
                          //
                          //                 )),
                          //               ).then((value) => {
                          //                     if (value == true)
                          //                       {
                          //                         bloc.add(
                          //                             GetLeaveDataOnRefresh(
                          //                                 mContext: context)),
                          //                         bloc.add(FetchLeaveTypeEvent(
                          //                             mContext: context)),
                          //                       }
                          //                   });
                          //             },
                          //           ),
                          //           // Floating action menu item
                          //           Bubble(
                          //             title: AppString.birthdayLeave,
                          //             iconColor: Colors.white,
                          //             bubbleColor: AppColors.buttonBgColor4,
                          //             isHideIcon: true,
                          //             titleStyle: appStyles.buttonTextStyle1(
                          //                 fontSize: 13),
                          //             onPress: () {
                          //               Navigator.push(
                          //                 MainAppBloc.getDashboardContext,
                          //                 SlideRightRoute(
                          //                     widget: LeaveApplyScreen(
                          //                   appbarTitle: AppString.birthdayLeave,
                          //                   leaveTypeData: bloc.leaveTypeData,
                          //                       isUserEnableLeaveApply: true,
                          //                 )),
                          //               ).then((value) => {
                          //                     if (value == true)
                          //                       {
                          //                         bloc.add(
                          //                             GetLeaveDataOnRefresh(
                          //                                 mContext: context)),
                          //                         bloc.add(FetchLeaveTypeEvent(
                          //                             mContext: context)),
                          //                       }
                          //                   });
                          //               _animationController.reverse();
                          //             },
                          //           ),
                          //         ],
                          //
                          //         // animation controller
                          //         animation: _animation,
                          //
                          //         // On pressed change animation state
                          //         onPress: () =>
                          //             _animationController.isCompleted
                          //                 ? _animationController.reverse()
                          //                 : _animationController.forward(),
                          //         iconColor: AppColors.appWhite,
                          //         backGroundColor: AppColors.buttonBgColor4,
                          //       )
                          //     :
                          FloatingActionButton(
                                  backgroundColor: AppColors.buttonBgColor4,
                                  foregroundColor: Colors.white,
                                  child: const Icon(
                                    Icons.add,
                                    color: AppColors.appWhite,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      MainAppBloc.getDashboardContext,
                                      SlideRightRoute(
                                          widget: LeaveApplyScreen(
                                        leaveTypeData: bloc.leaveTypeData,
                                        //provisionalDifference: provisionalDifference,
                                            isUserEnableLeaveApply: userProfileBloc.isUerEnableLeaveApply, //isUserEnableLeaveApply,
                                      ),),
                                    ).then((value) => {
                                          if (value == true)
                                            {
                                              bloc.add(GetLeaveDataOnRefresh(
                                                  mContext: context)),
                                              bloc.add(FetchLeaveTypeEvent(
                                                  mContext: context)),
                                            }
                                        });
                                  })
                      )

                    ],
                  )
                : const SizedBox()));
  }

  double getPercentage({required int index}) {
    double? percent = (bloc.leaveTypeData[index].availableLeave! < 0)
        ? 0
        : bloc.leaveTypeData[index].availableLeave! /
            double.parse('${bloc.leaveTypeData[index].noOfLeaves}');
    return percent;
  }
}
