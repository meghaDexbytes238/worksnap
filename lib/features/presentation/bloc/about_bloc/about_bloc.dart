import 'package:workplace/imports.dart';
import '../../../../core/util/app_navigator/app_navigator.dart';

class AboutBloc extends Bloc<AboutEvent,AboutState>
{
  GetAboutUs aboutUsDetail=GetAboutUs(RepositoryImpl(WorkplaceDataSourcesImpl()));

  List<AboutData> aboutUsList=[];

  AboutBloc():super(AboutInitialState())
  {
    on<FetchAboutDataEvent>((event, emit) async {

      emit(AboutLoadingState());
      Either<Failure, AboutUsModal> response= await aboutUsDetail.call('');
      response.fold((left) {
        if(left is UnauthorizedFailure)
        {
          appNavigator.tokenExpireUserLogout(event.mContext);
        }
      }, (right) {
        aboutUsList=right.aboutData??[];
        emit(FetchedAboutDataState ());
      }

      );
    });

  }
}
