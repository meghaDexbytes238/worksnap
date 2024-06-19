import 'package:workplace/core/util/app_navigator/app_navigator.dart';
import 'package:workplace/imports.dart';

class BirthdayBloc extends Bloc<BirthdayEvent,BirthdayState>{
  GetBirthdayData birthdayDetails =
  GetBirthdayData(RepositoryImpl(WorkplaceDataSourcesImpl()));

  List<BirthdayData> birthdayList=[];

  BirthdayBloc():super(BirthdayInitialState())
  {

    on<FetchBirthdayDataEvent>((event,emit)
    async {
      emit(BirthdayLoadingState());
      Either<Failure, BirthdayDataModel> response = await birthdayDetails.call('');
      response.fold((left)
      {
        if(left is UnauthorizedFailure)
        {
          appNavigator.tokenExpireUserLogout(event.mContext);
        }
        //emit(FetchedBirthdayDataState());
      },(right){
        birthdayList=right.data??[];
        emit(FetchedBirthdayDataState());
      }
      );

    });



  }

}