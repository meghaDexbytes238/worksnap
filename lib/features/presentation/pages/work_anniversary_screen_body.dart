import '../../../imports.dart';

class WorkAnniversaryScreenBody extends StatefulWidget {
  final List<WorkAnniversary>? workAnniversary;

  const WorkAnniversaryScreenBody({Key? key, required this.workAnniversary})
      : super(key: key);

  @override
  State<WorkAnniversaryScreenBody> createState() =>
      _WorkAnniversaryScreenBodyState();
}

class _WorkAnniversaryScreenBodyState extends State<WorkAnniversaryScreenBody> {
  @override
  Widget build(BuildContext context) {
    return (widget.workAnniversary == null || widget.workAnniversary!.isEmpty)
        ? Container(
      padding:  EdgeInsets.symmetric(vertical: 30.sp),
      child:  Text(AppString.noUpComingWA,textAlign: TextAlign.center,
        style: appStyles.noDataTextStyle(),
      ),
    )
        : ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding:  EdgeInsets.symmetric(vertical: 12.sp),
            scrollDirection: Axis.vertical,
            itemCount: widget.workAnniversary!.length,
            itemBuilder: (context, index) {
              String? description = widget.workAnniversary?[index].description ?? "1st Work Anniversary tomorrow";
              return WorkplaceWidgets.userDetailListCard(
                  user: widget.workAnniversary![index].user,
                  description: description);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Padding(
                padding:  EdgeInsets.symmetric(horizontal: 15.sp),
                child:  Divider(color: Colors.grey.shade300,),
              );
            },
          );
  }
}
