import 'package:html/parser.dart';
import '../../../imports.dart';

class AnnouncementScreenBody extends StatefulWidget {
  final List<Announcements>? announcements;

  const AnnouncementScreenBody({Key? key, required this.announcements})
      : super(key: key);

  @override
  State<AnnouncementScreenBody> createState() => _AnnouncementScreenBodyState();
}

class _AnnouncementScreenBodyState extends State<AnnouncementScreenBody> {
  @override
  Widget build(BuildContext context) {
    return (widget.announcements == null || widget.announcements!.isEmpty)
        ? Container(
      padding:  EdgeInsets.symmetric(vertical: 30.sp),
            child:  Text(AppString.noAnnouncement,
              textAlign: TextAlign.center,
              style: appStyles.noDataTextStyle(),
            ),
          )
        : ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding:  EdgeInsets.symmetric(vertical: 12.sp),
            scrollDirection: Axis.vertical,
            itemCount: widget.announcements!.length,
            itemBuilder: (context, index) {
              String? title = widget.announcements?[index].title;
              String? content = widget.announcements?[index].content;
              var doc = parse(content); //Remove HTML tags from String
              String publishedAt = widget.announcements![index].publishedAt ?? "";

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  color: AppColors.appWhite,
                  elevation: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('$title',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 350.sp,
                              child: ReadMoreText(
                                doc.documentElement!.text,
                                trimLines: 3,
                                trimCollapsedText: AppString.readMore,
                                trimExpandedText: AppString.readLess,
                                trimMode: TrimMode.Line,
                                moreStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:AppColors.appBlue),
                                lessStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.appBlue),
                                style: const TextStyle(
                                    fontSize: 16, color:AppColors.appBlack),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [Text(publishedAt,style: const TextStyle(color:AppColors.appGrey),)],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
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
