import 'package:workplace/imports.dart';

class MemberPostList extends StatefulWidget {
  const MemberPostList({super.key});

  @override
  State<MemberPostList> createState() => _MemberPostListState();
}

class _MemberPostListState extends State<MemberPostList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          itemCount: homePost.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.sp),
              child: getWidget(index: index),
            );
          }),
    );
  }

  Widget getWidget({required int index}) {
    HomePostDataModel homePostData = homePost[index];

    if (homePostData.postType == "onlyText") {
      return HomePostCardWithTextView(
        margin: EdgeInsets.zero,
        postUserImage: homePostData.userImage,
        userName: homePostData.userName,
        userJobTitle: homePostData.userJobTitle,
        postText: homePostData.postText,
        belowPostText: homePostData.belowPostText,
        isCommentCount: homePostData.isCommentCount,
        isLiked: homePostData.isLiked,
        isLikeCount: homePostData.isLikeCount,
        onMoreIconClickCallBack: () {
          FocusScope.of(context).requestFocus(FocusNode());
          showModalBottomSheet(
              context: context,
              builder: (context) => const MoreBottomSheetScreen(),
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))));
        },
        onLikedCountRowCallBack: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Navigator.push(
            context,
            SlideRightRoute(widget: const PostLikedPeopleListScreen()),
          );
        },
        onViewCommentClickCallBack: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Navigator.push(
            context,
            SlideRightRoute(widget: const CommentScreen()),
          );
        },
      );
    } else if (homePostData.postType == "custom") {
      return CustomPostView(
        margin: EdgeInsets.zero,
        postUserImage: homePostData.userImage,
        userName: homePostData.userName,
        userJobTitle: homePostData.userJobTitle,
        postText: homePostData.postText,
        customImageUrl: homePostData.customImageUrl,
        customTitleText: homePostData.customTitleText,
        customSubTitleText: homePostData.customSubTitleText,
        belowPostText: homePostData.belowPostText,
        isCommentCount: homePostData.isCommentCount,
        isLiked: homePostData.isLiked,
        // backgroundImage: "https://images.unsplash.com/photo-1553095066-5014bc7b7f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8d2FsbCUyMGJhY2tncm91bmR8ZW58MHx8MHx8&w=1000&q=80",
        isLikeCount: homePostData.isLikeCount,
        onMoreIconClickCallBack: () {
          FocusScope.of(context).requestFocus(FocusNode());
          showModalBottomSheet(
              context: context,
              builder: (context) => const MoreBottomSheetScreen(),
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))));
        },
        onViewCommentClickCallBack: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Navigator.push(
            context,
            SlideRightRoute(widget: CommentScreen()),
          );
        },
        onLikedCountRowCallBack: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Navigator.push(
            context,
            SlideRightRoute(widget: const PostLikedPeopleListScreen()),
          );
        },
      );
    }
    return HomePostCardWithImageView(
      margin: EdgeInsets.zero,
      postUserImage: homePostData.userImage,
      userName: homePostData.userName,
      userJobTitle: homePostData.userJobTitle,
      postImages: homePostData.postImages,
      belowPostText: homePostData.belowPostText,
      isCommentCount: homePostData.isCommentCount,
      isLiked: homePostData.isLiked,
      isLikeCount: homePostData.isLikeCount,
      onMoreIconClickCallBack: () {
        FocusScope.of(context).requestFocus(FocusNode());
        showModalBottomSheet(
            context: context,
            builder: (context) => const MoreBottomSheetScreen(),
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))));
      },
      onLikedCountRowCallBack: () {
        FocusScope.of(context).requestFocus(FocusNode());
        Navigator.push(
          context,
          SlideRightRoute(widget: const PostLikedPeopleListScreen()),
        );
      },
      onViewCommentClickCallBack: () {
        FocusScope.of(context).requestFocus(FocusNode());
        Navigator.push(
          context,
          SlideRightRoute(widget: CommentScreen()),
        );
      },
    );
  }
}
