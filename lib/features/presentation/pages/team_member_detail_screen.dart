import 'package:workplace/imports.dart';

class TeamMemberDetailScreen extends StatefulWidget {
  final String? imageUrl;
  final String? name;

  const TeamMemberDetailScreen({Key? key, this.imageUrl, this.name})
      : super(key: key);
  @override
  _TeamMemberDetailScreenState createState() => _TeamMemberDetailScreenState();
}

class _TeamMemberDetailScreenState extends State<TeamMemberDetailScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SliverScrollViewWidget(
        title: widget.name ?? "Kimberly Spalino",
        imageUrl: widget.imageUrl,
        slivers: Container(
          color: Colors.grey.shade100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.sp, right: 35.sp),
                    child: SvgPicture.asset(
                      WorkplaceIcons.cardBackgroundImages,
                      width: MediaQuery.of(context).size.width - 45.sp,
                    ),
                  ),
                  MemberHeader(
                    name: widget.name ?? '',
                    imageUrl: widget.imageUrl ?? '',
                  ),
                ],
              ),
              const MemberPostList()
            ],
          ),
        ));
  }
}
