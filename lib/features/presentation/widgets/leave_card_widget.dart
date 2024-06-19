import 'package:intl/intl.dart';
import 'package:workplace/imports.dart';

class LeavesCardWidget extends StatefulWidget {
  final String? title;
  final String? leaveType;
  //final String? date;
  final String? message;
  final String? startDate;
  final String? endDate;
  final String? managerName;
  final String? status;
  final String? managerImageUrl;
  final String? description;
  final Color? statusBoxColor;
  final Color? iconColor;
  final Widget? icon;
  final EdgeInsetsGeometry? padding;
  final cardClickCallback;
  final cancleClickCallBack;
  final editClickCallBack;
  LeavesCardWidget({
    Key? key,
    this.title,
    //this.date,
    this.message,
    this.startDate,
    this.endDate,
    this.leaveType,
    this.status,
    this.iconColor,
    this.description,
    this.managerName,
    this.cardClickCallback,
    this.cancleClickCallBack,
    this.editClickCallBack,
    this.icon,
    this.managerImageUrl,
    this.padding,
    this.statusBoxColor,
  }) : super(key: key);

  @override
  State<LeavesCardWidget> createState() => _LeavesCardWidgetState();
}

class _LeavesCardWidgetState extends State<LeavesCardWidget> {
  int difference = -1;

  @override
  void initState() {
    try{
      if(widget.startDate == 'Yesterday')
        {
          difference = -1;
        }
      else if(widget.startDate == 'Tomorrow' || widget.startDate == 'Today' )
        {
          // DateTime date = DateTime.now();
          // DateTime newDate = DateTime(date.year,date.month, date.day + 1 );
          // DateTime nowDate = DateTime(date.year,date.month, date.day );
          // Duration diff = newDate.difference(nowDate);
          // difference = diff.inDays;
          difference = 1;
        }
      else
        {
          DateTime date = DateFormat("yyyy-MM-dd").parse(WorkplaceWidgets.parseDate('${widget.startDate}'));
          DateTime newDate = DateTime(DateTime.now().year,date.month,date.day);
          DateTime nowDate = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
            Duration diff = newDate.difference(nowDate);
            difference = diff.inDays;
        }

    } catch(e){
      difference = -1;
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget belowButton() => Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            WorkplaceWidgets.commonButton(onClickCallBack: ()
                {
                  widget.cancleClickCallBack.call();
                },
                title: "Cancel",
               bgColor: Colors.grey.shade100,
              fontColor: Colors.black,
            ),
          ],
        );

    Widget statusContainer(String status) {
      return Container(
        decoration: BoxDecoration(
            color: status == "Pending"
                ? Color(0xFFEA910E).withOpacity(0.10)
                : status == "Approved"
                    ? Colors.green.withOpacity(0.10)
                    : Colors.red.withOpacity(0.10),
            borderRadius: BorderRadius.circular(6)),
        padding: const EdgeInsets.all(4).copyWith(left: 5, right: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WorkplaceIcons.iconImage(
              iconSize: const Size(15, 15),
              imageColor: status == "Pending"
                  ? Color(0xFFEA910E)
                  : status == "Approved"
                      ? Colors.green
                      : Colors.red,
              imageUrl: WorkplaceIcons.clockIcon,
            ),
            const SizedBox(
              width: 3,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.5),
              child: Text(
                status,
                style: appStyles.leaveHistoryTextStyle(
                  fontSize: 11.5,
                  texColor: status == "Pending"
                      ? Color(0xFFEA910E)
                      : status == "Approved"
                          ? Colors.green
                          : Colors.red,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return InkWell(
      onTap: () {
        widget.cardClickCallback.call();
      },
      child: Container(
        margin: const EdgeInsets.only(left: 14, right: 14, bottom: 10),
        padding: widget.padding ??
            const EdgeInsets.all(16).copyWith(top: 10.5, bottom: 10.5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 3,
                  offset: const Offset(0, 1),
                  blurRadius: 3)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.leaveType ?? "Going for a trip",
                  style: appStyles.leaveHistoryTextStyle(
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 2,
                ),
                statusContainer(widget.status ?? "")
              ],
            ),
            const SizedBox(height: 4),
            // Text(
            //   leaveType ?? "Casual Leave",
            //   style: appStyles.leaveHistoryTextStyle(
            //       fontSize: 11.5, texColor: Colors.grey),
            // ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: AppColors.buttonBgColor4, shape: BoxShape.circle),
                  padding: const EdgeInsets.all(5),
                  child: WorkplaceIcons.iconImage(
                    iconSize: const Size(13, 13),
                    imageColor: Colors.white,

                    imageUrl: WorkplaceIcons
                        .calendarImage, // WorkplaceIcons.briefcaseIcon,

                  ),
                ),
                const SizedBox(width: 10),
                // Text(
                //   "Leave from :",
                //   style: appStyles.leaveHistoryTextStyle(
                //       fontSize: 12, texColor: Colors.grey),
                // ),
                const SizedBox(width: 3),
                Text(
                  '${widget.message}',
                  // date ?? "25th Feb - 28th Feb",
                  style: appStyles.leaveHistoryTextStyle(
                      fontSize: 12.5,
                      texColor: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                // Text('$startDate',
                //  // date ?? "25th Feb - 28th Feb",
                //   style: appStyles.leaveHistoryTextStyle(
                //       fontSize: 12.5,
                //       texColor: Colors.black,
                //       fontWeight: FontWeight.w500),
                // ),
                // Text( (endDate==null || endDate!.trim().isEmpty)?" ":' - $endDate',
                //  // date ?? "25th Feb - 28th Feb",
                //   style: appStyles.leaveHistoryTextStyle(
                //       fontSize: 12.5,
                //       texColor: Colors.black,
                //       fontWeight: FontWeight.w500),
                // ),
              ],
            ),

            const SizedBox(height: 10),
            Text(
              widget.description ?? "", //parse(description).body!.text.trim() ??"",
              textAlign: TextAlign.start,
              maxLines: 4,
              style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  color: Colors.grey.shade500,
                  height: 1.5),
            ),
            const SizedBox(height: 5),
             (widget.status!.toLowerCase() == "pending" || widget.status!.toLowerCase() == "approved"|| widget.status!.toLowerCase() == "on-hold") ? ( difference > 0 )  ? belowButton(): Container() : Container() ,
             const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
