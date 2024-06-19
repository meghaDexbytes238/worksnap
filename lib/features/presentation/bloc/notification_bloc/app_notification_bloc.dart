import 'package:workplace/imports.dart';
import '../../../../core/util/app_navigator/app_navigator.dart';

class AppNotificationBloc extends Bloc<AppNotificationEvent, AppNotificationState> {
  GetAppNotificationList getNotificationList = GetAppNotificationList(RepositoryImpl(WorkplaceDataSourcesImpl()));
  PutMarkNotificationDisplayed markNotificationDisplayed = PutMarkNotificationDisplayed(RepositoryImpl(WorkplaceDataSourcesImpl()));
  PutMarkNotificationRead markNotificationRead = PutMarkNotificationRead(RepositoryImpl(WorkplaceDataSourcesImpl()));
  PutMarkNotificationReadDisplay markNotificationReadDisplay = PutMarkNotificationReadDisplay(RepositoryImpl(WorkplaceDataSourcesImpl()));

  List<NotificationDataList> notificationList = [];

  AppNotificationBloc() : super(AppNotificationInitState()) {

    on<GetAppNotificationListEvent>((event, emit) async {
      emit(AppNotificationLoadingState());
      await fetchNotificationData(event.mContext!);
      // Either<Failure, NotificationDataModel> response = await getNotificationList.call('');
      // response.fold((left)
      // {
      //   if(left is UnauthorizedFailure)
      //   {
      //     appNavigator.tokenExpireUserLogout(event.mContext!);
      //   }
      // },(right){
      //   notificationList = right.data ?? [];
      //   emit(FetchAppNotificationDataState());
      // }
      // );

    });

    on<MarkNotificationDisplayedEvent>((event,emit) async {
      Either<Failure, dynamic> response = await markNotificationDisplayed.call('');
      response.fold((left)
      {
        if(left is UnauthorizedFailure)
        {
          appNavigator.tokenExpireUserLogout(event.mContext!);
        }
      },(right){
        emit(MarkNotificationDisplayedState());
      }
      );
    });

    on<MarkNotificationReadEvent>((event,emit) async {
      Either<Failure, dynamic> response = await markNotificationRead.call(MarkNotificationReadParams(
        messageID: event.messageID
      ));
      response.fold((left)
      {
        if(left is UnauthorizedFailure)
        {
          appNavigator.tokenExpireUserLogout(event.mContext!);
        }
      },(right){
        emit(MarkNotificationReadState(postType: event.postType,leaveId: event.leaveId,postId: event.postId));
      }
      );
    });

    on<MarkNotificationRedirectReadDisplayEvent>((event,emit) async {
      Either<Failure, dynamic> response = await markNotificationReadDisplay.call(MarkNotificationReadDisplayParams(
          messageID: event.msgId
      ));
      response.fold((left)
      {
        if(left is UnauthorizedFailure)
        {
          appNavigator.tokenExpireUserLogout(event.mContext!);
        }
      },(right){
        emit(MarkNotificationReadDisplayedState());
      }
      );
    });


  }

  Future<void> fetchNotificationData(BuildContext context)
  {
    return getNotificationList.call('').fold((left)
    {
      if(left is UnauthorizedFailure)
      {
        appNavigator.tokenExpireUserLogout(context);
      }
    },(right){
      notificationList = right.data ?? [];
      emit(FetchAppNotificationDataState());
    }
    );
  }

}
