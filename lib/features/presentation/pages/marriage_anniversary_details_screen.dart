import '../../../imports.dart';

class MarriageAnniversaryDetailScreen extends StatefulWidget {
  const MarriageAnniversaryDetailScreen({Key? key}) : super(key: key);

  @override
  State<MarriageAnniversaryDetailScreen> createState() =>
      _MarriageAnniversaryDetailScreenState();
}

class _MarriageAnniversaryDetailScreenState
    extends State<MarriageAnniversaryDetailScreen> {
  MarriageAnniversaryBloc bloc = MarriageAnniversaryBloc();

  @override
  Widget build(BuildContext context) {
    return ContainerFirst(
      contextCurrentView: context,
      isSingleChildScrollViewNeed: false,
      isFixedDeviceHeight: true,
      isListScrollingNeed: true,
      appBarHeight: 50,
      appBar: DetailsScreenAppBar(
        title: AppString.marriageAnniversaries,
      ),
      containChild:
      BlocBuilder<MarriageAnniversaryBloc, MarriageAnniversaryState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is MarriageAnniversaryInitialState) {
            bloc.add(FetchMarriageAnniversaryDataEvent(mContext: context));
          }
          if (state is MarriageAnniversaryLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return (bloc.marriageAnniversaryList.isEmpty)
              ?  Center(child: Text(AppString.noMarriageAnniversary, style: TextStyle(fontSize: 18.sp,color: AppColors.appBlack),))
              : ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: bloc.marriageAnniversaryList.length,
                  itemBuilder: (context, index) {
                    String? description =
                        bloc.marriageAnniversaryList[index].description ??
                            "marriage Anniversary tomorrow";
                    return WorkplaceWidgets.userDetailListCard(
                        user: bloc.marriageAnniversaryList[index].user,
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
