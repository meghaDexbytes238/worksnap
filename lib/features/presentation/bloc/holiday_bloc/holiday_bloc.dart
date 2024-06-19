import '../../../../core/util/app_navigator/app_navigator.dart';
import '../../../../imports.dart';

class HolidayBloc extends Bloc<HolidayEvent,HolidayState>{
  GetHolidayData holidayDetails =
  GetHolidayData(RepositoryImpl(WorkplaceDataSourcesImpl()));

  List<HolidayData> holidayList=[];

  HolidayBloc():super(HolidayInitialState())
  {

    on<FetchHolidayDataEvent>((event,emit)
    async {
      emit(HolidayLoadingState());
      await fetchHolidayData(event.mContext);
      // Either<Failure, HolidayDataModel> response = await holidayDetails.call('');
      // response.fold((left)
      // {
      //   if(left is UnauthorizedFailure)
      //   {
      //     appNavigator.tokenExpireUserLogout(event.mContext);
      //   }
      //   //emit(HolidayDataState());
      // },(right){
      //   holidayList=right.data??[];
      //   emit(HolidayDataState());
      // }
      // );
    });

  }
 Future<void> fetchHolidayData(BuildContext context)
 async {
   await holidayDetails.call('').fold((left)
   {
     if(left is UnauthorizedFailure)
     {
       appNavigator.tokenExpireUserLogout(context);
     }
     //emit(HolidayDataState());
   },(right){
     holidayList=right.data??[];
     emit(HolidayDataState());
   }
   );
 }
}