import 'package:workplace/core/util/app_navigator/app_navigator.dart';
import 'package:workplace/imports.dart';
import 'package:workplace/features/presentation/widgets/alerts/error_alert.dart';

import '../../../data/models/notification_data_model.dart';

abstract class AppNotificationState {
  NotificationDataModel? notificationDataModel;
  AppNotificationState({this.notificationDataModel});
  void updateModel({notificationDataModel}) {
    this.notificationDataModel = notificationDataModel;
  }

  get getFaqModel => notificationDataModel;
}

class AppNotificationInitState extends AppNotificationState {}
class AppNotificationLoadingState extends AppNotificationState {}
class FetchAppNotificationDataState extends AppNotificationState {}



class AppNotificationInProgressState extends AppNotificationState {
  Map? requestData;
  AppNotificationInProgressState({this.requestData});
}

class AppNotificationErrorState extends AppNotificationState {
  AppNotificationErrorState(
      {required BuildContext context,
        String? errorMessage,
        String? phone,
        int? code,
        okCallBack}) {
    ErrorAlert(
        context: context,
        message: errorMessage,
        callBackYes: (mContext) {
          if (okCallBack != null) {
            okCallBack();
          } else {
            appNavigator.popBackStack(mContext);
          }
        });
  }
}

class GetAppNotificationDataDoneState extends AppNotificationState {
  NotificationDataModel? responseData;
  GetAppNotificationDataDoneState({this.responseData}) : super();
  @override
  String toString() => ' }';
}

class MarkNotificationDisplayedState extends AppNotificationState{
}

class MarkNotificationReadState extends AppNotificationState{
String? postType;
int? postId;
int? leaveId;
MarkNotificationReadState({ this.postType,this.postId,this.leaveId});
}

class MarkNotificationReadDisplayedState extends AppNotificationState{
}