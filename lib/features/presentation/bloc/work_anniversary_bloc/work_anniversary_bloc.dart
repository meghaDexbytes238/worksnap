import '../../../../core/util/app_navigator/app_navigator.dart';
import '../../../../imports.dart';

class WorkAnniversaryBloc
    extends Bloc<WorkAnniversaryEvent, WorkAnniversaryState> {
  GetWorkAnniversaryData workAnniversaryDetails =
      GetWorkAnniversaryData(RepositoryImpl(WorkplaceDataSourcesImpl()));

  List<WorkAnniversayData> workAnniversaryList = [];

  WorkAnniversaryBloc() : super(WorkAnniversaryInitialState()) {
    on<FetchWorkAnniversaryDataEvent>((event, emit) async {
      emit(WorkAnniversaryLoadingState());
      Either<Failure, WorkAnniversaryDataModel> response =
          await workAnniversaryDetails.call('');
      response.fold((left) {
        if (left is UnauthorizedFailure) {
          appNavigator.tokenExpireUserLogout(event.mContext);
        }
        //emit(FetchedWorkAnniversaryDataState());
      }, (right) {
        workAnniversaryList = right.data ?? [];
        emit(FetchedWorkAnniversaryDataState());
      });
    });
  }
}
