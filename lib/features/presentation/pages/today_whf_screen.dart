import '../../../imports.dart';

class TodayWHFScreen extends StatefulWidget {
  final List<TodayWfh>? todayWfh;

  const TodayWHFScreen({Key? key, this.todayWfh}) : super(key: key);

  @override
  State<TodayWHFScreen> createState() => _TodayWHFScreenState();
}

class _TodayWHFScreenState extends State<TodayWHFScreen> {
  @override
  Widget build(BuildContext context) {
    return (widget.todayWfh!.isEmpty || widget.todayWfh == null)
        ? Container(
            padding:  EdgeInsets.symmetric(vertical: 30.sp),
            child:  Text(AppString.noWhf,
                textAlign: TextAlign.center,
              style: appStyles.noDataTextStyle(),
            ),
          )
        : ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding:  EdgeInsets.symmetric(vertical: 12.sp),
            scrollDirection: Axis.vertical,
            itemCount: widget.todayWfh!.length,
            itemBuilder: (context, index) {
              return WorkplaceWidgets.userDetailListCard(
                  user: widget.todayWfh![index].user,
                  description: widget.todayWfh![index].messages??""
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.sp),
                child: Divider(
                  color: Colors.grey.shade300,
                ),
              );
            },
          );
  }
}
