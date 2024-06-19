import '../../../imports.dart';

class MarriageAnniversaryScreenBody extends StatefulWidget {
  final List<MarriageAnniversary>? marriageAnniversary;

  const MarriageAnniversaryScreenBody(
      {Key? key, required this.marriageAnniversary})
      : super(key: key);

  @override
  State<MarriageAnniversaryScreenBody> createState() =>
      _MarriageAnniversaryScreenBodyState();
}

class _MarriageAnniversaryScreenBodyState
    extends State<MarriageAnniversaryScreenBody> {
  @override
  Widget build(BuildContext context) {
    return (widget.marriageAnniversary == null ||
            widget.marriageAnniversary!.isEmpty)
        ?
    Container(
      padding:  EdgeInsets.symmetric(vertical: 30.sp),
      child:  Text(AppString.noUpcomingMA,textAlign: TextAlign.center,
        style: appStyles.noDataTextStyle(),
      ),
    )
        : ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding:  EdgeInsets.symmetric(vertical: 12.sp),
            scrollDirection: Axis.vertical,
            itemCount: widget.marriageAnniversary!.length,
            itemBuilder: (context, index) {
              String? description = widget.marriageAnniversary?[index].description ?? "marriage Anniversary tomorrow";
              return WorkplaceWidgets.userDetailListCard(
                  user: widget.marriageAnniversary![index].user,
                  description: description);
            },
            separatorBuilder: (BuildContext context, int index) {
              return  Padding(
                padding:  EdgeInsets.symmetric(horizontal: 15.sp),
                child: Divider(color: Colors.grey.shade300,),
              );
            },
          );
  }
}
