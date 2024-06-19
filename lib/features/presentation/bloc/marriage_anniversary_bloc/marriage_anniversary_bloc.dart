import '../../../../core/util/app_navigator/app_navigator.dart';
import '../../../../imports.dart';

class MarriageAnniversaryBloc extends Bloc<MarriageAnniversaryEvent,MarriageAnniversaryState>
{
  GetMarriageAnniversaryData  marriageAnniversaryDetails =
  GetMarriageAnniversaryData(RepositoryImpl(WorkplaceDataSourcesImpl()));

  List<MarriageAnniversaryData> marriageAnniversaryList=[];

  MarriageAnniversaryBloc():super(MarriageAnniversaryInitialState()){

    on<FetchMarriageAnniversaryDataEvent>((event,emit)
    async {
      emit(MarriageAnniversaryLoadingState());
      Either<Failure,MarriageAnniversaryDataModel> response= await marriageAnniversaryDetails.call('');
      response.fold(
              (left){
                if(left is UnauthorizedFailure)
                {
                  appNavigator.tokenExpireUserLogout(event.mContext);
                }
                //emit(FetchedMarriageAnniversaryDataState());
              }
          , (right) {
        marriageAnniversaryList=right.data??[];
        emit(FetchedMarriageAnniversaryDataState());
      });

    });

  }

}