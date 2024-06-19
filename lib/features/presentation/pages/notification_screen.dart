import 'package:workplace/imports.dart';

class NotificationScreen extends StatefulWidget {
  final String mobileNumber;

  const NotificationScreen({Key? key, this.mobileNumber = "9171579456"})
      : super(key: key);
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    AppNotificationBloc appNotificationBloc =
        BlocProvider.of<AppNotificationBloc>(context);
    appNotificationBloc.add(GetAppNotificationListEvent(mContext: context));
  }

  @override
  void dispose() {
    super.dispose();
  }

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    AppNotificationBloc appNotificationBloc =
        BlocProvider.of<AppNotificationBloc>(context);
    AppDimens appDimens = AppDimens();
    appDimens.appDimensFind(context: context);

    String resolveLabel(String type, category) {
      switch (type) {
        case 'post':
          switch (category) {
            case 'birthday':
              return WorkplaceIcons.birthdayCakeIcon;
            case 'workanniversary':
              return WorkplaceIcons.anniversaryIcon;
            case 'marriageanniversary':
              return WorkplaceIcons.anniversaryIcon;
            default:
              return WorkplaceIcons.calendarImage;
          }
        case 'announcement':
          return WorkplaceIcons.announcementIcon;
        case 'holiday':
          return WorkplaceIcons.holidayIcon;
        case 'event':
          return WorkplaceIcons.calendarImage;
          case 'leave':
          return WorkplaceIcons.leaveIcon;
        default:
          return WorkplaceIcons.calendarImage;

      }
    }

    Color resolveColor(String status, category) {
      switch (status) {
        case 'post':
          switch (category) {
            case 'birthday':
              return AppColors.appAmber;
            case 'workanniversary':
              return AppColors.appPurple;
            case 'marriageanniversary':
              return  Colors.red;
            default:
              return AppColors.appAmber;
          }
        case 'announcement':
          return AppColors.appPurpleAccent;
        case 'holiday':
          return AppColors.appGreen;
        case 'event':
          return AppColors.appBlue;
        case 'leave':
          return Colors.blueAccent;
        default:
          return AppColors.appAmber;
      }
    }

    Widget noDataView() {
      return Padding(
        padding: EdgeInsets.only(top: appDimens.heightFullScreen() / 2.5),
        child: Center(
            child: Text(AppString.noNotifications,
          style: appStyles.noDataTextStyle(),
        )),
      );
    }

    Widget notificationCard() => appNotificationBloc.notificationList.isEmpty
        ? noDataView()
        :  ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        itemCount: appNotificationBloc.notificationList.length,
        itemBuilder: (context, index) {
          return NotificationCardWidget(
            userName: appNotificationBloc.notificationList[index].title,
            message: appNotificationBloc.notificationList[index].body,
            timeAgo: appNotificationBloc.notificationList[index].sendAt,
            imageUrl: resolveLabel(
                appNotificationBloc.notificationList[index].data?.type ?? "",
                appNotificationBloc
                    .notificationList[index].data?.postCategory ??
                    ""),
            color: resolveColor(
                appNotificationBloc.notificationList[index].data?.type ?? "",
                appNotificationBloc.notificationList[index].data?.postCategory ?? ""),
            postId: appNotificationBloc.notificationList[index].data!.postId,
            leaveId:appNotificationBloc.notificationList[index].data!.leaveId ,
            postType:appNotificationBloc.notificationList[index].data?.type ??"",
             isRead:appNotificationBloc.notificationList[index].isRead ,
            onClickPost: ()
            {

              if (appNotificationBloc.notificationList[index].isRead == 0) {
                BlocProvider.of<AppNotificationBloc>(context).add(MarkNotificationReadEvent(
                                 messageID:  appNotificationBloc.notificationList[index].id,
                                  postId: appNotificationBloc.notificationList[index].data!.postId,
                                  postType: appNotificationBloc.notificationList[index].data?.type ,
                                  leaveId: appNotificationBloc.notificationList[index].data!.leaveId ,

                              ));
              }

              if (appNotificationBloc.notificationList[index].data?.type == "post") {
                Navigator.push(
                    MainAppBloc.getDashboardContext,
                    SlideRightRoute(
                        widget: SinglePostScreen(
                          postId: appNotificationBloc.notificationList[index].data!.postId,
                        )))
                    .then((value) {
                  if(value == true)
                  {
                    AppNotificationBloc appNotificationBloc =
                    BlocProvider.of<AppNotificationBloc>(context);
                    appNotificationBloc.add(GetAppNotificationListEvent(mContext: context));

                  }
                });

              }
              else if (appNotificationBloc.notificationList[index].data?.type == "announcement") {
                Navigator.push(
                    MainAppBloc.getDashboardContext,
                    SlideRightRoute(
                        widget: AnnouncementDetailScreen(
                          postId: appNotificationBloc.notificationList[index].data!.postId,
                        ))).then((value) {
                  if(value == true)
                  {
                    AppNotificationBloc appNotificationBloc =
                    BlocProvider.of<AppNotificationBloc>(context);
                    appNotificationBloc.add(GetAppNotificationListEvent(mContext: context));

                  }
                });
              }
              else if (appNotificationBloc.notificationList[index].data?.type == "leave")
              {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=> LeaveDetailScreen(leaveId:appNotificationBloc.notificationList[index].data!.leaveId,
                    ))
                )     .then((value) {
                  if(value == true)
                  {
                    AppNotificationBloc appNotificationBloc =
                    BlocProvider.of<AppNotificationBloc>(context);
                    appNotificationBloc.add(GetAppNotificationListEvent(mContext: context));

                  }
                });
              }
              else if( appNotificationBloc.notificationList[index].data?.type =="leave_action")
              {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=> LeaveDetailScreen(
                        leaveId: appNotificationBloc.notificationList[index].data!.leaveId,
                        title: AppString.leaveRequest)))     .then((value) {
                  if(value == true)
                  {
                    AppNotificationBloc appNotificationBloc =
                    BlocProvider.of<AppNotificationBloc>(context);
                    appNotificationBloc.add(GetAppNotificationListEvent(mContext: context));

                  }
                });
              }
              else if (appNotificationBloc.notificationList[index].data?.type == "event") {
                Navigator.push(MainAppBloc.getDashboardContext,
                    SlideRightRoute(widget: const EventDetailScreen()))     .then((value) {
                  if(value == true)
                  {
                    AppNotificationBloc appNotificationBloc =
                    BlocProvider.of<AppNotificationBloc>(context);
                    appNotificationBloc.add(GetAppNotificationListEvent(mContext: context));

                  }
                });
              }
            },
          );
        });

    return ContainerFirst(
        contextCurrentView: context,
        isSingleChildScrollViewNeed: false,
        isListScrollingNeed: true,
        appBarHeight: 50,
        appBar: const CommonAppBar(
          title: AppString.notifications,
          icon: WorkplaceIcons.backArrow,
        ),
        containChild: BlocConsumer<AppNotificationBloc, AppNotificationState>(
          listener: (BuildContext context, AppNotificationState state) {
            // if(state is MarkNotificationReadState)
            //   {
            //       if (state.postType == "post") {
            //         Navigator.push(
            //             MainAppBloc.getDashboardContext,
            //             SlideRightRoute(
            //                 widget: SinglePostScreen(
            //               postId: state.postId,
            //             )))
            //             .then((value) {
            //               if(value == true)
            //                 {
            //                   AppNotificationBloc appNotificationBloc =
            //                   BlocProvider.of<AppNotificationBloc>(context);
            //                   appNotificationBloc.add(GetAppNotificationListEvent(mContext: context));
            //
            //                 }
            //         });
            //
            //       }
            //       else if (state.postType == "announcement") {
            //         Navigator.push(
            //             MainAppBloc.getDashboardContext,
            //             SlideRightRoute(
            //                 widget: AnnouncementDetailScreen(
            //               postId: state.postId,
            //             ))).then((value) {
            //           if(value == true)
            //           {
            //             AppNotificationBloc appNotificationBloc =
            //             BlocProvider.of<AppNotificationBloc>(context);
            //             appNotificationBloc.add(GetAppNotificationListEvent(mContext: context));
            //
            //           }
            //         });
            //       } else if (state.postType == "leave")
            //       {
            //         Navigator.of(context).push(
            //             MaterialPageRoute(builder: (context)=> LeaveDetailScreen(postId: state.leaveId,
            //             ))
            //         )     .then((value) {
            //           if(value == true)
            //           {
            //             AppNotificationBloc appNotificationBloc =
            //             BlocProvider.of<AppNotificationBloc>(context);
            //             appNotificationBloc.add(GetAppNotificationListEvent(mContext: context));
            //
            //           }
            //         });
            //       }
            //       else if( state.postType=="leave_action")
            //        {
            //          Navigator.of(context).push(
            //              MaterialPageRoute(builder: (context)=> LeaveDetailScreen(postId: state.leaveId,title: AppString.leaveRequest)))     .then((value) {
            //            if(value == true)
            //            {
            //              AppNotificationBloc appNotificationBloc =
            //              BlocProvider.of<AppNotificationBloc>(context);
            //              appNotificationBloc.add(GetAppNotificationListEvent(mContext: context));
            //
            //            }
            //          });
            //        }
            //       else if (state.postType == "event") {
            //         Navigator.push(MainAppBloc.getDashboardContext,
            //             SlideRightRoute(widget: const EventDetailScreen()))     .then((value) {
            //           if(value == true)
            //           {
            //             AppNotificationBloc appNotificationBloc =
            //             BlocProvider.of<AppNotificationBloc>(context);
            //             appNotificationBloc.add(GetAppNotificationListEvent(mContext: context));
            //
            //           }
            //         });
            //       }
            //
            //   }
          },
          builder: (context, state) {
            if (state is AppNotificationLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                await appNotificationBloc.fetchNotificationData(context);
              },
              child: ListView(
                padding: EdgeInsets.zero,
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                   SizedBox(
                    height: 10.sp,
                  ),
                  notificationCard(),
                ],
              ),
            );
          },
        ));
  }
}
