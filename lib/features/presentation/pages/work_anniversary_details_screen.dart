import '../../../imports.dart';

class WorkAnniversaryDetailScreen extends StatefulWidget {
  const WorkAnniversaryDetailScreen({Key? key}) : super(key: key);

  @override
  State<WorkAnniversaryDetailScreen> createState() =>
      _WorkAnniversaryDetailScreenState();
}

class _WorkAnniversaryDetailScreenState
    extends State<WorkAnniversaryDetailScreen> {
  WorkAnniversaryBloc bloc = WorkAnniversaryBloc();

  @override
  Widget build(BuildContext context) {
    return ContainerFirst(
      contextCurrentView: context,
      isSingleChildScrollViewNeed: false,
      isFixedDeviceHeight: true,
      isListScrollingNeed: true,
      appBarHeight: 50,
      appBar: DetailsScreenAppBar(
        title: AppString.workAnniversary,
      ),
      containChild: BlocBuilder<WorkAnniversaryBloc, WorkAnniversaryState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is WorkAnniversaryInitialState) {
            bloc.add(FetchWorkAnniversaryDataEvent(mContext: context));
          }
          if (state is WorkAnniversaryLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return (bloc.workAnniversaryList.isEmpty)
              ?  Center(child: Text(AppString.noWorkAnniversary, textAlign: TextAlign.center, style: appStyles.noDataTextStyle(),))
              : ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: bloc.workAnniversaryList.length,
                  itemBuilder: (context, index) {
                    String? description = bloc.workAnniversaryList[index].description ?? "1st Work Anniversary tomorrow";
                    return WorkplaceWidgets.userDetailListCard(
                        user: bloc.workAnniversaryList[index].user,
                        description: description);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.sp),
                      child: const Divider(),
                    );
                  },
                );
        },
      ),
    );
  }
}
