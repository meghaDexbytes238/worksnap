import 'package:intl/intl.dart';
import 'package:workplace/imports.dart';
import '../../../../core/util/app_navigator/app_navigator.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  GetLeaveType leaveTypeDetails =
      GetLeaveType(RepositoryImpl(WorkplaceDataSourcesImpl()));

  GetTeamLeave getTeamLeave =
      GetTeamLeave(RepositoryImpl(WorkplaceDataSourcesImpl()));

  GetLeaveData leaveDataDetails =
      GetLeaveData(RepositoryImpl(WorkplaceDataSourcesImpl()));

  PostLeaveApply sendLeaveApplyDetails =
      PostLeaveApply(RepositoryImpl(WorkplaceDataSourcesImpl()));

  PostLeaveStatusChange leaveStatusDetails =
      PostLeaveStatusChange(RepositoryImpl(WorkplaceDataSourcesImpl()));

  GetLeaveDetailById leaveDetailById =
      GetLeaveDetailById(RepositoryImpl(WorkplaceDataSourcesImpl()));

  PostLeaveStatusChange leaveStatusChange =
      PostLeaveStatusChange(RepositoryImpl(WorkplaceDataSourcesImpl()));

  GetTeamLeaveDetailById teamLeaveDetailById =
      GetTeamLeaveDetailById(RepositoryImpl(WorkplaceDataSourcesImpl()));

  List<LeaveTypeData> leaveTypeData = [];

  List<LeaveAppliedData> leaveAppliedData = [];
  String url = "";

  LeaveDetail? leaveDetail;

  List<LeaveAppliedData> teamLeaveData = [];

  int difference = -1;
  int difference2 = -1;

  LeaveBloc() : super(LeaveInitialState()) {
    on<FetchLeaveTypeEvent>((event, emit) async {
      //  emit(LeaveLoadingState());
      Either<Failure, GetLeaveTypeModel> response =
          await leaveTypeDetails.call('');
      response.fold((left) {
        if (left is UnauthorizedFailure) {
          appNavigator.tokenExpireUserLogout(event.mContext!);
        }
      }, (right) {
        leaveTypeData = right.data ?? [];
        emit(FetchedLeaveTypeState());
      });
    });

    on<GetLeaveDataEvent>((event, emit) async {
      emit(LeaveLoadingState());
      await getLeaveData(event.mContext!);
      // Either<Failure, GetLeaveDataModel> response =
      //     await leaveDataDetails.call('');
      // response.fold((left) {
      // if(left is UnauthorizedFailure)
      //         {
      //           appNavigator.tokenExpireUserLogout(event.mContext);
      //         }}, (right) {
      //   print(right.data!.length);
      //   leaveAppliedData = right.data ?? [];
      //   emit(FetchedLeaveAppliedDataState());
      // });
    }); //get Leave data onLoad

    on<GetLeaveDataOnRefresh>((event, emit) //get Leave data onRefresh
        async {
      emit(LeaveLoadingState());
      Either<Failure, GetLeaveDataModel> response =
          await leaveDataDetails.call(LeaveParams(url: null));
      response.fold((left) {
        if (left is UnauthorizedFailure) {
          appNavigator.tokenExpireUserLogout(event.mContext!);
        }
      }, (right) {
        leaveAppliedData = right.data ?? [];
        emit(FetchedLeaveAppliedDataOnRefreshState());
      });
    });

    on<SubmitLeaveRequestEvent>((event, emit) async {
      LoadingWidget2.startLoadingWidget(event.mContext!);
      Either<Failure, dynamic> response =
          await sendLeaveApplyDetails.call(LeaveApplyParams(
        leaveTypeID: event.leaveTypeID,
        duration: event.duration,
        reason: event.reason,
        startDate: event.startDate,
        endDate: event.endDate,
      ));
      response.fold((left) {
        LoadingWidget2.endLoadingWidget(event.mContext!);
        if (left is UnauthorizedFailure) {
          appNavigator.tokenExpireUserLogout(event.mContext!);
        }
      }, (right) {
        LoadingWidget2.endLoadingWidget(event.mContext!);
        emit(LeaveAppliedState());
      });
    });

    on<SubmitCancelLeaveRequestEvent>((event, emit) async {   
      emit(LeaveLoadingState());
      //LoadingWidget2.startLoadingWidget(event.mContext!);
      Either<Failure, dynamic> response =
          await leaveStatusDetails.call(LeaveStatusChangeParams(
        leaveId: event.id,
        status: event.status,
      ));
      response.fold((left) {
        // LoadingWidget2.endLoadingWidget(event.mContext!);
        if (left is UnauthorizedFailure) {
          appNavigator.tokenExpireUserLogout(event.mContext!);
        }
      }, (right) {
        //  LoadingWidget2.endLoadingWidget(event.mContext!);
        emit(LeaveCancelState());
      });
    });

    on<FetchLeaveDetailByIdEvent>((event, emit) async {
      emit(LeaveLoadingState());
      Either<Failure, GetLeaveDetailModel> response =
          await leaveDetailById.call(LeaveDetailParams(postId: event.postId));
      response.fold((left) {
        if (left is UnauthorizedFailure) {
          appNavigator.tokenExpireUserLogout(event.mContext!);
        }
      }, (right) {
        leaveDetail = right.data;
        calculateDifference(startDate: leaveDetail!.startDate ?? '');
        emit(FetchedLeaveDetailByIdState());
      });
    });

    on<LeaveRequestEvent>((event, emit) async {
      //update manager request
      emit(LeaveUpdateLoadingState());
      Either<Failure, PostLeaveApplyModel> response =
          await leaveStatusChange.call(
              LeaveStatusChangeParams(leaveId: event.id, status: event.status));
      response.fold((left) {
        if (left is UnauthorizedFailure) {
          appNavigator.tokenExpireUserLogout(event.mContext!);
        }
      }, (right) {
        emit(LeaveRequestState()); // refresh screen state
      });
    });

    on<FetchTeamLeaveDetailByIdEvent>((event, emit) async {
      emit(LeaveLoadingState());
      Either<Failure, GetLeaveDetailModel> response = await teamLeaveDetailById
          .call(TeamLeaveDetailParams(postId: event.postId));
      response.fold((left) {
        if (left is UnauthorizedFailure) {
          appNavigator.tokenExpireUserLogout(event.mContext!);
        }
      }, (right) {
        leaveDetail = right.data;
        String startDate = right.data?.startDate ?? "";

        calculateDifference(startDate: startDate);
        calculateDifference2(startDate: startDate);
        emit(FetchedTeamLeaveDetailByIdState());
      });
    });

    on<FetchTeamLeaveAppliedDataEvent>((event, emit) async {
      emit(LeaveLoadingState());
      await getTeamLeave.call('').fold((left) {
        if (left is UnauthorizedFailure) {
          appNavigator.tokenExpireUserLogout(event.mContext!);
        }
      }, (right) {
        teamLeaveData = right.data ?? [];
        emit(FetchedTeamLeaveAppliedDataState());
      });
    });
  }

  Future<void> getLeaveData(BuildContext context) {
    return leaveDataDetails
        .call(LeaveParams(url: (url.isEmpty) ? null : url))
        .fold((left) {
      if (left is UnauthorizedFailure) {
        appNavigator.tokenExpireUserLogout(context);
      }
    }, (right) {
      if (url.isNotEmpty) {
        leaveAppliedData.addAll(right.data ?? []);
      } else {
        leaveAppliedData = right.data ?? [];
      }
      url = right.pagination!.nextPageApiUrl!;
      //emit(FetchedTeamLeaveAppliedDataState());
    });
  }

  calculateDifference({required String startDate}) {  //include today
    try {
      if (startDate == 'Yesterday') {
        difference = -1;
      } else if (startDate == 'Tomorrow' || startDate == 'Today') {
        difference = 1;
      } else {
        DateTime date = DateFormat("yyyy-MM-dd")
            .parse(WorkplaceWidgets.parseDate(startDate));
        DateTime newDate = DateTime(DateTime.now().year, date.month, date.day);
        DateTime nowDate = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day);
        Duration diff = newDate.difference(nowDate);
        difference = diff.inDays;
      }
    } catch (e) {
      difference = -1;
    }
  }
  calculateDifference2({required String startDate}){ //exclude today
    try {
      if (startDate == 'Yesterday' || startDate == 'Today') {
        difference2 = -1;
      } else if (startDate == 'Tomorrow') {
        difference2 = 1;
      } else {
        DateTime date = DateFormat("yyyy-MM-dd")
            .parse(WorkplaceWidgets.parseDate(startDate));
        DateTime newDate =
        DateTime(DateTime.now().year, date.month, date.day);
        DateTime nowDate = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day);
        Duration diff = newDate.difference(nowDate);
        difference2 = diff.inDays;
      }
    } catch (e) {
      difference2 = -1;
    }
  }
}
