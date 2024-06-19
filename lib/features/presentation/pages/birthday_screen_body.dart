import '../../../imports.dart';

class BirthdayScreenBody extends StatefulWidget {
  final List<Birthday>? birthday;

  const BirthdayScreenBody({Key? key, required this.birthday})
      : super(key: key);

  @override
  State<BirthdayScreenBody> createState() => _BirthdayScreenBodyState();
}

class _BirthdayScreenBodyState extends State<BirthdayScreenBody> {
  @override
  Widget build(BuildContext context) {
    return (widget.birthday == null || widget.birthday!.isEmpty)
        ? Container(
      padding:  EdgeInsets.symmetric(vertical: 30.sp),
      child:  Text(AppString.noUpcomingBirthdays,textAlign: TextAlign.center,
        style: appStyles.noDataTextStyle(),
      ),
    )
        : ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 12),
            scrollDirection: Axis.vertical,
            itemCount: widget.birthday!.length,
            itemBuilder: (context, index) {
              String? description =
                  widget.birthday?[index].description ?? "Birthday Today";
              return WorkplaceWidgets.userDetailListCard(
                  user: widget.birthday![index].user, description: description);
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
