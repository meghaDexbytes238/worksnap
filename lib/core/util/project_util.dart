import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter/material.dart';
import 'package:platform_detector/enums.dart';
import 'package:platform_detector/platform_detector.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:workplace/core/util/utils.dart';
import 'package:workplace/core/util/api_constant.dart';
// import 'package:workplace/features/presentation/widgets/alerts/error_alert.dart'; //Add this dependancy  timeago: ^2.0.22

final List<String> imageExtensions = <String>[
  "JPG",
  "PNG",
  "TIFF",
  "JPEG",
  "GIF",
  "WEBP",
  "PSD",
  "RAW",
  "BMP",
  "HEIF",
  "INDD",
  "JPEG 2000"
];

class ProjectUtil {
  static var screenSize;
  static DateTime? oldDate;
  screenSizeValue(context) {
    screenSize = MediaQuery.of(context).size;
    return screenSize;
  }

  String initials(String givenName, String familyName) {
    return ((givenName.isNotEmpty == true ? givenName[0] : "") +
        ((familyName.isNotEmpty == true ? familyName[0] : "")).toUpperCase());
  }

  String getCompareDateStr(String timestamp, String format, int index) {
    String formattedTime = "";
    try {
      if (index <= 0) {
        oldDate = null;
      }
      int time = int.parse(timestamp);
      debugPrint('error in formatting $time');
      DateTime date = new DateTime.fromMillisecondsSinceEpoch(time);
      if (oldDate == null) {
        oldDate = date;
        formattedTime = new DateFormat(format).format(oldDate!);
      } else {
        String formattedTimeOld = "";
        String formattedTimeCurrent = "";
        formattedTimeOld = new DateFormat(format).format(oldDate!);
        formattedTimeCurrent = new DateFormat(format).format(date);
        if (formattedTimeOld == formattedTimeCurrent) {
          formattedTime = "";
        } else {
          oldDate = date;
          formattedTime = new DateFormat(format).format(oldDate!);
        }
      }
    } catch (e) {
      formattedTime = "";
      debugPrint('error in formatting $e');
    }
    return formattedTime;
  }

  /*================== Convert time from timestamp ===================*/
  String getTime(int timestamp, String format) {
    String formattedTime = "";
    try {
      formattedTime = DateFormat(format)
          .format(DateTime.fromMicrosecondsSinceEpoch(timestamp));
    } catch (e) {
      formattedTime = "";
      printP('error in formatting $e');
    }
    return formattedTime;
  }

  String getCountDownTimer(int timestamp, String format) {
    String formattedTime = "";
    try {
      formattedTime = DateFormat(format)
          .format(DateTime.fromMicrosecondsSinceEpoch(timestamp));
    } catch (e) {
      formattedTime = "";
      printP('error in formatting $e');
    }
    return formattedTime;
  }

