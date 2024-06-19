import 'package:html/parser.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:workplace/imports.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  FeedBloc bloc = FeedBloc();
  SinglePostViewLikeBloc singlePostViewLikeBloc = SinglePostViewLikeBloc();
  bool isShowLoader = true;
  bool isPullToRefresh = false;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Future<void> onRefresh() async {
    if (!isPullToRefresh) {
      isPullToRefresh = true;
      bloc.add(FetchFeedDataEvent(mContext: context));
      await Future.delayed(const Duration(milliseconds: 4000));
      isPullToRefresh = false;
      refreshController.refreshCompleted();
    }
  }

  // for pagination load more data
  Future<void> onLoad() async {
    bloc.add(FetchFeedDataOnLoadEvent(mContext: context));
    await Future.delayed(const Duration(seconds: 5));
    refreshController.loadComplete();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerFirst(
        contextCurrentView: context,
        isSingleChildScrollViewNeed: false,
        isFixedDeviceHeight: true,
        isListScrollingNeed: true,
        appBarHeight: 50,
        appBar: DetailsScreenAppBar(
          title: AppString.posts,
        ),
        containChild:
            BlocBuilder<SinglePostViewLikeBloc, SinglePostViewLikeState>(
          bloc: singlePostViewLikeBloc,
          builder: (context, singleState) {
            if (singleState is PostLikeDoneState) {
              bloc.add(UpdateLikeCount(
                  liked: singleState.liked, index: singleState.index));
            }
            return BlocBuilder<FeedBloc, FeedState>(
              bloc: bloc,
              builder: (context, state) {
                if (state is FeedInitialState) {
                  bloc.add(FetchFeedDataEvent(mContext: context));
                }
                if (state is FeedLoadingState) {
                  if (isShowLoader) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.appBlueA),
                    );
                  }
                }
                return (bloc.feedPostList.isEmpty)
                    ? Center(
                        child: Text(
                          AppString.noPosts,
                          style: appStyles.noDataTextStyle(),
                        ),
                      )
                    :
                    SmartRefresher(
                        controller: refreshController,
                        enablePullUp: true,
                        enablePullDown: true,
                        onRefresh: onRefresh,
                        onLoading: onLoad,
                        footer: const ClassicFooter(
                          loadStyle: LoadStyle.ShowWhenLoading,
                        ),
                        child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(
                                bottom: 60, left: 4, right: 4),
                            scrollDirection: Axis.vertical,
                            //itemCount: homePost.length,
                            itemCount: bloc.feedPostList.length,
                            itemBuilder: (context, index) {
                              //HomePostDataModel homePostData = homePost[index];
                              String? title = bloc.feedPostList[index].title;
                              var titleDoc = parse(title);
                              String? content =
                                  bloc.feedPostList[index].content;
                              var contentDoc = parse(content);

                              String bgColor =
                                  bloc.feedPostList[index].backgoundColor ??
                                      '000000';
                              String backgroundColor = bgColor[0] == '#'
                                  ? bgColor.substring(1, bgColor.length)
                                  : bgColor;

                              String txColor =
                                  bloc.feedPostList[index].textColor ??
                                      'FFFFFF';
                              String textColor = txColor[0] == '#'
                                  ? txColor.substring(1, txColor.length)
                                  : txColor;

                              return CustomPostView(
                                // postUserImage: homePostData.userImage,
                                // userName: homePostData.userName,
                                // userJobTitle: homePostData.userJobTitle,
                                // postText: homePostData.postText,
                                //customImageUrl: homePostData.customImageUrl,
                                //customTitleText: homePostData.customTitleText,
                                //customSubTitleText: homePostData.customSubTitleText,
                                // userImage: bloc.feedPostList[index].featuredImage,
                                postUserImage:
                                    bloc.feedPostList[index].profilePhoto,
                                userName: bloc.feedPostList[index].postBy,
                                userJobTitle:
                                    bloc.feedPostList[index].publishedAt,
                                customImageUrl:
                                    bloc.feedPostList[index].featuredImage,
                                customTitleText: titleDoc.documentElement!.text,
                                customSubTitleText:
                                    contentDoc.documentElement!.text,
                                postBgColor:
                                    Color(int.parse('0xFF$backgroundColor')),
                                postFontColor:
                                    Color(int.parse('0XFF$textColor')),
                                //belowPostText: homePostData.belowPostText,
                                //isCommentCount: homePostData.isCommentCount,
                                isLiked:
                                    bloc.feedPostList[index].isLike ?? false,
                                isLikeCount:
                                    bloc.feedPostList[index].likes ?? 0,
                                onClickFavIcon: (v) {
                                  isShowLoader = false;
                                  singlePostViewLikeBloc.add(
                                      SubmitLikeRequestEvent(
                                          mContext: context,
                                          postId:
                                              bloc.feedPostList[index].id ?? 0,
                                          index: index,
                                          liked: v));
                                },
                                onLikedCountRowCallBack: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  // Navigator.push(
                                  //   MainAppBloc.getDashboardContext,
                                  //   SlideRightRoute(
                                  //       widget: const PostLikedPeopleListScreen()),
                                  // );
                                },
                                onViewCommentClickCallBack: () {},
                                onMoreIconClickCallBack: () {},
                              );

                              // if (homePostData.postType == "onlyText") {
                              //   return HomePostCardWithTextView(
                              //     postUserImage: homePostData.userImage,
                              //     userName: homePostData.userName,
                              //     userJobTitle: homePostData.userJobTitle,
                              //     postText: homePostData.postText,
                              //     belowPostText: homePostData.belowPostText,
                              //     isCommentCount: homePostData.isCommentCount,
                              //     isLiked: homePostData.isLiked,
                              //     isLikeCount: homePostData.isLikeCount,
                              //     onTitleClickCallBack: () {
                              //       Navigator.push(
                              //         MainAppBloc.getDashboardContext,
                              //         SlideRightRoute(
                              //             widget: TeamMemberDetailScreen(
                              //           imageUrl: homePostData.userImage,
                              //           name: homePostData.userName,
                              //         )),
                              //       );
                              //     },
                              //     onMoreIconClickCallBack: () {
                              //       FocusScope.of(context).requestFocus(FocusNode());
                              //       showModalBottomSheet(
                              //           context: MainAppBloc.getDashboardContext,
                              //           builder: (context) => const MoreBottomSheetScreen(),
                              //           isScrollControlled: true,
                              //           shape: const RoundedRectangleBorder(
                              //               borderRadius: BorderRadius.vertical(
                              //                   top: Radius.circular(20))));
                              //     },
                              //     onLikedCountRowCallBack: () {
                              //       FocusScope.of(context).requestFocus(FocusNode());
                              //       Navigator.push(
                              //         MainAppBloc.getDashboardContext,
                              //         SlideRightRoute(
                              //             widget: const PostLikedPeopleListScreen()),
                              //       );
                              //     },
                              //     onViewCommentClickCallBack: () {
                              //       FocusScope.of(context).requestFocus(FocusNode());
                              //       Navigator.push(
                              //         MainAppBloc.getDashboardContext,
                              //         SlideRightRoute(widget: const CommentScreen()),
                              //       );
                              //     },
                              //     likeBuilder: (isLiked) {
                              //       final color = isLiked
                              //           ? const Color(0xFFE04035)
                              //           : Colors.grey.shade800;
                              //       return Icon(
                              //         isLiked ? Icons.favorite : Icons.favorite_outline_rounded,
                              //         color: color,
                              //         size: 24,
                              //       );
                              //     },
                              //     countBuilder: (count, isLiked, text) {
                              //       const color = Color(0xFF575757);
                              //       return Text(
                              //         text,
                              //         style: appStyles.likedCountTextTextStyle(texColor: color),
                              //       );
                              //     },
                              //     onTapLiked: (isLiked) async {
                              //       homePostData.isLiked = !homePostData.isLiked;
                              //       homePostData.isLikeCount = homePostData.isLiked
                              //           ? homePostData.isLikeCount + 1
                              //           : homePostData.isLikeCount - 1;
                              //       return homePostData.isLiked;
                              //     },
                              //   );
                              // }
                              // else if (homePostData.postType == "custom") {
                              //   return
                              //     CustomPostView(
                              //     postUserImage: homePostData.userImage,
                              //     userName: homePostData.userName,
                              //     userJobTitle: homePostData.userJobTitle,
                              //     postText: homePostData.postText,
                              //     customImageUrl: homePostData.customImageUrl,
                              //     customTitleText: homePostData.customTitleText,
                              //     customSubTitleText: homePostData.customSubTitleText,
                              //     belowPostText: homePostData.belowPostText,
                              //     isCommentCount: homePostData.isCommentCount,
                              //     isLiked: homePostData.isLiked,
                              //     // backgroundImage: "https://images.unsplash.com/photo-1553095066-5014bc7b7f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8d2FsbCUyMGJhY2tncm91bmR8ZW58MHx8MHx8&w=1000&q=80",
                              //     isLikeCount: homePostData.isLikeCount,
                              //     onTitleClickCallBack: () {
                              //       Navigator.push(
                              //         MainAppBloc.getDashboardContext,
                              //         SlideRightRoute(
                              //             widget: TeamMemberDetailScreen(
                              //           imageUrl: homePostData.userImage,
                              //           name: homePostData.userName,
                              //         )),
                              //       );
                              //     },
                              //
                              //     onMoreIconClickCallBack: () {
                              //       FocusScope.of(context).requestFocus(FocusNode());
                              //       showModalBottomSheet(
                              //           context: MainAppBloc.getDashboardContext,
                              //           builder: (context) => const MoreBottomSheetScreen(),
                              //           isScrollControlled: true,
                              //           shape: const RoundedRectangleBorder(
                              //               borderRadius: BorderRadius.vertical(
                              //                   top: Radius.circular(20))));
                              //     },
                              //     onViewCommentClickCallBack: () {
                              //       FocusScope.of(context).requestFocus(FocusNode());
                              //       Navigator.push(
                              //         MainAppBloc.getDashboardContext,
                              //         SlideRightRoute(widget: const CommentScreen()),
                              //       );
                              //     },
                              //     onLikedCountRowCallBack: () {
                              //       FocusScope.of(context).requestFocus(FocusNode());
                              //       Navigator.push(
                              //         MainAppBloc.getDashboardContext,
                              //         SlideRightRoute(
                              //             widget: const PostLikedPeopleListScreen()),
                              //       );
                              //     },
                              //     likeBuilder: (isLiked) {
                              //       final color = isLiked
                              //           ? const Color(0xFFE04035)
                              //           : Colors.grey.shade800;
                              //       return Icon(
                              //         isLiked ? Icons.favorite : Icons.favorite_outline_rounded,
                              //         color: color,
                              //         size: 24,
                              //       );
                              //     },
                              //     countBuilder: (count, isLiked, text) {
                              //       const color = Color(0xFF575757);
                              //       return Text(
                              //         text,
                              //         style: appStyles.likedCountTextTextStyle(texColor: color),
                              //       );
                              //     },
                              //     onTapLiked: (isLiked) async {
                              //       homePostData.isLiked = !homePostData.isLiked;
                              //       homePostData.isLikeCount = homePostData.isLiked
                              //           ? homePostData.isLikeCount + 1
                              //           : homePostData.isLikeCount - 1;
                              //       return homePostData.isLiked;
                              //     },
                              //   );
                              // }
                              // return HomePostCardWithImageView(
                              //   postUserImage: homePostData.userImage,
                              //   userName: homePostData.userName,
                              //   userJobTitle: homePostData.userJobTitle,
                              //   postImages: homePostData.postImages,
                              //   belowPostText: homePostData.belowPostText,
                              //   isCommentCount: homePostData.isCommentCount,
                              //   isLiked: homePostData.isLiked,
                              //   isLikeCount: homePostData.isLikeCount,
                              //   onTitleClickCallBack: () {
                              //     Navigator.push(
                              //       MainAppBloc.getDashboardContext,
                              //       SlideRightRoute(
                              //           widget: TeamMemberDetailScreen(
                              //         imageUrl: homePostData.userImage,
                              //         name: homePostData.userName,
                              //       )),
                              //     );
                              //   },
                              //   onMoreIconClickCallBack: () {
                              //     FocusScope.of(context).requestFocus(FocusNode());
                              //     showModalBottomSheet(
                              //         context: MainAppBloc.getDashboardContext,
                              //         builder: (context) => const MoreBottomSheetScreen(),
                              //         isScrollControlled: true,
                              //         shape: const RoundedRectangleBorder(
                              //             borderRadius:
                              //                 BorderRadius.vertical(top: Radius.circular(20))));
                              //   },
                              //   onLikedCountRowCallBack: () {
                              //     FocusScope.of(context).requestFocus(FocusNode());
                              //     Navigator.push(
                              //       MainAppBloc.getDashboardContext,
                              //       SlideRightRoute(widget: const PostLikedPeopleListScreen()),
                              //     );
                              //   },
                              //   onViewCommentClickCallBack: () {
                              //     FocusScope.of(context).requestFocus(FocusNode());
                              //     Navigator.push(
                              //       MainAppBloc.getDashboardContext,
                              //       SlideRightRoute(widget: const CommentScreen()),
                              //     );
                              //   },
                              //   countBuilder: (count, isLiked, text) {
                              //     const color = Color(0xFF575757);
                              //     return Text(
                              //       text,
                              //       style: appStyles.likedCountTextTextStyle(texColor: color),
                              //     );
                              //   },
                              //   onTapLiked: (isLiked) async {
                              //     homePostData.isLiked = !homePostData.isLiked;
                              //     homePostData.isLikeCount = homePostData.isLiked
                              //         ? homePostData.isLikeCount + 1
                              //         : homePostData.isLikeCount - 1;
                              //     return homePostData.isLiked;
                              //   },
                              // );
                            }),
                      );
              },
            );
          },
        ));
  }
}
