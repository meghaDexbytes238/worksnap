import '../../../imports.dart';

class BirthdayDetailScreen extends StatefulWidget {
  const BirthdayDetailScreen({Key? key}) : super(key: key);

  @override
  State<BirthdayDetailScreen> createState() => _BirthdayDetailScreenState();
}

class _BirthdayDetailScreenState extends State<BirthdayDetailScreen> {
  @override
  void initState() {
    super.initState();
  }
  BirthdayBloc bloc = BirthdayBloc();
  @override
  Widget build(BuildContext context) {
    return ContainerFirst(
      contextCurrentView: context,
      isSingleChildScrollViewNeed: false,
      isFixedDeviceHeight: true,
      isListScrollingNeed: true,
      appBarHeight: 50.sp,
      appBar: DetailsScreenAppBar(
        title: AppString.birthdays,
      ),

      containChild: BlocBuilder<BirthdayBloc, BirthdayState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is BirthdayInitialState) {
            bloc.add(FetchBirthdayDataEvent(mContext: context));
          }
          if (state is BirthdayLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return (bloc.birthdayList.isEmpty)
              ?  Center(child: Text(AppString.noBirthdays,
              style: appStyles.noDataTextStyle()
            ,))
              : ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: bloc.birthdayList.length,
                  itemBuilder: (context, index) {
                    String? description = bloc.birthdayList[index].description ?? "Birthday Today";
                    return WorkplaceWidgets.userDetailListCard(
                        user: bloc.birthdayList[index].user,
                        description: description);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Padding(
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