  //Status bar color update
  void statusBarColor(
      {Color? statusBarColor,
      Color? navigationBarColor,
      bool isAppStatusDarkBrightness = true,
      bool isNavigationBarDarkBrightness = false}) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarIconBrightness:
    //   isAppStatusDarkBrightness ? Brightness.dark : Brightness.light,
    //   systemNavigationBarIconBrightness:
    //   isNavigationBarDarkBrightness ? Brightness.light : Brightness.dark,
    //   statusBarColor: statusBarColor,
    //   systemNavigationBarColor: navigationBarColor,
    // ));
    statusBarColor ??= Colors.transparent;
    navigationBarColor ??= Colors.black;
    final PlatformType currentPlatformType = PlatformDetector.platform.type;
    try {
      if(currentPlatformType == PlatformType.web){
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarIconBrightness:
          isAppStatusDarkBrightness ? Brightness.dark : Brightness.light,
          systemNavigationBarIconBrightness:
          isNavigationBarDarkBrightness ? Brightness.light : Brightness.dark,
          statusBarColor: statusBarColor,
          systemNavigationBarColor: navigationBarColor,
        ));
      }
      else {
        if (Platform.isAndroid) {
          try {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarIconBrightness:
              isAppStatusDarkBrightness ? Brightness.dark : Brightness.light,
              systemNavigationBarIconBrightness: isNavigationBarDarkBrightness
                  ? Brightness.dark
                  : Brightness.light,
              statusBarColor: statusBarColor,
              systemNavigationBarColor: navigationBarColor,
            ));
            //top bar icons));
          } catch (e) {
            print(e);
          }
        }
        else if (Platform.isIOS) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarIconBrightness:
            isAppStatusDarkBrightness ? Brightness.dark : Brightness.light,
            systemNavigationBarIconBrightness:
            isNavigationBarDarkBrightness ? Brightness.light : Brightness.dark,
            statusBarColor: statusBarColor,
            systemNavigationBarColor: navigationBarColor,
          ));
        }
        else {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarIconBrightness:
            isAppStatusDarkBrightness ? Brightness.dark : Brightness.light,
            systemNavigationBarIconBrightness:
            isNavigationBarDarkBrightness ? Brightness.light : Brightness.dark,
            statusBarColor: statusBarColor,
            systemNavigationBarColor: navigationBarColor,
          ));
        }
      }

    } catch (e) {
      print(e);
    }
  }

  //Print message/response on logcat
  printP(String body) {
    try {
      if (!ApiConst.isProduction) {
        debugPrint(body);
      }
    } catch (e) {
      debugPrint("$e");
    }
  }

  //get first letter from string
  getFirstLetterFromName(String word) {
    var firstAndLastLetter = "NA";

    if (word.trim() != "") {
      List wordSplit = [];
      var firstLetter = "";
      var lastLetter = "";
      if (word.contains(" ")) {
        wordSplit = word.split(" ");
        try {
          firstLetter = String.fromCharCode(word.runes.first);
        } catch (e) {
          debugPrint("$e");
        }
        if (wordSplit.length > 1) {
          try {
            String lastWordString = wordSplit[1];
            lastLetter = String.fromCharCode(lastWordString.runes.first);
          } catch (e) {
            debugPrint("$e");
          }
        }
      } else {
        try {
          firstLetter = String.fromCharCode(word.runes.first);
          firstLetter = getDecodedValue(firstLetter);
        } catch (e) {
          debugPrint("$e");
        }
      }
      firstAndLastLetter = firstLetter.toString().toUpperCase() +
          lastLetter.toString().toUpperCase();
    } else {
      return firstAndLastLetter;
    }
    return firstAndLastLetter;
  }

  //get build version of app
  getVersionName() async {
    String projectVersion = "";
    /*try {
      projectVersion = await GetVersion.projectVersion;
      printP('$projectVersion');
    } catch (e) {
      projectVersion = '';
      printP('$e');
    }*/
    return projectVersion;
  }

  //get decoded format
  getDecodedValue(String value) {
    String decodedValue = value;
    try {
      decodedValue = utf8.decode(value.codeUnits);
    } catch (err) {
      printP("$err");
    }
    return decodedValue;
  }

  String getTimeAgo({required int timestamp, required String format}) {
    //Note /*
    //
    //
    // Add this dependancy
    // timeago: ^2.0.22
    //
    // */
    String formattedTime = "";
    try {
      final fifteenAgo = DateTime.fromMillisecondsSinceEpoch(timestamp);
      formattedTime = timeago.format(fifteenAgo, locale: 'en');
    } catch (e) {
      formattedTime = "";
      printP('error in formatting $e');
    }
    return formattedTime;
  }

  Color colorFromIntString({String stringColor = "0xFF6C6C6C"}) {
    Color color = Colors.blueGrey;
    try {
      color = Color(int.parse(stringColor));
    } catch (e) {
      debugPrint("$e");
    }
    return color;
  }
  //Exit from app
  Future<void> logOutFromAppUnAuthUser({context}) async {
    try {
      await PrefUtils().clearAll();
      /*  Navigator.pushAndRemoveUntil(
          context,
          SlideRightRoute(
              widget: AppScreensFilesLink().mLoginOptionScreen()),
          ModalRoute.withName(screenLoginScreen));*/
    } catch (e) {
      debugPrint("$e");
    }
  }

  Future? removeBadge() {
    try {
      // FlutterAppBadger.removeBadge();
    } catch (e) {
      debugPrint("$e");
    }
    return null;
  }

  Future? addBadge(count) {
    if (count > 0) {
      try {
        try {
          // FlutterAppBadger.updateBadgeCount(count);
        } catch (e) {
          debugPrint("$e");
        }
      } catch (e) {
        debugPrint("$e");
      }
    } else {
      try {
        removeBadge();
      } catch (e) {
        debugPrint("$e");
      }
    }

    return null;

  }

  Future deviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    //IOS
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print(iosInfo);
      //Device_os_version
      PrefUtils().readStr( WorkplaceNotificationConst.deviceOsVersionC).then((value) {
        if (value == null || value == '') {
          PrefUtils().saveStr(
              WorkplaceNotificationConst.deviceOsVersionC, iosInfo.systemVersion);
        } else {}
      });

      //Device id
      PrefUtils().readStr(WorkplaceNotificationConst.deviceIdC).then((value) {
        if (value == null || value == '') {
          //device id
          PrefUtils().saveStr(WorkplaceNotificationConst.deviceIdC, iosInfo.identifierForVendor);
        } else {
          //  PrefUtils().saveStr(deviceIdC, iosInfo.identifierForVendor);
        }
      });

      //device name
      PrefUtils().readStr(WorkplaceNotificationConst.deviceNameC).then((value) {
        if (value == null || value == '') {
          PrefUtils().saveStr( WorkplaceNotificationConst.deviceNameC, iosInfo.name);
        } else {
          //  PrefUtils().saveStr(deviceNameC, androidInfo.brand);
        }
      });

      //model
      PrefUtils().readStr(WorkplaceNotificationConst.deviceModelC).then((value) {
        if (value == null || value == '') {
          PrefUtils().saveStr(WorkplaceNotificationConst.deviceModelC, iosInfo.model);
        } else {
          //  PrefUtils().saveStr(deviceNameC, androidInfo.brand);
        }
      });


    }
    // Android
    else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print(androidInfo);

      //device os version
      PrefUtils().readStr( WorkplaceNotificationConst.deviceOsVersionC).then((value) {
        if (value == null || value == '') {
          PrefUtils().saveStr(
              WorkplaceNotificationConst.deviceOsVersionC, androidInfo.version.release);
        } else {
          //  PrefUtils().saveStr(deviceOsVersionC, androidInfo.version.release);
          // print("device os: $value");
        }
      });

      //device id
      PrefUtils().readStr( WorkplaceNotificationConst.deviceIdC).then((value) {
        if (value == null || value == '') {
          PrefUtils().saveStr( WorkplaceNotificationConst.deviceIdC, androidInfo.id);
        } else {
          //  PrefUtils().saveStr(deviceIdC, androidInfo.androidId);
        }
      });

      //device name
      PrefUtils().readStr( WorkplaceNotificationConst.deviceNameC).then((value) {
        if (value == null || value == '') {
          PrefUtils().saveStr( WorkplaceNotificationConst.deviceNameC, androidInfo.brand);
        } else {
          //  PrefUtils().saveStr(deviceNameC, androidInfo.brand);
        }
      });

      //model name
      PrefUtils().readStr( WorkplaceNotificationConst.deviceModelC).then((value) {
        if (value == null || value == '') {
          PrefUtils().saveStr(WorkplaceNotificationConst.deviceModelC, androidInfo.model);
        } else {
          //  PrefUtils().saveStr(deviceNameC, androidInfo.brand);
        }
      });

    }
    else {

    }


  }

  Future<String?> checkAppVersion(
      deviceType, versionUpdatePopupCallBack, context) async {
    int deviceType = 1;
    if (Platform.isIOS) {
      deviceType = 1;
    } else if (Platform.isAndroid) {
      deviceType = 2;
    }else{
      deviceType = 3;
    }
    //1 for ios
    // apiRequest.checkAppVersion(deviceType: deviceType).then((result) {
    //   if (result != null) {
    //     if (result.success && result.result != null) {
    //       //Android
    //       if (deviceType == 2) {
    //         if (result.result.version != null) {
    //           String playStoreAndroidVersion = result.result.version;
    //           try {
    //             /*GetVersion.projectVersion.then((appVersion) {
    //               if (playStoreAndroidVersion != null &&
    //                   playStoreAndroidVersion != appVersion) {
    //                 versionUpdatePopupCallBack(true);
    //               } else {
    //                 versionUpdatePopupCallBack(true);
    //               }
    //             });*/
    //           } catch (e) {
    //             debugPrint('$e');
    //           }
    //         }
    //       }
    //       //Ios
    //       if (deviceType == 1) {
    //         if (result.result.version != null) {
    //           String iOSAppStoreVersion = result.result.version;
    //           try {
    //             /*GetVersion.projectCode.then((appVersion) {
    //               if (iOSAppStoreVersion != null &&
    //                   iOSAppStoreVersion != appVersion) {
    //                 versionUpdatePopupCallBack(true);
    //               } else {
    //                 versionUpdatePopupCallBack(true);
    //               }
    //             });*/
    //           } catch (e) {
    //             debugPrint("$e");
    //           }
    //         }
    //       }
    //     } else {
    //       ErrorAlert(
    //           context: context,
    //           isItForInternet: true,
    //           alertTitle: AppString.appName,
    //           message: result.msg,
    //           callBackYes: (context1) async {
    //             Navigator.pop(context1);
    //             if (result.statusCode == -2000) {
    //               exit(0);
    //               //await sharedPreferencesFile.clearAll();
    //             }
    //           });
    //     }
    //     return null;
    //   } else {
    //     return null;
    //   }
    // });
    return null;
  }

  isImageFile({required String item}) {
    bool isImageFile = false;
    try {
      isImageFile =
          imageExtensions.contains(item.split('.').last.toUpperCase());
    } catch (e) {
      debugPrint("$e");
    }
    return isImageFile;
    // return item.endsWith(".jpg");
  }

  double intToDouble(value) {
    double result = 0.0;
    try {
      result =
          value.runtimeType == int ? double.parse(value.toString()) : value;
    } catch (e) {
      print(e);
    }
    return result;
  }
}

ProjectUtil projectUtil = new ProjectUtil();
