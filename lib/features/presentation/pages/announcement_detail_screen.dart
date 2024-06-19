import 'package:html/parser.dart';
import '../../../imports.dart';

class AnnouncementDetailScreen extends StatefulWidget {
  final int? postId;
  const AnnouncementDetailScreen({Key? key, this.postId}) : super(key: key);
  @override
  State<AnnouncementDetailScreen> createState() =>
      _AnnouncementDetailScreenState();
}

class _AnnouncementDetailScreenState extends State<AnnouncementDetailScreen> {
  SinglePostViewLikeBloc bloc = SinglePostViewLikeBloc();

  @override
  void initState() {
    super.initState();
    bloc.add(FetchSinglePostEvent(mContext: context, postId: widget.postId ?? 0));}

  @override
  Widget build(BuildContext context) {
    return ContainerFirst(
        contextCurrentView: context,
        isSingleChildScrollViewNeed: false,
        isListScrollingNeed: true,
        isFixedDeviceHeight: true,
        appBarHeight: 50.sp,
        appBar: const CommonAppBar(
          title: AppString.announcement,
          icon: WorkplaceIcons.backArrow,
        ),
        containChild:
            BlocBuilder<SinglePostViewLikeBloc, SinglePostViewLikeState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is SinglePostViewLikeLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return (bloc.singlePostData2 == null)
                ?  Center(
                    child: Text(AppString.noAnnouncement,
                      style: appStyles.noDataTextStyle(),
                  ))
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      color: AppColors.appWhite,
                      elevation: 0,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${bloc.singlePostData2!.title}',
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
                                  child: Text(
                                    parse(bloc.singlePostData2!.content).body!.text.trim(),
                                    style: const TextStyle(fontSize: 16, color: AppColors.appBlack),
                                  ),
                                  // to show Read more button
                                  // ReadMoreText(
                                  //   parse(bloc.singlePostData2!.content).body!.text.trim(),
                                  //   trimLines: 3,
                                  // trimCollapsedText: AppString.readMore,
                                  // trimExpandedText: AppString.readLess,
                                  //   trimMode: TrimMode.Line,
                                  //   moreStyle: const TextStyle(
                                  //       fontWeight: FontWeight.bold,
                                  //       color: Colors.blue),
                                  //   lessStyle: const TextStyle(
                                  //       fontWeight: FontWeight.bold,
                                  //       color: Colors.blue),
                                  //   style: const TextStyle(
                                  //       fontSize: 16, color: Colors.black),
                                  // ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${bloc.singlePostData2!.publishedAt}',
                                      style: const TextStyle(color: AppColors.appGrey),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
          },
        ));
  }
}
