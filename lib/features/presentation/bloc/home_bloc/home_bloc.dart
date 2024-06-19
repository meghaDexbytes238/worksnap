import '../../../../core/util/app_navigator/app_navigator.dart';
import '../../../../imports.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<Birthday>? birthday;
  List<WorkAnniversary>? workAnniversary;
  List<MarriageAnniversary>? marriageAnniversary;
  List<Announcements>? announcements;
  List<Holidays> holidays=[];
  List<Events> events=[];
  List<TodayLeaves> todayLeaves=[];
  List<TodayWfh> todayWfh=[];

  GetHomeData homeDetails =
      GetHomeData(RepositoryImpl(WorkplaceDataSourcesImpl()));

  HomeBloc() : super(HomeInitialState()) {
    on<FetchHomeData>((event, emit) async {
      emit(HomeLoadingState());
      await fetchData(event.mContext);
    });
  }

  Future<void> fetchData(BuildContext mContext) {
    return homeDetails.call('').fold((left) {
      if(left is UnauthorizedFailure)
      {
        appNavigator.tokenExpireUserLogout(mContext);
      }

     else {
        emit(HomeErrorState());
      }

    }, (right) {
      birthday = right.data!.birthday;
      workAnniversary = right.data!.workAnniversary;
      marriageAnniversary = right.data!.marriageAnniversary;
      announcements = right.data!.announcements;
      events=right.data!.events??[];
      holidays=right.data!.holidays ?? [];
      todayLeaves=right.data!.todayLeaves ?? [];
      todayWfh=right.data!.todayWfh ?? [];
      emit(FetchedHomeDataState());
    });
  }
}
