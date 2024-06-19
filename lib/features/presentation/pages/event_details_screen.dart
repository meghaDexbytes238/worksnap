import 'package:intl/intl.dart';
import '../../../imports.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({Key? key}) : super(key: key);

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  EventsBloc bloc = EventsBloc();

  @override
  Widget build(BuildContext context) {
    return ContainerFirst(
      contextCurrentView: context,
      isSingleChildScrollViewNeed: false,
      isFixedDeviceHeight: true,
      isListScrollingNeed: true,
      appBarHeight: 50,
      appBar: DetailsScreenAppBar(
        title: AppString.events,
      ),
      containChild: BlocBuilder<EventsBloc, EventsState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is EventsInitialState) {
            bloc.add(FetchEventsData(mContext: context));
          }
          if (state is EventsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.appBlueA,),
            );
          }
          return (bloc.eventList.isEmpty)
              ? Center(
                  child: Text(AppString.noEvents,
                    style: appStyles.noDataTextStyle(),
                  ),
                )
              : RefreshIndicator(
                  color:  AppColors.appBlueA,
                  onRefresh: () async {
                    bloc.add(FetchEventsData(mContext: context));
                    await bloc.fetchEventData(context);
                  },
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: bloc.eventList.length,
                    itemBuilder: (context, index) {
                      String date = bloc.eventList[index].startDate ?? "";
                      String? startDate =
                          DateFormat('dd\nMMM').format(DateTime.parse(date));
                      return WorkplaceWidgets.eventListCard(
                        startDate: startDate,
                        title: bloc.eventList[index].title ?? "event",
                        description:
                            bloc.eventList[index].description ?? "Monday",
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
