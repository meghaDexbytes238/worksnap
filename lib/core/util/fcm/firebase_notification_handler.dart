import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:html/parser.dart';
import 'package:workplace/core/core.dart';
import 'package:workplace/features/presentation/presentation.dart';
import 'notification_bloc/notification_bloc.dart';
import 'notification_bloc/notification_event.dart';
// import 'permissions.dart';

class FirebaseNotifications {
  //FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  static BuildContext? mContext;
  static Map<String, dynamic>? killedAppNotificationResponse;
  int count =1 ;
  var updateIcon;
  var messageType = 0;
  var messageTypeID = 0;
  var appInKillState = 1;
  var appInForeground = 2;
  var appInBackground = 3;
  static String clickedNotificationId = "";
  bool isCalled = false;
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'Urgent', 'Urgent',
      importance: Importance.max, priority: Priority.max);

  var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
      presentAlert: true, presentBadge: true, presentSound: true);
  var macPlatformChannelSpecifics = const MacOSNotificationDetails(
      presentAlert: true, presentBadge: true, presentSound: true);
  var initializationSettingsAndroid =
  const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = const IOSInitializationSettings();

  void setUpFirebase(BuildContext context, var updateNotificationIcon) {
    firebaseCloudMessagingListeners();
    mContext = context;
    updateIcon = updateNotificationIcon;
  }

  // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //   await Firebase.initializeApp();
  //
  //
  //   final String? msgTitle = message.notification!.title;
  //   final String? msgBody = message.notification!.body;
  //   if (msgTitle != null && msgBody != null) {
  //     print("Handling a background message: ${message.messageId}");
  //     print("onBackgroundMessage $message");
  //   }
  // }

  void firebaseCloudMessagingListeners() {
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        Map<String, dynamic> notificationResponse = notificationPars(message);
        print("print....Kill state noticfications......... ");
        //redirectToScreenFromBackground(message, notificationResponse);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      try {
        PrefUtils()
            .saveBool(WorkplaceNotificationConst.anyNewNotificationC, true);
        updateNotificationUnreadCount();
        updateNotificationCount(notificationData: message);
      } catch (e) {
        print(e);
      }
      generateLocalNotification(message);
    });
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      try {
        PrefUtils()
            .saveBool(WorkplaceNotificationConst.anyNewNotificationC, true);
        updateNotificationUnreadCount();
        updateNotificationCount(notificationData: message);
      } catch (e) {
        print(e);
      }
      if (!isCalled) {
        //isCalled = true;
        Map<String, dynamic> notificationResponse = notificationPars(message);
        print("print....background notification function.....");
        redirectToScreenFromBackground(message, notificationResponse); // bg......
      }
    });

    projectUtil.printP("body");
  }

  // void backgroundMessaging(BuildContext context) {
  //
  //   FirebaseMessaging.onBackgroundMessage((message) async {
  //     try {
  //       PrefUtils()
  //           .saveBool(WorkplaceNotificationConst.anyNewNotificationC, true);
  //       updateNotificationUnreadCount();
  //       updateNotificationCount(notificationData: message);
  //     } catch (e) {
  //       print(e);
  //     }
  //     generateLocalNotification(message);
  //   });
  // }

  Future<void> getToken() async {
    // _firebaseMessaging.requestNotificationPermissions();
    //Permissions();
    firebaseCloudMessagingListeners();
    var token = await FirebaseMessaging.instance.getToken();
    //var token = await FirebaseMessaging.instance.getAPNSToken();
    if (token != null) {
      await PrefUtils().saveStr(WorkplaceNotificationConst.deviceTokenC, token);
    }
  }

  updateNotificationUnreadCount() {
    try {
      /*int unreadCount = Provider.of<UserAuthState>(mContext!, listen: false)
          .getNotificationUnreadCount;
      unreadCount = unreadCount + 1;
      Provider.of<UserAuthState>(mContext!, listen: false)
          .setNotificationUnreadCount = unreadCount;*/
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> notificationPars(RemoteMessage notificationData) {
    //
    Map<String, dynamic> notificationResponse = {'title': '', 'body': ''};
    bool isSilentNotification = false;
    // if (notificationData.data != null && notificationData.data.length > 0) {
    String title = "";
    String body = "";
    // if (Platform.isAndroid) {
    try {
      if (notificationData.notification != null) {
        RemoteNotification? notificationMap = notificationData.notification;
        title = parse(notificationMap!.title!).body!.text.trim();
        body = parse(notificationMap.body!).body!.text.trim();
      } else {
        isSilentNotification = true;
      }
    } catch (e) {
      isSilentNotification = true;
      print(e);
    }
    //Get extra data from notification
    Map<String, dynamic> notificationDataTemp = {};
    notificationDataTemp = notificationData
        .data; // Just get string data from notification data key for parsing
    notificationResponse = {
      'title': title,
      'body': body,
      'data': notificationDataTemp,
      'isSilentNotification': isSilentNotification
    };
    // }
    return notificationResponse;
  }

  generateLocalNotification(RemoteMessage notificationData) {
    BlocProvider.of<UserProfileBloc>(mContext!)
        .add(FetchProfileDetails(mContext: mContext!));
    bool isNewNotificationId = false;
    try {
      if (clickedNotificationId != notificationData.messageId) {
        clickedNotificationId = notificationData.messageId!;
        isNewNotificationId = true;
      }
    } catch (e) {
      isNewNotificationId = true;
      print(e);
    }
    if (isNewNotificationId) {
      Map<String, dynamic> notificationResponse =
      notificationPars(notificationData);
      if (notificationResponse.isNotEmpty) {
        bool isSilentNotification =
        notificationResponse.containsKey('isSilentNotification')
            ? notificationResponse['isSilentNotification']
            : true;
        try {
          if (!isSilentNotification) {
            var initializationSettings = InitializationSettings(
                android: initializationSettingsAndroid,
                iOS: initializationSettingsIOS);
            flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
            flutterLocalNotificationsPlugin!.initialize(initializationSettings,
                onSelectNotification: (String? payload) async {
                  redirectToScreen(notificationResponse);
                });
            _showNotificationWithDefaultSound(
                title: parse(notificationResponse['title']).body!.text.trim(),
                description:
                parse(notificationResponse['body']).body!.text.trim());
            try {
              projectUtil.printP("$mContext");
              BlocProvider.of<NotificationBloc>(mContext!)
                  .add(AllNotificationBadgeRefreshEvent());
            } catch (e) {
              projectUtil.printP("$e");
            }
          }
        } catch (e) {
          print(e);
        }
      }
    }
  }

  //Add screen navigation code here to redirect on any type click
  redirectToScreen(Map<String, dynamic> notificationResponse,
      {BuildContext? currentContext}) async {
    if (notificationResponse.isNotEmpty &&
        notificationResponse['data'] != null &&
        notificationResponse['data'].isNotEmpty) {
      Map<String, dynamic> data = notificationResponse['data'];
      String redirectionType = data['type'];
      if (redirectionType == 'post') {
        try {
          int postId = int.parse(data['postId']);
          print("print....redirect to screen");
          Navigator.push(currentContext ?? mContext!,
              SlideRightRoute(widget: SinglePostScreen(postId: postId)));
        } catch (e) {
          print(e);
        }

        try {
          if (data.containsKey('postId')) {
            int postId = int.parse(data['postId']);
            BlocProvider.of<AppNotificationBloc>(mContext!).add(
                MarkNotificationRedirectReadDisplayEvent(
                    mContext: mContext!, msgId: postId));
          }
        } catch (e) {
          print(e);
        }
      } else if (redirectionType == 'announcement') {
        try {
          int postId = int.parse(data['postId']);
          Navigator.push(
              currentContext ?? mContext!,
              SlideRightRoute(
                  widget: AnnouncementDetailScreen(postId: postId)));
        } catch (e) {
          print(e);
        }
        try {
          if (data.containsKey('postId')) {
            int postId = int.parse(data['postId']);
            AppNotificationBloc().add(MarkNotificationRedirectReadDisplayEvent(
                mContext: currentContext ?? mContext!, msgId: postId));
          }
        } catch (e) {
          print(e);
        }
      } else if (redirectionType == 'leave') {
        try {
          int postId = int.parse(data['leaveId']);
          Navigator.push(currentContext ?? mContext!,
              SlideRightRoute(widget: LeaveDetailScreen(leaveId: postId)));
        } catch (e) {
          print(e);
        }
        try {
          if (data.containsKey('leaveId')) {
            int leaveId = int.parse(data['leaveId']);
            AppNotificationBloc().add(MarkNotificationRedirectReadDisplayEvent(
                mContext: currentContext ?? mContext!, msgId: leaveId));
          }
        } catch (e) {
          print(e);
        }
      } else if (redirectionType == 'leave_action') {
        try {
          int postId = int.parse(data['leaveId']);
          Navigator.push(currentContext ?? mContext!,
              SlideRightRoute(widget: LeaveDetailScreen(leaveId: postId,title: AppString.leaveRequest)));
        } catch (e) {
          print(e);
        }

        try {
          if (data.containsKey('leaveId')) {
            int leaveId = int.parse(data['leaveId']);
            AppNotificationBloc().add(MarkNotificationRedirectReadDisplayEvent(
                mContext: currentContext ?? mContext!, msgId: leaveId));
          }
        } catch (e) {
          print(e);
        }
      } else if (redirectionType == 'event') {
        try {
          int postId = int.parse(data['postId']);
          Navigator.push(currentContext ?? mContext!,
              SlideRightRoute(widget: const EventDetailScreen()));
        } catch (e) {
          print(e);
        }

        try {
          if (data.containsKey('postId')) {
            int postId = int.parse(data['postId']);
            AppNotificationBloc().add(MarkNotificationRedirectReadDisplayEvent(
                mContext: currentContext ?? mContext!, msgId: postId));
          }
        } catch (e) {
          print(e);
        }
      } else {
        // Navigator.push(
        //   currentContext!=null?currentContext:mContext!,
        //   SlideRightRoute(
        //       widget: NotificationScreen()),
        // );

        try {
          if (data.containsKey('message_id')) {
            int messageIdInt = int.parse(data['message_id']);
            // AppNotificationListBloc().add(NotificationRedirectReadDataEvent
            //   (mContext: currentContext!=null?currentContext:mContext!, messageId:messageIdInt));
          }
        } catch (e) {
          print(e);
        }
      }
    }
  }

  redirectToScreenFromBackground(
      RemoteMessage notificationData,
      Map<String, dynamic> notificationResponse,
      ) {
    killedAppNotificationResponse = notificationPars(notificationData);
    bool isSilentNotification =
    killedAppNotificationResponse!.containsKey('isSilentNotification')
        ? killedAppNotificationResponse!['isSilentNotification']
        : true;
    if (!isSilentNotification) {
      Map<String, dynamic> data = notificationResponse['data'];
      String redirectionType = data['type'];
      if (redirectionType == 'post') {
        try {
          int postId = int.parse(data['postId']);
          print("print.....Kill state noticfications rounting ${count++}  ");
          Navigator.push(mContext!,
              SlideRightRoute(widget: SinglePostScreen(postId: postId)));
        } catch (e) {
          print(e);
        }

        try {
          if (data.containsKey('postId')) {
            int postId = int.parse(data['postId']);
            BlocProvider.of<AppNotificationBloc>(mContext!).add(
                MarkNotificationRedirectReadDisplayEvent(
                    mContext: mContext!, msgId: postId));
          }
        } catch (e) {
          print(e);
        }
      } else if (redirectionType == 'announcement') {
        try {
          int postId = int.parse(data['postId']);
          Navigator.push(
              mContext!,
              SlideRightRoute(
                  widget: AnnouncementDetailScreen(postId: postId)));
        } catch (e) {
          print(e);
        }
        try {
          if (data.containsKey('postId')) {
            int postId = int.parse(data['postId']);
            AppNotificationBloc().add(MarkNotificationRedirectReadDisplayEvent(
                mContext: mContext!, msgId: postId));
          }
        } catch (e) {
          print(e);
        }
      } else if (redirectionType == 'leave') {
        try {
          int postId = int.parse(data['leaveId']);
          Navigator.push(mContext!,
              SlideRightRoute(widget: LeaveDetailScreen(leaveId: postId)));
        } catch (e) {
          print(e);
        }
        try {
          if (data.containsKey('leaveId')) {
            int leaveId = int.parse(data['leaveId']);
            AppNotificationBloc().add(MarkNotificationRedirectReadDisplayEvent(
                mContext: mContext!, msgId: leaveId));
          }
        } catch (e) {
          print(e);
        }
      } else if (redirectionType == 'leave_action') {
        try {
          int postId = int.parse(data['leaveId']);
          Navigator.push(mContext!,
              SlideRightRoute(widget: LeaveDetailScreen(leaveId: postId,title: AppString.leaveRequest)));
        } catch (e) {
          print(e);
        }

        try {
          if (data.containsKey('leaveId')) {
            int leaveId = int.parse(data['leaveId']);
            AppNotificationBloc().add(MarkNotificationRedirectReadDisplayEvent(
                mContext: mContext!, msgId: leaveId));
          }
        } catch (e) {
          print(e);
        }
      } else if (redirectionType == 'event') {
        try {
          int postId = int.parse(data['postId']);
          Navigator.push(
              mContext!, SlideRightRoute(widget: const EventDetailScreen()));
        } catch (e) {
          print(e);
        }

        try {
          if (data.containsKey('postId')) {
            int postId = int.parse(data['postId']);
            AppNotificationBloc().add(MarkNotificationRedirectReadDisplayEvent(
                mContext: mContext!, msgId: postId));
          }
        } catch (e) {
          print(e);
        }
      } else {
        // Navigator.push(
        //   currentContext!=null?currentContext:mContext!,
        //   SlideRightRoute(
        //       widget: NotificationScreen()),
        // );

        try {
          if (data.containsKey('message_id')) {
            int messageIdInt = int.parse(data['message_id']);
            // AppNotificationListBloc().add(NotificationRedirectReadDataEvent
            //   (mContext: currentContext!=null?currentContext:mContext!, messageId:messageIdInt));
          }
        } catch (e) {
          print(e);
        }
      }

      // Navigator.pushAndRemoveUntil(
      //     mContext!, SlideRightRoute(widget: HomeMenuScreen()
      // ), (route) => false);
    }
  }

  // Method 2
  Future _showNotificationWithDefaultSound(
      {String title = "", String description = ""}) async {
    // title = "${appString.appName} App";
    //   title = "";

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
        macOS: macPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin!.show(
      0,
      title,
      description,
      platformChannelSpecifics,
      payload: 'default',
    );
  }

  Future<void> updateNotificationCount({notificationData}) async {
//    print('on message $notificationData');
    int count = await PrefUtils()
        .readInt(WorkplaceNotificationConst.notificationUnreadCountC);
    int countFinal = 0;
    if (count == -1) {
      count = 1;
    } else {
      count = count + 1;
    }
    await PrefUtils()
        .saveInt(WorkplaceNotificationConst.notificationUnreadCountC, count);
    countFinal = countFinal + count;
    projectUtil.addBadge(countFinal);
    try {
      updateIcon(callFromNotification: true);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateCountOnNotificationClick() async {
    /* await AppUtilsFilesLink().appSharedPreferencesFile.saveInt(WorkplaceNotificationConst.anyNewNotificationC, 0);
    AppUtilsFilesLink().appProjectUtilFile.addBadge(0);
    readNotification = false;
    updateIcon(callFromNotification:true);*/
  }
}
