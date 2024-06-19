import 'package:intl/intl.dart';
import '../../../imports.dart';

class EventScreenBody extends StatefulWidget {
  List<Events> events;

  EventScreenBody({Key? key, required this.events}) : super(key: key);

  @override
  State<EventScreenBody> createState() => _EventScreenBodyState();
}

class _EventScreenBodyState extends State<EventScreenBody> {
  @override
  Widget build(BuildContext context) {
    return (widget.events.isEmpty)
        ? Container(
      padding:  EdgeInsets.symmetric(vertical: 30.sp),
          child:  Text(AppString.noEvents,
            textAlign: TextAlign.center,
            style: appStyles.noDataTextStyle(),
          ),
        )
        : ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 12),
            scrollDirection: Axis.vertical,
            itemCount: widget.events.length,
            itemBuilder: (context, index) {
              String date = widget.events[index].startDate ?? "";
              String? startDate =
                  DateFormat('dd\nMMM').format(DateTime.parse(date));
              return WorkplaceWidgets.eventListCard(
                startDate: startDate,
                title: widget.events[index].title ?? "event",
                description: widget.events[index].description ?? "Monday",
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.sp),
                child:  Divider(color: Colors.grey.shade300,),
              );
            },
          );
  }
}
