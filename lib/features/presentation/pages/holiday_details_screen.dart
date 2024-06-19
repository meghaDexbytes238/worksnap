import 'package:intl/intl.dart';
import '../../../imports.dart';

class HolidayDetailScreen extends StatefulWidget {
  const HolidayDetailScreen({Key? key}) : super(key: key);

  @override
  State<HolidayDetailScreen> createState() => _HolidayDetailScreenState();
}

class _HolidayDetailScreenState extends State<HolidayDetailScreen> {
  HolidayBloc bloc = HolidayBloc();

  @override
  Widget build(BuildContext context) {
    return ContainerFirst(
      contextCurrentView: context,
      isSingleChildScrollViewNeed: false,
      isFixedDeviceHeight: true,
      isListScrollingNeed: true,
      appBarHeight: 50,
      appBar: DetailsScreenAppBar(
        title: AppString.holidays,
      ),
      containChild: BlocBuilder<HolidayBloc, HolidayState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is HolidayInitialState) {
            bloc.add(FetchHolidayDataEvent(mContext: context));
          }
          if (state is HolidayLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.appBlueA,),
            );
          }
          return (bloc.holidayList.isEmpty)
              ?  Center(
                  child: Text(AppString.noHolidays,
                    style: appStyles.noDataTextStyle(),
                  ),
                )
              : RefreshIndicator(
             color: AppColors.appBlueA,
            onRefresh: ()
            async {
              bloc.add(FetchHolidayDataEvent(mContext: context));
              await bloc.fetchHolidayData(context);
            },
                child: ListView.separated(
                   // shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: bloc.holidayList.length,
                    itemBuilder: (context, index) {
                      String date = bloc.holidayList[index].startDate ?? "";
                      String? startDate =
                          DateFormat('dd\nMMM').format(DateTime.parse(date));
                      return WorkplaceWidgets.eventListCard(
                        startDate: startDate,
                        title: bloc.holidayList[index].title ?? "holiday",
                        description:
                            bloc.holidayList[index].description ?? "Monday",
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.sp),
                        child: const Divider(),
                      );
                    },
                  ),
              );
        },
      ),
    );
  }
}
