import 'package:workplace/imports.dart';
import '../../../../core/util/app_navigator/app_navigator.dart';
part 'team_member_event.dart';
part 'team_member_state.dart';

class TeamMemberBloc extends Bloc<TeamMemberEvent, TeamMemberState> {
  List<User> data=[];
  GetTeamDetails getTeamDetails =
      GetTeamDetails(RepositoryImpl(WorkplaceDataSourcesImpl()));

  TeamMemberBloc() : super(TeamMemberInitial()) {
    on<TeamMemberEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FetchTeamList>((event, emit) async {
      // TODO: implement event handler
      // emit(TeamMemberDataFetched());
      emit(TeamMemberLoadingState());
     await fetchTeamData(event.mContext);
     });
  }

  Future<void> fetchTeamData(BuildContext mContext){
   return getTeamDetails.call('').fold((left) {
     if(left is UnauthorizedFailure)
     {
       appNavigator.tokenExpireUserLogout(mContext);
     }
      //emit(TeamMemberDataFetched());
    }, (right) {
      data = right.data ??[];

      emit(TeamMemberDataFetched());
    });
  }
}
