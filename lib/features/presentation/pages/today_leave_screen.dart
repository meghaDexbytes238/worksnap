import '../../../imports.dart';

class TodayLeaveScreen extends StatefulWidget {
  final List<TodayLeaves>? leaveToday;

  const TodayLeaveScreen({Key? key,this.leaveToday}) : super(key: key);

  @override
  State<TodayLeaveScreen> createState() => _TodayLeaveScreenState();
}

class _TodayLeaveScreenState extends State<TodayLeaveScreen> {
  @override
  Widget build(BuildContext context) {
    return (widget.leaveToday!.isEmpty || widget.leaveToday==null) ?Container(
      padding: EdgeInsets.symmetric(vertical: 30.sp),
      child:  Text(AppString.noLeaveToday,
          textAlign: TextAlign.center,
        style: appStyles.noDataTextStyle(),
      ),
    ):
    ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding:  EdgeInsets.symmetric(vertical: 12.sp),
      scrollDirection: Axis.vertical,
      itemCount: widget.leaveToday!.length,
      itemBuilder: (context, index) {
        return WorkplaceWidgets.userDetailListCard(
            user: widget.leaveToday![index].user,
            description: widget.leaveToday![index].messages ?? ""
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
          child: Divider(color: Colors.grey.shade300,),
        );
      },
    );
  }
}
