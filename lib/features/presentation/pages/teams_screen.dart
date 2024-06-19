import 'package:workplace/imports.dart';

class TeamsScreen extends StatefulWidget {
  final String mobileNumber;

  const TeamsScreen({Key? key, this.mobileNumber = "9171579456"})
      : super(key: key);
  @override
  _TeamsScreenState createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  TeamMemberBloc bloc = TeamMemberBloc();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    AppDimens appDimens = AppDimens();
    appDimens.appDimensFind(context: context);


    Widget noDataView(){
      return Padding(
        padding: EdgeInsets.only(top: appDimens.heightFullScreen()/2.5),
        child: Center(child: Text(AppString.noDataFound,style: appStyles.noDataTextStyle(),)),
      );
    }
     return ContainerFirst(
        contextCurrentView: context,
        isSingleChildScrollViewNeed: false,
        isFixedDeviceHeight: true,
        isListScrollingNeed: true,
        appBarHeight: 50.sp,
        appBar: DetailsScreenAppBar(
          title: AppString.ourTeam,
          isHideIcon: true,
        ),
        containChild: BlocBuilder<TeamMemberBloc, TeamMemberState>(
          bloc: bloc,
          builder: (context, state) {
            print(state);
            if (state is TeamMemberInitial) {
              bloc.add(FetchTeamList(mContext: context));
               bloc.fetchTeamData(context);
             // return RefreshIndicator(
             //    color: AppColors.appBlueA,
             //    onRefresh: () async {
             //      bloc.add(FetchTeamList(mContext: context));
             //      await bloc.fetchTeamData(context);
             //    },
             //    child: ListView(
             //      padding: EdgeInsets.zero,
             //      shrinkWrap: true,
             //      children: [
             //        SizedBox(
             //          height: 10.sp,
             //        ),
             //        bloc.data.isNotEmpty ?
             //        TeamGridWidget(
             //          data: bloc.data,
             //        ):noDataView(),
             //        SizedBox(
             //          height: 65.sp,
             //        )
             //      ],
             //    ),
             //  );
            }
            if (state is TeamMemberLoadingState) {
              // bloc.add(FetchTeamList(mContext: context));
              //    bloc.fetchTeamData(context);
             return LoadingWidget2.loadViewWidget();
            }
            if (state is TeamMemberDataFetched) {
              // return LoadingWidget2.loadViewWidget();
            }
            return RefreshIndicator(

              color: AppColors.appBlueA,
              onRefresh: () async {
                bloc.add(FetchTeamList(mContext: context));
                await bloc.fetchTeamData(context);
              },
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                   SizedBox(
                    height: 10.sp,
                  ),
                  bloc.data.isNotEmpty ?
                  TeamGridWidget(
                    data: bloc.data,
                  ):noDataView(),
                   SizedBox(
                    height: 65.sp,
                  )
                ],
              ),
            );
          },
        )
    );
  }
}
