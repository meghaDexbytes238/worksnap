import 'package:workplace/imports.dart';

class LeaveHistoryCardWidget extends StatelessWidget {
  final String? title;
  final String? leaveType;
  final String? days;
  final Widget? icon;
  final onTapCallBack;
  final EdgeInsetsGeometry? padding;

  const LeaveHistoryCardWidget({
    Key? key,
    this.title,
    this.days,
    this.leaveType,
    this.onTapCallBack,
    this.icon,
    this.padding,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          this.onTapCallBack?.call();
        },
        child: Container(
          margin: const EdgeInsets.only(left: 14, right: 14, bottom: 0),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(width: 0.5, color: Colors.grey.shade200))),
          padding: padding ??
              const EdgeInsets.all(16).copyWith(top: 10.5, bottom: 10.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? "June 1, 2018 - June 4, 2018",
                    style: appStyles.leaveHistoryTextStyle(
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(
                        leaveType ?? "Annual Leave 3 days",
                        style: appStyles.leaveHistoryTextStyle(
                            fontSize: 11.5, texColor: Colors.grey),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        days ?? "3 days",
                        style: appStyles.leaveHistoryTextStyle(
                            fontSize: 11.5, texColor: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              icon ??
                  WorkplaceIcons.iconImage(
                    iconSize: const Size(40, 40),
                    imageColor: Colors.green.shade600,
                    imageUrl: WorkplaceIcons.approveIcon,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
