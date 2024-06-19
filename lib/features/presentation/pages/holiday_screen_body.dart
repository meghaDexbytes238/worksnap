import 'package:intl/intl.dart';
import '../../../imports.dart';

class HolidayScreenBody extends StatefulWidget {
  List<Holidays> holidays;

  HolidayScreenBody({Key? key, required this.holidays}) : super(key: key);

  @override
  State<HolidayScreenBody> createState() => _HolidayScreenBodyState();
}

class _HolidayScreenBodyState extends State<HolidayScreenBody> {
  Widget holidayList() {
    return (widget.holidays.isEmpty)
        ? Container(
            padding:  EdgeInsets.symmetric(vertical: 30.sp),
            child:  Text(AppString.noHolidays,
                textAlign: TextAlign.center,
              style: appStyles.noDataTextStyle(),
            ),
          )
        : ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
             padding:  EdgeInsets.symmetric(vertical: 12.sp),
            scrollDirection: Axis.vertical,
            itemCount: widget.holidays.length,
            itemBuilder: (context, index) {
              String date = widget.holidays[index].startDate ?? "";

              String? startDate =
                  DateFormat('dd\nMMM').format(DateTime.parse(date));

              return WorkplaceWidgets.eventListCard(
                startDate: startDate,
                title: widget.holidays[index].title ?? "holiday",
                description: widget.holidays[index].description ?? "Monday",
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

  @override
  Widget build(BuildContext context) {
    return holidayList();
  }
}
