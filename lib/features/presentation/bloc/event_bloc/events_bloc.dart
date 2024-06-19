import 'package:workplace/core/util/app_navigator/app_navigator.dart';
import '../../../../imports.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  GetEventData eventDetails =
      GetEventData(RepositoryImpl(WorkplaceDataSourcesImpl()));

  List<EventData> eventList = [];

  EventsBloc() : super(EventsInitialState()) {
    on<FetchEventsData>((event, emit) async {
      emit(EventsLoadingState());
      await fetchEventData(event.mContext);
      // Either<Failure,  EventDataModel> response = await eventDetails.call('');
      // response.fold((left)
      // {
      //   if(left is UnauthorizedFailure)
      //   {
      //     appNavigator.tokenExpireUserLogout(event.mContext);
      //   }
      //  // emit(EventsDataState());
      // },(right){
      //   eventList=right.data??[];
      //   emit(EventsDataState());
      // }
      // );
    });
  }

  Future<void> fetchEventData(BuildContext context) {
    return eventDetails.call('').fold((left) {
      if (left is UnauthorizedFailure) {
        appNavigator.tokenExpireUserLogout(context);
      }
      // emit(EventsDataState());
    }, (right) {
      eventList = right.data ?? [];
      emit(EventsDataState());
    });
  }
}
