import 'package:workplace/imports.dart';
import '../../../../core/util/app_navigator/app_navigator.dart';

class FaqBloc extends Bloc<FaqEvent, FaqState> {
  GetFaqList getFaqList = GetFaqList(RepositoryImpl(WorkplaceDataSourcesImpl()));

  List<FAQ> faqList=[];

  FaqBloc() : super(FaqInitState()) {
    on<GetFaqListEvent>((event, emit) async {
      emit(FaqLoadingState());
      Either<Failure, FaqModal> response = await getFaqList.call('');
      response.fold((left)
      {
        if(left is UnauthorizedFailure)
        {
          appNavigator.tokenExpireUserLogout(event.mContext!);
        }
      },(right){
        faqList=right.faqList??[];
        emit(FetchFaqDataState());
      }
      );
    });
  }
}
